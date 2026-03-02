# Notification Utilities for Claude Workflows

## Play a Sound

**Native Linux:**
- `paplay file.wav` — PulseAudio (most common)
- `aplay file.wav` — ALSA
- `mpg123 file.mp3` — MP3 playback

**WSL (easiest):**
```bash
powershell.exe -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\ding.wav').PlaySync()"
```

---

## Send an Email

- `msmtp` — lightweight SMTP client, easy to configure with Gmail/etc.
- `sendmail` / `postfix` — full MTA (heavier)
- `curl --url smtps://smtp.gmail.com:465 ...` — raw SMTP via curl
- `mailx` with SMTP config

`msmtp` is the easiest for scripting: install it, configure `~/.msmtprc` with credentials, then:
```bash
echo "body" | msmtp recipient@example.com
```

---

## Push Notification to Phone

**`ntfy.sh`** — open source, simple HTTP pub-sub push notifications to your phone or desktop.

### Setup (one-time)

1. Install the **ntfy app** on your phone:
   - Android: [Google Play](https://play.google.com/store/apps/details?id=io.heckel.ntfy) or [F-Droid](https://f-droid.org/en/packages/io.heckel.ntfy/) (no Google services required via F-Droid)
   - iOS: [App Store](https://apps.apple.com/us/app/ntfy/id1625396347)
2. Open the app and **subscribe to a topic** — just type any name (e.g., `my-claude-alerts-7f3k2p`)
3. Send notifications to that topic from any script:

```bash
curl -d "Claude finished task" ntfy.sh/my-claude-alerts-7f3k2p
```

Notifications appear on your lock screen and notification tray like any other push notification.

### Pricing

- **Free (hosted):** No account needed. Pick a hard-to-guess topic name — topics are public to anyone who knows the name, so obscurity is the only security.
- **Paid ($5–25/month):** Reserves your topic name, higher message limits.
- **Self-hosted (free, unlimited):** Run your own server via Docker — fully open source (Apache 2.0 / GPLv2):
  ```bash
  docker run -p 80:80 -it binwiederhier/ntfy serve
  ```

### Other options

- **Pushover** — small one-time fee, very reliable, clean API
- **Gotify** — self-hosted
- **SimplePush** — `curl "https://api.simplepush.io/send/YOUR_KEY/title/message"`
- **Apprise** — open source library/CLI that supports 80+ backends including ntfy, Gotify, SNS, Telegram, Slack, etc.

---

## Integration with Claude Code Hooks

Claude Code supports hooks that run shell commands on events. Configure in `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "curl -s -d \"$CLAUDE_NOTIFICATION\" ntfy.sh/your-topic"
          }
        ]
      }
    ]
  }
}
```

The `Notification` hook fires when Claude needs your attention (e.g., after a long task completes). The `$CLAUDE_NOTIFICATION` env var contains the message text.

### Available Hook Events

- `Notification` — Claude wants to alert the user
- `PostToolUse` — fires after any tool call completes
- `PreToolUse` — fires before a tool call

### Example: Sound + Phone Push on Notification

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -c \"(New-Object Media.SoundPlayer 'C:\\Windows\\Media\\ding.wav').PlaySync()\" & curl -s -d \"$CLAUDE_NOTIFICATION\" ntfy.sh/your-topic"
          }
        ]
      }
    ]
  }
}
```
