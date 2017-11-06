function Blyvid(vid_in, vid_out, rlines, sbsflg)
% Blyvid will replace the video lines from video file vid_in, specified by
% number in rlines with a duplicate of the line below it. It writes the
% output to the file named in vid_out. The output will be side-by-side with
% the input video if sbsflg is ~= 0, otherwise, it will be encoded on its
% own.

% setup some defaults
    switch nargin
        case 0
            vid_in = 'Btest.mp4'; vid_out = 'Ofile.mp4';
            rlines = 220:2:280; sbsflg = 1;
        case 1
            vid_out = 'Ofile.mp4';
            rlines = 220:2:280; sbsflg = 1;
        case 2
            rlines = 220:2:280; sbsflg = 1;
    end
    
    % setup the input file
    vidInObj = VideoReader(vid_in);
    % and the output file
    vidOutObj = VideoWriter(vid_out,'MPEG-4');
    vidOutObj.FrameRate = vidInObj.FrameRate;
    open(vidOutObj);
    
    % check the side-by-side flag to set the width of the video output
    fro = zeros(vidInObj.Height,vidInObj.Width*(1+~eq(sbsflg,0)), 3);
    % set an index for the horizontal index of the modified output frame
    wind = 1 + vidInObj.Width*~eq(sbsflg,0):size(fro,2);
        
    while hasFrame(vidInObj)
        % get the current frame
        fri = readFrame(vidInObj);
        % for each line in rlines, replace it with the line below
        fro = [fri fri];
        fro(rlines,wind:end,:,:) = fri(rlines+1,:,:); %#ok<BDSCI>
        % write the modified video frame
        writeVideo(vidOutObj,fro);
    end
    
    % close the output file
    close(vidOutObj);
    
end