FROM ruby:2.3.3

# Install NodeJS apt sources
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Add Chrome source
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update -qq \
  && apt-get install -y nodejs libnss3 libgconf-2-4 google-chrome-stable \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Disable Chrome sandbox
RUN sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' "/opt/google/chrome/google-chrome"

RUN gem update --system \
  && gem install bundler

RUN npm install -g yarn
