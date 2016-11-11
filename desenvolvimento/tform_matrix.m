function [tformMat] = tform_matrix(pos, ori)
%Function to obtain world frame transformation matrix
    rotMat = eul2tform([ori(3) ori(2) ori(1)]);
    trlMat = [0 0 0 pos(1); 0 0 0 pos(2); 0 0 0 pos(3); 0 0 0 0];
    tformMat = rotMat + trlMat;
end