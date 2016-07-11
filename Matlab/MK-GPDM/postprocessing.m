% Video Postprocess

% create the video writer with 25 fps
 writerObj = VideoWriter('myVideo.avi');
 writerObj.FrameRate = 25;

 % open the video writer
 open(writerObj);
 
 % write the frames to the video
 for u=1:size(synth_Result,2)
     
     writeVideo(writerObj, synth_Result(u).frame);
 end
 
 % close the writer object
 close(writerObj);