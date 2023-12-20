#!/usr/bin/env nu

# Watermark video with ffmpeg using the overlay functionality. The watermarked
# video will be created in the same directory as the source file.
#
# Refer to the ffmpeg documentation when using a custom overlay:
# http://ffmpeg.org/ffmpeg-filters.html#overlay-1
def main [
    --video: path, # Path to video
    --watermark: path, # Path to watermark image
    --overlay: string = "overlay=main_w-overlay_w-10:main_h-overlay_h-10", # Optional expression describing watermark location
] {

    # Apparently I have to parse this even though its a type. What is the
    # purpose of even using `path` as a type in the first place? (completions?)
    let output = [
        ($video | path parse | $in.parent) # root
        "/"
        $"marked_(date now | format date `%s`)_($video | path parse | $in.stem)" # filename
        "."
        ($video | path parse | $in.extension) # extension
    ] | str join

    (
        ffmpeg
        -i $video
        -i $watermark
        -filter_complex $overlay
        $output
    )
}
