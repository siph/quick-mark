# quick-mark

This is dumb and you probably don't want to use it.

`quick-mark` is basically just an `ffmpeg` command wrapped with `nushell` and
packaged with `nix`. You can provide `quick-mark` a video file and an image to
apply it as a watermark. A positional expression may be optionally provided to
position the watermark, the default location is the bottom right corner of the
video.

## How to Use

### Nix

The best way to run this application is to use
[`nix`](https://nixos.org/download.html). `Nix` will include all the
dependencies needed to run the application.

```shell
nix run github:siph/quick-mark -- --help
```
