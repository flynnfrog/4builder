#!/bin/sh

projects="4cade 4live 4sports a2fc adventure-replay anti-m dhrslide million-perfect-letters million-perfect-tiles passport pitch-dark pitch-darker probable untitled-word-game untitled-word-game-pro wizard-replay word-clock"

podman build -f builder.Dockerfile -t 4builder .
for project in $projects; do
    podman build -f final.Dockerfile --build-arg-file ./etc/$project.env -t $project .
    podman image prune -f --filter label=stage=4builder
    podman run --rm --mount "type=bind,src=$(pwd),target=/mnt/output" "$project"
    podman image prune -a -f --filter label=stage=4final
done