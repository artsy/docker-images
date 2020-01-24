require "redis"
require "json"

start_time = Time.now.to_f

old_redis = Redis.new(url: ENV.fetch('SIDEKIQ_OLD_REDIS_URL'))
new_redis = Redis.new(url: ENV.fetch('SIDEKIQ_NEW_REDIS_URL'))

dry_run = (ENV['DRY_RUN'].to_s.downcase == 'true') # print a summary but don't migrate
clean_up = (ENV['CLEAN_UP'].to_s.downcase == 'true') # clean up keys in the old redis database
debug = (ENV['DEBUG'].to_s.downcase == 'true') # debug logging

puts "\nMigrating from #{ENV.fetch('SIDEKIQ_OLD_REDIS_URL')} to #{ENV.fetch('SIDEKIQ_NEW_REDIS_URL')}"
puts "\n=== DRY RUN ===" if dry_run
puts "\n\nMigrating queues..."
queues = old_redis.smembers('queues')
queues.each do |q|
  puts "\nMigrating queue #{q}..."

  moved_jobs_counter = Hash.new(0)
  rqn = "queue:#{q}"

  unless dry_run and clean_up
    old_redis.llen(rqn).times do
      job_json = old_redis.rpop(rqn)
      puts job_json if debug
      new_redis.lpush(rqn, job_json)
      moved_jobs_counter[JSON.parse(job_json)['class']] += 1
    end
  else
    queue_items = old_redis.lrange(rqn, 0, -1)
    queue_items.each do |job_json|
      puts job_json if debug
      new_redis.lpush(rqn, job_json) unless dry_run
      moved_jobs_counter[JSON.parse(job_json)['class']] += 1 unless dry_run
    end
  end

  puts "\nQueue [#{q}] moved:"
  moved_jobs_counter.each { |k, c| puts "  #{k} => #{c}" }
  puts "Queue [#{q}] remaining_jobs: #{old_redis.llen(rqn)}"
end

puts "Migrated #{queues.length} queues"

puts "\n\nMigrating sets..."
%w[retry schedule dead].each do |set_type|
  puts "\nMigrating set #{set_type}..."

  moved_jobs_counter = Hash.new(0)
  set_jobs = old_redis.zrange(set_type, 0, -1, with_scores: true)

  set_jobs.each do |job_json, run_at|
    puts job_json if debug
    new_redis.zadd(set_type, run_at, job_json) unless dry_run
    old_redis.zrem(set_type, job_json) unless dry_run or not clean_up
    moved_jobs_counter[JSON.parse(job_json)['class']] += 1 unless dry_run
  end

  puts "\nJobSet [#{set_type}] moved:"
  moved_jobs_counter.each { |k, c| puts "  #{k} => #{c}" }
  puts "JobSet [#{set_type}] remaining jobs: #{old_redis.zrange(set_type, 0, -1).size}"
end

puts "\n\nMigrating stats..."
stats = old_redis.keys("stat:*")
stats.each do |k|
  v = old_redis.get(k)
  puts "#{k} #{v}" if debug
  new_redis.set(k, v) unless dry_run
  old_redis.del(k) unless dry_run or not clean_up
end
puts "Migrated #{stats.length} stats"

time_taken_ms = (1000 * (Time.now.to_f - start_time)).ceil
puts "\n\nCompleted migration in #{time_taken_ms} milliseconds.\n\n"
