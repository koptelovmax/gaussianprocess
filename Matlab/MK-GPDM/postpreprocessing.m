% Video Postprocess

% create the video writer with 25 fps
 writerObj = VideoWriter('myVideo1.avi');
 writerObj.FrameRate = 25;

 % open the video writer
 open(writerObj);
 
 % write the frames to the video
 for u=1:size(mov,2)
     
     writeVideo(writerObj, mov(u).cdata);
 end
 
 % close the writer object
 close(writerObj);