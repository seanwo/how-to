# Upscaling miniDV SD (480p) Video to HD (1080p) Video

This how-to assumes you have been able to pull footage off an old camcorder and have .dv files that contain the content you want to edit and upscale from 480p to 1080p.  You can do this by using [WinDV](http://windv.mourek.cz/) to extract data off your old camcorder (or one you get off ebay).

## Step 1: Edit the Raw Footage

Get [Shotcut](https://shotcut.org/) (available for all platforms).

Open the source.dv file in Shotcut and drag it to the timeline.  
*My suggestion is to cut each distinct video clip into separate clip.dv files.*

When you go to save the clips:  
Select ```camcorder:DV (SD NTSC)``` (*in my case, this is my original format*) and then select ```export```.  
*This dumps the clips without encoding them (lossless).*

You can use this tool to convert other types of file to .dv format as well.  
*In my case, I used iMovie to create a bunch title.mp4 files and subtitle.mp4 files to describe the clips and used Shotcut to turn them into .dv files.*

*Example List of Files After Editting:*
```
00.title.dv (built in iMovie; converted to .dv with Shotcut)  
05.subtitle.segment.1.dv (built in iMovie; converted to .dv with Shotcut)  
10.movie.segment1.dv (used Shotcut to crop out and export this segment)  
15.subtitle.segment.1.dv (built in iMovie; converted to .dv with Shotcut)  
20.movie.segment2.dv (used Shotcut to crop out and export this segment)  
```
Once you have edited your movie and have a list of ordered the clips, you just concatenate them together.  (Yes. really!)

*On Mac:*
```console
hostname$ cat *.dv > movie.dv
```
*On Windows:*
```console
C:\> copy 00.title.dv + 05.subtitle.segment.1.dv + 10.movie.segment1.dv + 15.subtitle.segment.1.dv + 20.movie.segment2.dv movie.dv
```

## Step 2: Understand the Square Pixel Problem

Get [FFmpeg](https://ffmpeg.org/download.html) (available for all platforms)  

Get the media information off your movie.dv using ffmpeg:  
```console
ffmpeg -i movie.dv  
```
Your output will contain a section like this:  
```
Duration: 01:00:00.00, start: 0.000000, bitrate: 28771 kb/s  
  Stream #0:0: Video: dvvideo, yuv411p, 720x480 [SAR 8:9 DAR 4:3], 25000 kb/s, 29.97 fps, 29.97 tbr, 29.97 tbn, 29.97 tbc  
  Stream #0:1: Audio: pcm_s16le, 48000 Hz, stereo, s16, 1536 kb/s  
```
Here are some terms:  
```
DAR = Display Aspect Ratio  
PAR = Pixel Aspect Ratio  
SAR = Storage Aspect Ratio  
```
FFmpeg uses the unfortunate term variation:

SAR = Sample Aspect Ratio (equivalent to PAR).  I will continue to use the terms above.

The video math for our movie says:
```
DAR = PAR * SAR  
4:3 = 8:9 * 720:480  
4/3 = (8/9) * (720/480)  
4/3 = (8*720) / (9*480)  
4/3 = 5760 / 4320  
1.33 = 1.33  
```
However, to accurately upscale the movie, we need to have a PAR of 1:1 (square pixels) not 8:9 (non-square pixels)!

## Step 3: Upscaling - Option 1 (not using AI processing):
*Skip this step if you are going to use AI processing.  This is provided for those that find AI processing too time consuming or costly.  I started down this route until I found option 2.*

Simply transform and encode the final output:
```console
ffmpeg -y -i movie.dv -vf yadif,scale="1440:1080":flags=lanczos,setsar=1,pad="1920:1080:240:0" -vcodec libx264 -preset veryslow -profile:v high -pix_fmt yuv420p -crf 17 -acodec ac3 -metadata:s:a:0 language=eng final.mp4
```
```
-vf (video filter)  
	yadif, (deinterlace the video)  
	scale="1440x1080":flags=lanczos, (SAR: new resolution using better lanczos method)  
	setsar=1, (PAR)  
	pad="1920:1080:240:0" (pad left and right since original is 4:3 and we are creating 16:9)  
-vcodec libx264 (encoding codec)  
-preset veryslow (best compression)  
-profile:v high (high profile)  
-pix_fmt yuv420p (pixel format)  
-crf 17 (visually lossless)  
-acodec ac3 (bluray compatible audio)  
-metadata:s:a:0 language=eng (audio metadata: English)  
```
## Step 3: Upscaling - Option 2 (prepare for AI processing)

For this option, we only need to deinterlace and set a PAR of 1:1 without encoding:
```console
ffmpeg -i movie.dv -vf yadif,scale="640:480",setsar=1 -vcodec rawvideo -acodec copy -pix_fmt yuv420p -metadata:s:a:0 language=eng movie.avi
```
*The output has a scale a resolution of 640x40 (4:3) with a PAR of 1:1 (square pixels).*  
```
-vcodec rawvideo (do not encode; lossless)
-acodec copy (copy stream; lossless)

(see option 1 for other select parameter descriptions)
```
## Step 4: AI Upscaling

Get [Topaz Video Enhance AI](https://topazlabs.com/video-enhance-ai/) (there is a free trial for 30 days).

I performed a side by side and split video comparison between the Lanczos and AI upscaling methods and the AI method won.

I have powerful Macbook Pro (no GPU) and it would be infeasible to process more than 30 minutes of video without spending days or weeks using only the CPU on my machine.

**You will NEED a GPU!** (*or a cloud instance with one; see below*)

However, you should process a few minutes of video locally to see what he quality is like and to experiment with the tool.

Basically, just add the movie.avi file  and select the following options in the tool:
```
A.I. Models: Artemis-LQ: P,LQ,MC
Preset: HD(1920x1080)
Unselect: Crop to fill frame (this will make the video 16:9 and pad black bars on the left and right for tv playback)
Scale: 225
Width: 1920
Height: 1080
Select: Use default output name
Output format: mpeg4
```
We will use the Artemis LQ model since is is designed for "Enhancement and upscaling for low-quality progressive footage with better motion consistency. Use this for old family recordings, historical footage, etc."

Simple Steps:
- Open your input source (generated in Step 3 - Option 2)
- Select the options above
- Under ```Process``` on the main menu make sure your GPU is selected
- Adjust the timeline to enhance and encode either the entire video or just a sample
- Select ```Process -> Start Processing```

This will show a frame by frame comparison and enhancement while processing.  
Inspect the final video when processing is complete.  

## Step 5: Using AWS Cloud Computing to Upscale

**Note:** I tried to use an Elastic GPU attached to a T3 instance and Topaz would not recognize the GPU.  

*Topaz requires the installation of NVidia drivers for GPU detection even though Elastic GPUs provide OpenGL support. That means at a minimum you are going to require a G3 accelerated instance.*

Understand AWS instance types and costs by reading these pages:  
- AWS accelerated computing: https://aws.amazon.com/ec2/instance-types/#Accelerated_Computing
- AWS pricing: https://aws.amazon.com/ec2/pricing/on-demand/

You will need at least a g3s.xlarge to meet the minimum system requirements:  
https://help.topazlabs.com/hc/en-us/articles/360039302251-Video-Enhance-AI-System-Requirements

If you have a basic account with AWS, you will also need to request a limit increase from 0 to 1 for G type instances:  
https://console.aws.amazon.com/support/home#/case/create

It will take 24 hours to assign the request, and 24-48 hours for a review of your account to grant the increase.

At the time of writing this, it will cost ~$1 per hour to run this machine.  Have everything ready to go before launching your GPU instance to minimize costs.

### Setting Up the Video EBS Volume Using a Small T3 Instance:
*Use a T3 instance to setup the video EBS volume so you are not charged for accelerated machine usage during setup.*

Basically, you need to put all the file you need up in S3 from your local machine.

This includes:
- AWS CLi Tools: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html
- Topaz Video Enhance AI (paid for or trial version): https://topazlabs.com/video-enhance-ai/
- Gzip: http://gnuwin32.sourceforge.net/packages/gzip.htm (you only need to put gzip.exe from the package into S3)
- Your preprocessed videos (Step 3 - Option 2)

You can do this via the web interface or via AWS CLI tools:
```console
brew install awscli
```
*or see below how to get the Windows AWS CLI tools.*

*I suggest you zip each file up before uploading to S3 to save transfer time and costs:*
```console
gzip --best movie.avi
```

Create an EBS volume that does not get deleted when you tear down your instances.  
*I created a 1TB SSD since I had a lot of video to process.*  
**Note**: You are charged for this EBS volume whether it is attached to a running instance or not so build and destroy it in a timely fashion.

Spin up a cheap (small) T3 Windows 2019 DC Edition instance assigned a role allowing access to your S3 buckets.  
Attach the newly created EBS volume to the T3 instance and format the drive.  

Again, download the AWS CLI tools to the T3 instance using IE and install it so you can access your S3 buckets.  
Now use this cheap instance to copy the contents of your S3 bucket to your EBS volume (D:\).

*Example:*
```console
D:\> aws s3 cp s3://bucketname/input.avi.gz .
```
Once you have all the files on the EBS volume, decompress any .avi.gz files:
```console
gzip.exe -d input.avi.gz
```
Lastly, you will need to acquire AWS's specialized NVidia GRID drivers (the ones from the NVidia website will not work with this application on a cloud instance). Follow the instructions here to get NVIDIA.zip and put it on the EBS volume (D:\) as well:  
https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/install-nvidia-driver.html#nvidia-GRID-driver

Now you have everything you need to quickly attach this EBS volume to your G3 instance and have access to all the files you need.

Shutdown your T3 instance making sure you do not delete the EBS volume you made.  
Detach the EBS volume from the T3 instance.

### Spinning Up the G3 Instance for Upscaling:

After your G3 limits are increased:
- Spin up a g3s.xlarge instance with default parameters and a role that allows access to your S3 buckets.
- Attach the video EBS volume drive to the instance.
- Install the AWS CLI Tools from the EBS volume to access S3 (in order to put videos back into S3 as they finish).
- Install the NVidia GRID drivers.
- Reboot.
- Install these Windows features: Media Foundation and Quality Windows Audio Video Experience.
- Reboot.
- Install the Topaz Video Enhance AI Tool.
- Launch Topaz and ensure the GPU is select under Process.
- Select each video file to enhance along with the setting from the section above and queue each movie up for processing.
- Run all processing until complete.
- Either from you G3 instance (after each file is processed or upon batch completion) or from your T3 (reattached the EBS volume) copy all processed files back to S3.
- Download the processed files from S3 to your local system.
- Clean up all AWS resources including instances, volumes, s3 buckets, etc.

### Cost Estimates

Encoding Costs:  
video (mins) * 0.44 (frames/sec) * 0.93 (cost/hr) * 0.5 = compute cost of g3s.xlarge instance

Example:  
60 (mins) * 0.44 (frames/sec) * 0.93 (cost/hr) * 0.5 = $12.28
