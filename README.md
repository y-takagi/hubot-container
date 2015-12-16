# Hubot + Container
MacOSX 上から Docker Machine で作成した Docker Host 環境を想定しています。

## Create new hubot project

```
docker-compose run --rm bot yo --no-insight hubot
```

## Run
既存の hubot プロジェクトがある場合は、docker-compose.yml があるディレクトリに配置する。
その後、ディレクトリ名を`app`に変更するか、docker-compose.yml のvolumes 部分を書き換える。

```
docker-compose run --rm bot
```

## Slack integration
Slack に通知する bot を hubot で作る/動かす手順。

### hubot-slack アダプタをインストール

```
docker-compose run --rm bot npm install hubot-slack --save
```

### docker-compose.yml を編集

```docker-compose.yml
slackbot:
  image: hubotcontainer_bot
  environment:
    - HUBOT_SLACK_TOKEN
    - HUBOT_SLACK_TEAM
    - HUBOT_SLACK_BOTNAME
    - REDIS_URL=redis://redis:6379/hubot
  command: bin/hubot --adapter slack
  volumes:
    - ./app:/app # 適宜変更
  links:
    - redis
```

docker-compose.yml の environment 部分も適宜変更。
ローカルでテストする場合は、

```
HUBOT_SLACK_TOKEN=xoxb-1234-5678-91011-00e4dd
```

とする。
