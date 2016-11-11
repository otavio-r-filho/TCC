function [handles] = initialize_environment(vrep, connId)
%This function acquires the handles and initialize the streams

    handles = struct('id', connId);
    [res handles.hokLaser] = vrep.simxGetObjectHandle(connId, 'Hokuyo_URG_04LX_UG01_laser', vrep.simx_opmode_oneshot_wait);
    [res handles.hokJoint] = vrep.simxGetObjectHandle(connId, 'Hokuyo_URG_04LX_UG01_joint', vrep.simx_opmode_oneshot_wait);
    [res handles.hokref] = vrep.simxGetObjectHandle(connId, 'Hokuyo_ref', vrep.simx_opmode_oneshot_wait);
    [res handles.hok] = vrep.simxGetObjectHandle(connId, 'Hokuyo_URG_04LX_UG01', vrep.simx_opmode_oneshot_wait);
    [res handles.hoktube] = vrep.simxGetObjectHandle(connId, 'Hokuyo_URG_04LX_UG01_HOKUYO', vrep.simx_opmode_oneshot_wait);
    
    res = vrep.simxReadStringStream(connId, 'HOKUYO_STREAM', vrep.simx_opmode_streaming);
    res = vrep.simxGetObjectPosition(connId, handles.hokJoint, -1, vrep.simx_opmode_streaming);
    res = vrep.simxGetObjectOrientation(connId, handles.hokJoint, -1, vrep.simx_opmode_streaming);
end