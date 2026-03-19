#!/usr/bin/env bash

set -euo pipefail

# Try to read from stdin with a timeout
# If successful, we're being called as a hook
if PAYLOAD=$(timeout 0.1 cat 2>/dev/null) && [ -n "$PAYLOAD" ]; then
    # Called as hook - parse the JSON payload
    HOOK_NAME=$(echo "$PAYLOAD" | jq -r '.hook_event_name' 2>/dev/null)

    # If jq returns null or empty, default to 'stop'
    if [ -z "$HOOK_NAME" ] || [ "$HOOK_NAME" = "null" ]; then
        HOOK_NAME="stop"
    fi
else
    # Called from command line or no stdin data
    HOOK_NAME="manual"
fi

# Determine project name from environment or git
if [ -n "${CLAUDE_PROJECT_DIR:-}" ]; then
    PROJECT="${CLAUDE_PROJECT_DIR##*/}"
elif git rev-parse --git-dir >/dev/null 2>&1; then
    PROJECT=$(basename "$(git rev-parse --show-toplevel)")
else
    PROJECT="unknown"
fi

SCRIPT_DIR="$HOME/utils/gen-ai-dev-kit/config/scripts"
FLAG="$HOME/.claude/flags/hook/stop"
SOUND="$SCRIPT_DIR/../sounds/minor_caution_alarm_from_car/784980__soundsofthemachine__minor_caution_alarm_from_car.mp3"

if [ -f "$FLAG" ]; then
    mpg123 -q "$SOUND"

    curl -d "Claude | ${PROJECT} | ${HOOK_NAME}" ntfy.sh/${NTFY_CLAUDE_CODE}

    # Send Windows toast notification
    powershell.exe -NoProfile -Command "
\$AppId = 'Claude Code'
\$Title = 'Claude | ${PROJECT}'
\$Message = '${HOOK_NAME}'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
\$Xml = New-Object Windows.Data.Xml.Dom.XmlDocument
\$Xml.LoadXml(\"<toast><visual><binding template='ToastGeneric'><text>\$Title</text><text>\$Message</text></binding></visual></toast>\")
\$Toast = [Windows.UI.Notifications.ToastNotification]::new(\$Xml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(\$AppId).Show(\$Toast)
" || true
fi

exit


