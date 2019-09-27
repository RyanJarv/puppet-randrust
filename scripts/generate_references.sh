#!/usr/bin/env bash
set -euo pipefail

puppet strings generate --out REFERENCE.md --format markdown manifests/config.pp manifests/init.pp manifests/install.pp manifests/service.pp
