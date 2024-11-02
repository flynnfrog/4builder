#!/bin/sh

podman build -f builder.Dockerfile -t 4builder .
for file in etc/*.env; do 
    if [ -f "$file" ]; then 
        project=$(basename "$file" .env) 
        podman build -f final.Dockerfile --build-arg-file ./etc/$project.env -t $project .
        podman image prune -f --filter label=stage=4builder
        podman run --rm --mount "type=bind,src=$(pwd),target=/mnt/output" "$project"
        podman image prune -a -f --filter label=stage=4final
    fi 
done
