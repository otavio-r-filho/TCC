function [pts] = hokuyo_scan(vrep, connId, handle, pos, ori)
%This function is responsible for acquiring the detected points from the
%Hokuyo sensor, which are relative to the sensor joint coordinate frame,
%and delivering the points in the world coordinate frame.

%Step 1: Acquiring the points.
    err = -1;
    while (err ~= 0)
        [err data] = vrep.simxReadStringStream(connId, 'HOKUYO_STREAM', vrep.simx_opmode_buffer);
    end
    
%Step 2: As the points come as a string, it's necessary to extract them
%with the this remote api function.
    points = vrep.simxUnpackFloats(data);
    
%Step 3: Acquiring the world frame transformation matrix and multiplying
%each point by the matrix.
    tformMat = tform_matrix(pos, ori);
    
    i = 1;
    for c=1:(length(points)/3)
        if (points((c*3)-2) ~= 0) && (points((c*3)-1) ~= 0)
            pt = tformMat * [points((c*3)-2); points((c*3)-1); points((c*3)); 1];
            pts(i,1:2) = pt(1:2);
            i = i+1;
        end
    end
end