function start_mapping()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author: Ot?vio Gon?alvez Vicente Ribeiro Filho                       %
%   Objective: 2D Mapping With Laser Sensoring                            %
%   Salvador - Brazil, November 1 2016                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    disp('Initiating V-Rep connection...');
    vrep=remApi('remoteApi');
    vrep.simxFinish(-1);
    id = vrep.simxStart('127.0.0.1', 19997, true, true, 2000, 5);
    timestep = .05;
    ping = vrep.simxGetPingTime(id);

    if id < 0,
        disp('Ocorreu uma falhar na tentativa de conex?o com o V-REP.');
        vrep.delete();
        return;
    end

    fprintf('Connection %d with V-Rep stablished\n', id);
    disp('Starting simulation...');
    
    tic
    res = vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot);
    
    handles = initialize_environment(vrep, id);
    [startPos startOri] = get_location(vrep, id, handles.hokJoint);
    
    while true
        tic;
        
        [pos ori] = get_location(vrep, id, handles.hokJoint);
        pts = hokuyo_scan(vrep, id, handles, pos, ori);
        
        subplot(211)
        %plot([pos(1) pts(1,:) pos(1)], [pos(2) pts(2,:) pos(2)], '.r', pos(1), pos(2), 'ob');
        plot(pts(:,1), pts(:,2), '.r', pos(1), pos(2), 'ob');
        axis([-3.5 3.5 -7 7]);
        axis equal;
        drawnow;
        
        ping = vrep.simxGetPingTime(id);
        elapsed = toc;
        fprintf('Computation took %fms, ping is %f\n', elapsed, ping);
        fprintf('Pausing for %fms\n', abs((timestep-elapsed) + (ping/2)));
        %pause(max(timestep-elapsed, 0.01));
        pause(abs((timestep-elapsed) + (ping/2)));
    end
end