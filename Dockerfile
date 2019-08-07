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
  git clone --recursive https://github.com/standardnotes/web.git /stdnotes && \
  cd /stdnotes && \
  gem install -N \
      rails \
      bundler:1.17.1 && \
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
ENV EXTENSIONS_MANAGER_LOCATION=extensions/extensions-manager/dist/index.html
ENV BATCH_MANAGER_LOCATION=extensions/batch-manager/dist/index.min.html
COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
