# 4builder

If you are impatient like me to test the new features of the wonderful projects of **a2_4am** and **qkumba** (over [there](https://github.com/a2-4am?tab=repositories)) before the official release, this builder is for you.
Run one of the commands below and after one minute or two you get a container image with the `HDV`/`DSK`/`PO` corresponding at the root of it. All you have to do is extract the file and enjoy it !!

```shell
podman build --build-arg REPOSITORY=4cade --build-arg IMAGE=4cade.hdv -t 4cade .
podman build --build-arg REPOSITORY=4live --build-arg IMAGE=4live.dsk --build-arg BRANCH=master -t 4live .
podman build --build-arg REPOSITORY=4sports --build-arg IMAGE=4sports.hdv -t 4sports .
podman build --build-arg REPOSITORY=a2fc.system --build-arg IMAGE=a2fc.po --build-arg BRANCH=master -t a2fc .
podman build --build-arg REPOSITORY=adventure-replay --build-arg IMAGE=ADVENTUREREPLAY.hdv -t adventure-replay .
podman build --build-arg REPOSITORY=anti-m --build-arg IMAGE=anti-m.dsk --build-arg BRANCH=master -t anti-m .
podman build --build-arg REPOSITORY=dhrslide --build-arg IMAGE=dhrslide.po --build-arg BRANCH=master -t dhrslide .
podman build --build-arg REPOSITORY=million-perfect-letters --build-arg IMAGE=million.po --build-arg BRANCH=master --build-arg TARGET=dsk -t million-perfect-letters .
podman build --build-arg REPOSITORY=million-perfect-tiles --build-arg IMAGE=tiles.po --build-arg TARGET=dsk -t million-perfect-tiles .
podman build --build-arg REPOSITORY=passport --build-arg IMAGE=passport.dsk --build-arg BRANCH=master -t passport .
podman build --build-arg REPOSITORY=pitch-dark --build-arg IMAGE="Pitch Dark.hdv" --build-arg BRANCH=master --build-arg TARGET=dsk -t pitch-dark .
podman build --build-arg REPOSITORY=pitch-darker --build-arg IMAGE="Pitch Darker.hdv" --build-arg BRANCH=master --build-arg TARGET=dsk --build-arg BEFORE_CMD="git clone -b master https://github.com/a2-4am/pitch-dark.git" -t pitch-darker .
podman build --build-arg REPOSITORY=untitled-word-game --build-arg IMAGE=untitled.dsk --build-arg TARGET=dist -t untitled-word-game .
podman build --build-arg REPOSITORY=untitled-word-game-pro --build-arg IMAGE="Untitled Word Game Pro.dsk" --build-arg TARGET=dist -t untitled-word-game-pro .
podman build --build-arg REPOSITORY=wizard-replay --build-arg IMAGE=wizard-replay.hdv -t wizard-replay .
podman build --build-arg REPOSITORY=word-clock --build-arg IMAGE=word-clock-1.2.dsk --build-arg TARGET=dist -t word-clock .
```
