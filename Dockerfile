FROM node:10-alpine
RUN \
    apk -U upgrade && \
    apk add -t \
        build-dependencies \
        git \
        curl-dev \
        wget \
        ruby-dev \
        build-base && \ 
    apk add \
        tzdata \
        ruby \
	ruby-io-console \
	ruby-json \
	ruby-etc \
	ruby-bigdecimal && \
  git clone https://github.com/standardnotes/web.git /stdnotes && \
  gem install -N \
      rails \
      bundler:1.17.1 && \
  cd /stdnotes && \
  npm run build && \
  apk del build-dependencies && \
  rm -rf \
      /tmp/* \
      /var/cache/apk/* \
      /root/.gnupg \
      /root/.cache/ \
      /stdnotes/.git
EXPOSE 3000
WORKDIR /stdnotes
ENTRYPOINT ["bundle", "exec", "rails", "s"]
