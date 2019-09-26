#!/usr/bin/env bash
set -euo pipefail

bundle exec pdk validate metadata yaml puppet tasks
bundle exec pdk test unit
