# imgbrd-grabber

[![Docker Pulls](https://img.shields.io/docker/pulls/dannixon/imgbrd-grabber)](https://hub.docker.com/r/dannixon/imgbrd-grabber)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/dannixon/imgbrd-grabber)](https://hub.docker.com/r/dannixon/imgbrd-grabber/builds)

[imgbrd-grabber](https://github.com/Bionus/imgbrd-grabber) running in Docker.

## Usage

The following is a good starting point.
You may wish to also mount `/config` if you wish to persist configurations (in which case the `/data` volume may be used as a more intuitive save location).

```sh
#!/bin/sh

XAUTH_AUTH_FILE=$(xauth info | grep 'Authority file' | awk '{split($0,a," "); print a[3]}')

docker run \
  --rm \
  --env DISPLAY="$DISPLAY" \
  --volume '/tmp/.X11-unix:/tmp/.X11-unix:ro' \
  --volume "$XAUTH_AUTH_FILE:/root/.Xauthority:ro" \
  --volume "$PWD:/root/Desktop/Grabber" \
  dannixon/imgbrd-grabber:latest
```
