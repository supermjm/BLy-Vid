function Blyvid(vid_in, vid_out, rlines)
% Blyvid will replace the video lines from video file vid_in, specified by
% number in rlines with a duplicate of the line below it. It writes the
% output to the file named in vid_out

% setup some defaults
    switch nargin
        case 0
            vid_in = 'Btest.mp4'; vid_out = 'Ofile.mp4';
            rlines = 220:2:250;
        case 1
            vid_out = 'Ofile.mp4';
            rlines = 220:2:250;
        case 2
            rlines = 220:2:250;
    end
    
    % setup the input file
    vidInObj = VideoReader(vid_in);
    % and the output file
    vidOutObj = VideoWriter(vid_out,'MPEG-4');
    vidOutObj.FrameRate = vidInObj.FrameRate;
    open(vidOutObj);
    
    while hasFrame(vidInObj)
        % get the current frame
        fr = readFrame(vidInObj);
        % for each line in rlines, replace it with the line below
        fr(rlines,:,:) = fr(rlines+1,:,:);
        % write the modified video frame
        writeVideo(vidOutObj,fr);
    end
    
    % close the output file
    close(vidOutObj);
    
end