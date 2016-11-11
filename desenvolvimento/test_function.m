function [pts, pos, ori, S, C, H] = test_function(simTime);
%   This function is designed to perform micro-tests in the algorithms
%   Testing: 

%   Simulation connection
    disp('Stablishing connection with V-Rep...');
    vrep=remApi('remoteApi');
	vrep.simxFinish(-1);
	id = vrep.simxStart('127.0.0.1', 19997, true, true, 2000, 5);
    
    if(id == -1)
        disp('Failed to connect with the server.');
    else
        disp('Connection success!');
        disp('Starting simulation...');
    %   Simulation initilization
        res = vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot);
        handles = initialize_environment(vrep, id);

        time = 0;
        while time < simTime
            tic;

            [pos ori] = get_location(vrep, id, handles.hokJoint);
            pts = hokuyo_scan(vrep, id, handles, pos, ori);

            subplot(211)
            plot(pts(:,1), pts(:,2), '.r', pos(1), pos(2), 'ob');
            axis([-3.5 3.5 -7 7]);
            axis equal;
            drawnow;

            elapsed = toc;
            time = time+elapsed;
        end
        
        disp('Calculating clusters and segments...');
        [S C H] = segmentation(pts, 0.0555);
        
        disp('Everything done!');
        disp('Closing connection and finishing test!');
    %   Stopping simulation and closing connection
        pause(1);
        vrep.simxStopSimulation(id, vrep.simx_opmode_oneshot);
        pause(1);
        vrep.simxFinish(id);
    end
end
