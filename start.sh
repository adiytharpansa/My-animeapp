#!/usr/bin/env bash
# My-animeapp static starter: serve dist/ in the foreground on PORT (default 3000).
# Writes deployment-output.json for the controller. Per-command timing via time -p.
set -euo pipefail
time -p cd "$(dirname "$0")"
/usr/bin/time -p pwd
PORT="${PORT:-3000}"
export PORT
/usr/bin/time -p bash -c 'echo "PORT=$PORT"'
PROJECT_ROOT="$(pwd)"
DIST_DIR="$PROJECT_ROOT/dist"
WEB_DIR="${OPENCODE_WEB_DIR:-/home/runner/work/_temp/omgithub-web}"
/usr/bin/time -p mkdir -p "$DIST_DIR" "$WEB_DIR"
/usr/bin/time -p test -f "$DIST_DIR/index.html"
/usr/bin/time -p ls -la "$DIST_DIR"
/usr/bin/time -p test -s "$DIST_DIR/index.html"
# Optional npm install/build when a package project exists (skipped for pure static).
if [ -f "$PROJECT_ROOT/package.json" ]; then
  /usr/bin/time -p npm install --no-audit --no-fund --prefix "$PROJECT_ROOT"
  if /usr/bin/time -p node -e "process.exit(require('$PROJECT_ROOT/package.json').scripts && require('$PROJECT_ROOT/package.json').scripts.build ? 0 : 1)"; then
    /usr/bin/time -p npm run build --prefix "$PROJECT_ROOT"
  fi
fi
# Publish deployment output (project + absolute built static dir inside project).
/usr/bin/time -p python3 -c "import json; json.dump({'project': '$PROJECT_ROOT', 'directory': '$DIST_DIR'}, open('$WEB_DIR/deployment-output.json', 'w'))"
/usr/bin/time -p cat "$WEB_DIR/deployment-output.json"
echo "Serving $DIST_DIR on 0.0.0.0:$PORT (foreground)"
# Foreground static server; controller reuses it while healthy.
/usr/bin/time -p python3 -u -m http.server "$PORT" --directory "$DIST_DIR" --bind 0.0.0.0
