#!/bin/sh
# https://myconfluence.llnl.gov/pages/viewpage.action?pageId=612845288&spaceKey=BOWTIE&title=Codex
sandbox-exec -f ~/.codex/codex.sh env HTTP_PROXY=http://localhost:3128 HTTPS_PROXY=http://localhost:3128 /opt/homebrew/bin/codex
