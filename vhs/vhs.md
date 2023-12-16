# Digitizing and Enhancing VHS Tapes

## Hardware

I used a VCR that had an S-Video output to get slightly higher quality as opposed to RCA (composite) output and tried several cheap capture devices from Amazon.  This generic [device](https://www.amazon.com/gp/product/B06X42H9VZ) created color distortions and the [Elgato USB 2.0](https://www.amazon.com/gp/product/B0029U2YSA) was not supported on M1/M2 macs even though it was highly recommended.  Basically any low end capture device can cause artifacts and rainbow effects.  Your choice of VCR will also impact quality. After some research, I settled on the one listed below as a good compromise between price and quality.

* [ClearClick Video to USB 1080P Audio Video Capture & Live Streaming Device VIDEO2USB](https://www.clearclick.com/products/video-to-usb-audio-video-capture-live-streaming-device) @ [Amazon](https://www.amazon.com/gp/product/B0BVDVZGR2) ~$65
* [JVC HR-S3600U](https://support.jvc.com/consumer/product.jsp?modelId=MODL022105&pathId=49&page=1&archive=true) @ [eBay](https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2332490.m570.l1313&_nkw=JVC+HR-S3600U&_sacat=0) ~$75

## Software

* [OBS - Open Broadcaster Software](https://obsproject.com/) - for source capture
* [FFmpeg](https://ffmpeg.org/) - for general video manipulation
* [Topaz Video AI](https://www.topazlabs.com/topaz-video-ai) - for AI enhancement including sharpening and noise reduction
* [iMovie](https://support.apple.com/imovie) - to create video titles and subsection dividers
* [VLC Player](https://www.videolan.org/vlc/) - video player
* [Quicktime Player](https://support.apple.com/downloads/quicktime) - video player that is good for checking chapter timestamps

## Hardware Setup

VCR -> (S-Video) -> ClearClick -> (USB-C) -> PC/Mac

## Capturing Raw Footage

I followed a great article by Tim Ford on how to setup OBS for lossless digitizing VHS tapes [here](https://timfordphoto.com/lossless-422-digitizing-of-video-tapes-using-obs/).  
I am archiving this page so that I never lose the instructions [here](lossless.4.2.2.digitizing.of.video.tapes.using.obs.tim.ford.photography.and.videography.pdf).

This footage will be referred to as ```raw.avi```.

## AI Enhance VHS Raw Footage

Select your source footage (```raw.avi```)

Topaz Video AI Settings:
* Video In: 720 x 480 @ 29.97 FPS
* Video Out: Resolution: 720 x 480 (Original), Frame Rate: 29.970 (Original)
* Enhancement Video Type: Progressive, AI Model: Iris - Face Enhance/LQ-MQ Video, Parameters: Auto, Add Noise: 0, Recover Original Detail: 20
* Output Settings Video: Encoder: H264, Profile: High, Bitrate: Auto 
* Output Settings Audio: Convert, Codec: AAC, Bitrate: 320k
* Output Settings Container: mp4
* Include Live Preview: unchecked 

I would suggest using AI Model Iris or Artemis since both are designed for low quality input sources.  You can read more about each model [here](https://docs.topazlabs.com/video-ai/filters/enhancement). Iris worked best for me.  You can test the models on small clips you have captured understand what will work best for your source footage.  

Select "Export As" and save your footage to ```enhanced.mp4```. Processing may take hours depending on the length of your footage and power of you PC/Mac.

## Trimming

If you would like to trim or extract segments from your enhanced footage use FFmpeg with a start index and length to create clips.
```console
ffmpeg -i enhanced.mp4 -ss 00:05:20 -t 00:10:00 -c:v copy -c:a copy clip.mp4
```
The copy parameters ensure that the video does not get reencoded again at a lower quality.

## Creating Introductions and Subsection Dividers

Use any video creation tool to create nice introduction scenes and subsection divider scenes.
I used iMovie.
Since the divider resolution (probably widescreen 1080p or 720p) does not match the original (720 x 480) you need to shrink and letterbox them.
```console
ffmpeg -i intro.mp4 -vf scale="720:-2",pad="720:480:0:37" intro.scaled.mp4
```

If these clips do not have an audio track you need to add silence before concatenation.
```console
ffmpeg -i intro.scaled.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -c:v copy -c:a aac -shortest intro.scaled.silence.mp4
```
## Clip Assembly

If you have multiple clips (introductions, enhanced footage, clip dividers, etc.) you want to assemble them without reencoding.
```console
ffmpeg -f concat -safe 0 -i files.txt -c copy assembled.mp4
```

where ```files.txt``` looks something like this:
```
file './intro.scaled.silence.mp4'
file './enhanced.mp4'
```

## Adding Language Metadata

If your video is in English apply, the this metadata:
```console
ffmpeg -i assembled.mp4 -c copy -metadata:s:a:0 language=eng assembled.eng.mp4
```
## Adding Chapter Metadata

Adding chapter metadata is great for players that support and if you are going to burn them physical media.

Using a video player that shows the time index during playback record all timestamps where you want chapters.

```console
ffmpeg -i assembled.eng.mp4 -i my.metadata -map_metadata 1 -codec copy remastered.mp4
```
where ```my.metadata``` contains something like this:
```
;FFMETADATA1
title=1993 Barnum
artist=Davis Remastered

[CHAPTER]
TIMEBASE=1/1000
START=0
#chapter ends at 00:00:05
END=5000
title=Intro

[CHAPTER]
TIMEBASE=1/1000
START=5000
#chapter ends at 00:44:30
END=2670000
title=Barnum

[CHAPTER]
TIMEBASE=1/1000
START=2670000
#chapter ends at 00:51:27
END=3087000
title=Stephen's Performance

[CHAPTER]
TIMEBASE=1/1000
START=3087000
#chapter ends at 01:42:07
END=6127000
title=Joanna's Performance
```
Notice that the START and END timestamps are in milliseconds.  
You can then test these chapter timestamps and adjust them as necessary with player that supports chapters like Quicktime.

## Generating a Thumbnail

If you want to extract a frame from your video at a timestamp to use as a thumbnail use the following command:
```console
ffmpeg -ss 00:00:03 -i remastered.mp4 -frames:v 1 thumbnail.jpg
```

## Upload to YouTube

Use YouTube studio to upload your content, check for copyright violations, and set your metadata before publishing.  

Similiar to chapter metadata your descriptions can contain chapter timestamps.  

Here is an [article](https://support.google.com/youtube/answer/9884579?hl=en) to help you setup YouTube chapters.
