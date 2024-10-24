# 4builder

If you are impatient like me to test the new features of the wonderful projects of **a2_4am** and **qkumba** (over [there](https://github.com/a2-4am?tab=repositories)) before the official release, this builder is for you.

Run one of the commands below and after one minute or two you get a container image with the `HDV`/`DSK`/`PO` corresponding at the root of it.

All you have to do is extract the file and enjoy it !!

```shell
podman build --build-arg-file 4cade.env -t 4cade .
podman build --build-arg-file 4live.env -t 4live .
podman build --build-arg-file 4sports.env -t 4sports .
podman build --build-arg-file a2fc.env -t a2fc .
podman build --build-arg-file adventure-replay.env -t adventure-replay .
podman build --build-arg-file anti-m.env -t anti-m .
podman build --build-arg-file dhrslide.env -t dhrslide .
podman build --build-arg-file million-perfect-letters.env -t million-perfect-letters .
podman build --build-arg-file million-perfect-tiles.env -t million-perfect-tiles .
podman build --build-arg-file passport.env -t passport .
podman build --build-arg-file pitch-dark.env -t pitch-dark .
podman build --build-arg-file pitch-darker.env -t pitch-darker .
podman build --build-arg-file untitled-word-game.env -t untitled-word-game .
podman build --build-arg-file untitled-word-game-pro.env -t untitled-word-game-pro .
podman build --build-arg-file wizard-replay.env -t wizard-replay .
podman build --build-arg-file word-clock.env -t word-clock .
```
