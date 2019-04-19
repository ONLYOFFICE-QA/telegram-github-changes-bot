# telegram-github-changes

Git bot for sending messages about github changes

## Config

By file `config.yml` with data

```bash
telegram_bot_token: token
github_user: user
github_user_password: pasword
repos: [nodejs/node]
```

## Docker compose

```bash
docker-compose up -d
```

## How to update

```bash
git pull --prune
docker-compose up -d --no-deps --build app
```