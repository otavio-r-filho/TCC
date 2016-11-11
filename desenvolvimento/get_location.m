function [pos ori] = get_location(vrep, connId, handle) 
%Simple function  to acquire position and orientation of the given object
%handle. Position is given as X-Y-Z coordinates, and orientation is given
%as alpha-beta-gamma angles
    err = -1;
    while err ~= 0 
        [err pos] = vrep.simxGetObjectPosition(connId, handle, -1, vrep.simx_opmode_buffer);
    end
    
    err = -1;
    while (err ~=0)
        [err ori] = vrep.simxGetObjectOrientation(connId, handle, -1, vrep.simx_opmode_buffer);
    end
end