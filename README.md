# telegram-github-changes
Git bot for sending messages about github changes

# Config
By file `config.yml` with data
```
telegram_bot_token: token
github_user: user
github_user_password: pasword
repos: [nodejs/node]
```

# Docker build
```
docker build -t telegram-github-changes-bot .
docker run -itd --restart=always --name telegram-github-changes-bot telegram-github-changes-bot

```