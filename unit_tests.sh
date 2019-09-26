#!/usr/bin/env
set -euo pipefail

bundle exec pdk validate
bundle exec pdk test unit