# telegram-github-changes

Git bot for sending messages about github changes

## Config

By file `config.json` with data

```json
{
  "github_user": "my-github-user",
  "github_user_password": "my-github-pass",
  "repos": [
    {
      "name": "MY-ORG/my-repo"
    },
    {
      "name": "MY-ORG/my-repo-without-tags",
      "skip_if_refs_not_found": true
    }
  ],
  "telegram_bot_token": "my-telegram-token"
}

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
