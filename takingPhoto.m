
function [photo1, photo2] = takingPhoto()
    %@description:  A function that uses webcam to take 2 pictures for 2
    %               players after press button
    %@return: the pictures in grayscale


    % Note: Assuming a 'cam' varaiable is already availiable
    
    % Initialize webcam
    if ~exist('cam',"var")
        cam = webcam;
    end

    breaking = false;
    
    fig = figure;
    p1_btn = uicontrol('Position', [20 20 60 20], 'String',"Player 1", 'Callback', @changeP1);
    p2_btn = uicontrol('Position', [100 20 60 20], 'String',"Player 2", 'Callback', @changeP2);
    p3_btn = uicontrol('Position', [180 20 60 20], 'String',"Done", 'Callback', @changeP3);
    
    
    frame = snapshot(cam); 
    subplot(2,2,1); im = image(zeros(size(frame),'uint8')); 
    
%     preview(cam, im);

    waitfor(fig);
    
    function changeP1(src, event)
        if src.Value
            img = snapshot(cam);
            photo1 = im2double(rgb2gray(img));
            subplot(2,2,3);
            imshow(photo1);
        end
    end

    function changeP2(src, event)
        if src.Value
            img = snapshot(cam);
            photo2 = im2double(rgb2gray(img));
            subplot(2,2,4);
            imshow(photo2);
        end
    end

    function changeP3(src, event)
        if src.Value
%             closePreview(cam)
            close(fig)
        end
    end
end