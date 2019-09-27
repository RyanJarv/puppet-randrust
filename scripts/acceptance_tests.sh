#!/usr/bin/env bash
set -euo pipefail

bundle exec rake spec_clean
bundle exec kitchen test
