# telegram-github-changes

Telegram bot for sending messages about github changes

## Config

By file `config.json` with data

```json
{
  "github_api_endpoint": "https://my-gitea-server.com/api/v1",
  "github_web_url": "https://my-gitea-server.com",
  "github_token": "my-personal-access-token",
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

**Note:** Authentication uses the `token` prefix (`Authorization: token <TOKEN>`),
which is compatible with Gitea and GitHub classic personal access tokens.
GitHub fine-grained personal access tokens are not supported.

## Docker compose

```bash
docker compose up -d
```

## How to update

```bash
git pull --prune
docker compose down
docker compose up -d
```
