require "redis"
require "json"

start_time = Time.now.to_f

old_redis = Redis.new(url: ENV.fetch('SIDEKIQ_OLD_REDIS_URL'))
new_redis = Redis.new(url: ENV.fetch('SIDEKIQ_NEW_REDIS_URL'))

actual_run = (ENV['ACTUAL_RUN'].to_s.downcase == 'true') # actutally migrate keys
clean_up = (ENV['CLEAN_UP'].to_s.downcase == 'true') # clean up keys in old redis (only applies if actual_run is also true)
debug = (ENV['DEBUG'].to_s.downcase == 'true')

puts "Migrating from #{old_redis} to #{new_redis}"
puts "=== DRY RUN ===" unless actual_run

old_redis.smembers('queues').each do |q|
  puts "Migrating queue #{q}..."

  moved_jobs_counter = Hash.new(0)
  rqn = "queue:#{q}"

  if actual_run and clean_up
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
      new_redis.lpush(rqn, job_json) if actual_run
      moved_jobs_counter[JSON.parse(job_json)['class']] += 1 if actual_run
    end
  end

  puts "Queue [#{q}] moved:"
  moved_jobs_counter.each { |k, c| puts "  #{k} => #{c}" }
  puts "Queue [#{q}] remaining_jobs: #{old_redis.llen(rqn)}"
end

%w[retry schedule dead].each do |set_type|
  puts "Migrating set #{set_type}..."

  moved_jobs_counter = Hash.new(0)
  set_jobs = old_redis.zrange(set_type, 0, -1, with_scores: true)

  set_jobs.each do |job_json, run_at|
    puts job_json if debug
    new_redis.zadd(set_type, run_at, job_json) if actual_run
    old_redis.zrem(set_type, job_json) if actual_run and clean_up
    moved_jobs_counter[JSON.parse(job_json)['class']] += 1 if actual_run
  end

  puts "JobSet [#{set_type}] moved:"
  moved_jobs_counter.each { |k, c| puts "  #{k} => #{c}" }
  puts "JobSet [#{set_type}] remaining jobs: #{old_redis.zrange(set_type, 0, -1).size}"
end

time_taken_ms = (1000 * (Time.now.to_f - start_time)).ceil
puts "Completed migration in #{time_taken_ms} milliseconds."
