#!/bin/sh

projects="4cade 4live 4sports a2fc adventure-replay anti-m dhrslide million-perfect-letters million-perfect-tiles passport pitch-dark pitch-darker probable untitled-word-game untitled-word-game-pro wizard-replay word-clock"

for project in $projects; do
    podman build --build-arg-file "./etc/$project.env" -t "$project" .
    podman run -it --mount "type=bind,src=$(pwd),target=/mnt/output" "$project"
done