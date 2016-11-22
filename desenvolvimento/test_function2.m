function [pts, maps] = test_function2(simTime)
disp('Stablishing connection with V-Rep...');
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
id = vrep.simxStart('127.0.0.1', 19997, true, true, 2000, 5);

if(id == -1)
    disp('Failed to connect with the server.');
else
    disp('Connection success!');
    disp('Starting simulation...')
    
    pts = [];
    ptsGrid = [];
    ptsTaken = zeros(floor(simTime/3)+1,5);
    ptsCount = 0;
    map = [];
    time = 0;
    res = vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot);
    handles = initialize_environment(vrep, id);
    
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
        
        if(time >= ptsCount*3 && ptsTaken(ptsCount+1,1) == false)
            ptsCount = ptsCount + 1;
            ptsGrid(1:length(pts),1:2,ptsCount) = pts;
            ptsTaken(ptsCount,1) = true;
            ptsTaken(ptsCount,2) = length(pts);
            ptsTaken(ptsCount,3) = pos(1);
            ptsTaken(ptsCount,4) = pos(2);
            ptsTaken(ptsCount,5) = time;
        end
    
    end
    
    disp('Everything done!');
    disp('Closing connection and finishing test!');
%   Stopping simulation and closing connection
    pause(1);
    vrep.simxStopSimulation(id, vrep.simx_opmode_oneshot);
    pause(1);
    vrep.simxFinish(id);
    disp('Starting mapping phase. Press any key to go through the maps.');
    
    i = 1;
    avg_comp_time = 0;
    num_comp = 0;
    while i <= ptsCount
        tic;
        map = build_map(map, ptsGrid(1:ptsTaken(i,2),:,i), 0.1, 0.013, deg2rad(3), 0.102, 0.025);
        elapsed = toc;
        num_comp = num_comp+1;
        avg_comp_time = (avg_comp_time + elapsed)/num_comp;
        
        clf reset;
        subplot(211)
        plot(ptsGrid(1:ptsTaken(i,2),1,i), ptsGrid(1:ptsTaken(i,2),2,i), '.r', ptsTaken(i,3), ptsTaken(i,4), 'ob');
        axis([-3.5 3.5 -7 7]);
        axis equal;
        
        if(~isempty(map))
            subplot(212);
            hold on;
            dimsMap = size(map); 
            if(length(dimsMap) == 3)
                for k=1:dimsMap(3)
                    plot(map(:,1,k), map(:,2,k), 'g');
                end
            else
                plot(map(:,1), map(:,2), 'g');                
            end
            plot(ptsTaken(i,3), ptsTaken(i,4), 'ob');
            axis([-3.5 3.5 -7 7]);
            axis equal;
        end
        drawnow;
        hold off;
        
        i = i+1;
        pause(4);
    end
    
    fprintf('Map avarage computation time: %f\n', avg_comp_time);
    
end
    
end