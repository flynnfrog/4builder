# 4builder

If you are impatient like me to test the new features of the wonderful projects of **a2_4am** and **qkumba** (over [there](https://github.com/a2-4am?tab=repositories)) before their official release, this builder is for you.

Run the commands below. After one minute or two you can grab your `DSK`/`HDV`/`PO` file from `build`.

```shell
podman build -f builder.Dockerfile -t 4builder .
podman build -f final.Dockerfile --build-arg-file ./etc/$PROJECT.env -t $PROJECT .
podman image prune -f --filter label=stage=4builder
podman run --rm --mount "src=$(pwd),target=/mnt/output,type=bind" $PROJECT
podman image prune -a -f --filter label=stage=4final
```

Possible values for `PROJECT`: `4cade`, `4live`, `4sports`, `a2fc`, `adventure-replay`, `anti-m`, `cover`, `dhrslide`, `fonts`, `million-perfect-letters`, `million-perfect-tiles`, `passport`, `pitch-dark`, `pitch-darker`, `probable`, `untitled-word-game`, `untitled-word-game-pro`, `wizard-replay`, `word-clock`.
