# 4builder

If you are impatient like me to test the new features of the wonderful projects of **a2_4am** and **qkumba** (over [there](https://github.com/a2-4am?tab=repositories)) before the official release, this builder is for you.

Run one of the commands below and after one minute or two you get a container image with the `HDV`/`DSK`/`PO` corresponding at the root of it.

All you have to do is extract the file and enjoy it !!

```shell
podman build --build-arg-file ./etc/4cade.env -t 4cade .
podman build --build-arg-file ./etc/4live.env -t 4live .
podman build --build-arg-file ./etc/4sports.env -t 4sports .
podman build --build-arg-file ./etc/a2fc.env -t a2fc .
podman build --build-arg-file ./etc/adventure-replay.env -t adventure-replay .
podman build --build-arg-file ./etc/anti-m.env -t anti-m .
podman build --build-arg-file ./etc/dhrslide.env -t dhrslide .
podman build --build-arg-file ./etc/million-perfect-letters.env -t million-perfect-letters .
podman build --build-arg-file ./etc/million-perfect-tiles.env -t million-perfect-tiles .
podman build --build-arg-file ./etc/passport.env -t passport .
podman build --build-arg-file ./etc/pitch-dark.env -t pitch-dark .
podman build --build-arg-file ./etc/pitch-darker.env -t pitch-darker .
podman build --build-arg-file ./etc/untitled-word-game.env -t untitled-word-game .
podman build --build-arg-file ./etc/untitled-word-game-pro.env -t untitled-word-game-pro .
podman build --build-arg-file ./etc/wizard-replay.env -t wizard-replay .
podman build --build-arg-file ./etc/word-clock.env -t word-clock .
```
