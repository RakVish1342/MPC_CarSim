% function [scenario, egoVehicle] = createDrivingScenario()

% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.7 (R2019b) and Automated Driving Toolbox 3.0 (R2019b).
% Generated on: 25-Nov-2020 13:29:56

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0.2 0;
    150 0.2 0];

laneSpecification = lanespec(2, 'Width', 4);

road(scenario, roadCenters, 'Lanes', laneSpecification);


% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [5 -1.4 0]);

waypoints = [5 -1.4 0;
    20.6 -1.4 0;
    36.4 -1.4 0;
    53.8 -0.5 0;
    71.8 1.9 0;
    94 2.8 0;
    111.1 2.8 0;
    128.7 2.5 0;
    148.5 2.5 0];

speed = 10; % m/s as per toolbox settings

trajectory(egoVehicle, waypoints, speed);

reference_signal = [];
while advance(scenario)
    reference_signal = [reference_signal;  [scenario.SimulationTime, egoVehicle.Position(2), egoVehicle.Yaw ]];
end
plot(reference_signal(:,1), reference_signal(:,2), reference_signal(:,1), reference_signal(:,3));
reference_signal_timeseries = timeseries( [reference_signal(:,2), reference_signal(:,3)], reference_signal(:,1) );
save('reference_signal_timeseries.mat', 'reference_signal_timeseries')
