#!/usr/bin/env bash

set -euo pipefail

# Information from the event
# WARNING: Won't workoutside of the environment
PAYLOAD=$(cat)
HOOK_NAME=$(echo $PAYLOAD | jq -r '.hook_event_name')


SCRIPT_DIR="$HOME/utils/gen-ai-dev-kit/config/scripts"
FLAG="$HOME/.claude/flags/hook/stop"
SOUND="$SCRIPT_DIR/../sounds/minor_caution_alarm_from_car/784980__soundsofthemachine__minor_caution_alarm_from_car.mp3"

PROJECT="${CLAUDE_PROJECT_DIR##*/}"

if [ -f "$FLAG" ]; then
    mpg123 -q "$SOUND"
    curl -d "Claude | ${PROJECT} | ${HOOK_NAME}" ntfy.sh/${NTFY_CLAUDE_CODE}
fi
