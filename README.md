# 4builder

If you are impatient like me to test the new features of the wonderful projects of **a2_4am** and **qkumba** (over [there](https://github.com/a2-4am?tab=repositories)) before their official release, this builder is for you.

Run the commands below. After one minute or two you can grab your `HDV`/`DSK`/`PO` file from `build`.

```shell
podman build --build-arg-file ./etc/$PROJECT.env -t $PROJECT .
podman run -it --mount "src=$(pwd),target=/mnt/output,type=bind" $PROJECT
```

Possible values for `PROJECT`: `4cade`, `4live`, `4sports`, `a2fc`, `adventure-replay`, `anti-m`, `dhrslide`, `million-perfect-letters`, `million-perfect-tiles`, `passport`, `pitch-dark`, `pitch-darker`, `untitled-word-game`, `untitled-word-game-pro`, `wizard-replay`, `word-clock`.
