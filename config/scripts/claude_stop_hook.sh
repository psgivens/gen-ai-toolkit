#!/usr/bin/env bash

set -euo pipefail

# Information from the event
# WARNING: Won't workoutside of the environment
PAYLOAD=$(cat)
HOOK_NAME=$(echo $PAYLOAD | jq -r '.hook_event_name')


SCRIPT_DIR="$HOME/utils/gen-ai-dev-kit/config/scripts"
FLAG="$HOME/.claude/flags/hook/stop"
SOUND="$SCRIPT_DIR/../sounds/minor_caution_alarm_from_car/784980__soundsofthemachine__minor_caution_alarm_from_car.mp3"
SOUND1="$SCRIPT_DIR/../sounds/magical-airy-transition-riser / 848208__mikiko850__magical-airy-transition-riser.mp3"
SOUND2="$SCRIPT_DIR/../sounds/rnb-kick-2-heart-down-deep/ 848060__cat-fox_alex__rnb-kick-2-heart-down-deep.mp3"

PROJECT="${CLAUDE_PROJECT_DIR##*/}"

if [ -f "$FLAG" ]; then
    mpg123 -q "$SOUND1"
    curl -d "Claude | ${PROJECT} | ${HOOK_NAME}" ntfy.sh/${NTFY_CLAUDE_CODE}
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


