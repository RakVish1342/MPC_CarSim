% function [scenario, egoVehicle] = createDrivingScenario()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.7 (R2019b) and Automated Driving Toolbox 3.0 (R2019b).
% Generated on: 25-Nov-2020 23:37:50

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0 0;
    150 0 0];
laneSpecification = lanespec(2, 'Width', 2.925);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [1.8 -1.6 0]);
waypoints = [1.8 -1.6 0;
    15.1 -1.5 0;
    28.1 -1.3 0;
    41.6 -1.3 0;
    58.9 -0.5 0;
    78.5 0.5 0;
    106.9 1.1 0;
    132 1.1 0;
    148.5 1.3 0];
speed = 30;
trajectory(egoVehicle, waypoints, speed);

% Just the simulation time is shortened. Rest of the param wrt the
% trajectory qyapoints remains the same.
% So effectively, the yaw rates, the trajectory (waypints with time
% constraints) will be different. But that does not matter for my
% application/project.


