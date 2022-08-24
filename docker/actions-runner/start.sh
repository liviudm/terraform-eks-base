#!/bin/bash

set -eo pipefail

cd /home/docker/actions-runner || exit

./config.sh --url https://github.com/DigitalMOB2/infrastructure --labels "${RUNNER_LABELS}" --token "${RUNNER_TOKEN}"

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token "${RUNNER_TOKEN}"
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo "================================================="
echo "|| Welcome to DigitalMOB GitHub Actions Runner ||"
echo "================================================="

./run.sh & wait $!
