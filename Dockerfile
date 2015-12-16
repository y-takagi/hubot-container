FROM node:5.2.0

RUN apt-get update \
 && apt-get install -y rsync --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g hubot yo generator-hubot coffee-script

# npm requires non-root user
RUN useradd -m -s /bin/bash -U hubot

COPY docker-entrypoint.sh /

VOLUME /app

USER hubot

ENV tmp_dir /home/hubot/tmp
RUN mkdir $tmp_dir

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["bin/hubot"]
