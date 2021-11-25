%% Qprop analysis for max efficiency of a motor/prop system (water)
% Runs Qprop and figures out speeds based on drag coefficient
clear
clf
%% Input/Output file names
outputfile     = 'LastRun';
propfile       = 'apc14x10e';
motorfile      = 'CobraCM2217-26';
CurrentLimit   = 16;     % Maximum current check

%% Use editKv to create a new motorfile which includes a gear reduction
% ReductionRatio = 10;
% editKv(motorfile,ReductionRatio)
% motorfile = [motorfile,'_edit'];

%% Define fluid properties in qcon.def file
qcon=[1.225 1.78E-5 340]; % [Density, Viscoity, Speed of Sound}
fileID = fopen('qcon.def','w');
fprintf(fileID,'%d \n' ,qcon);
fclose(fileID);
clear fileID qcon

%% Define parameters: Leave empty variables if to be determined
Setpoint.Velocity = 2.0;    % Always define
Setpoint.RPM      = [];
Setpoint.Voltage  = 8.4;
Setpoint.dBeta    = 0.0;    % Leave as 0.0
Setpoint.Thrust   = [];
Setpoint.Torque   = [];
Setpoint.Current  = [];
Setpoint.Pele     = [];     % Leave Empty
 
%% Run Qprop
Throttle = 0.1:0.1:1;
for n = 1:numel(Throttle)
Setpoint.Voltage  = Setpoint.Voltage*Throttle(n);
Output(n) = run_qprop(propfile,motorfile,outputfile,Setpoint);
Setpoint.Voltage  = Setpoint.Voltage/Throttle(n);
end

%% Check Current Limit

if any([Output.Current]>=CurrentLimit)==1
    ThrottleLimit = Throttle(find([Output.Current]>=CurrentLimit,1));   
    disp(['Current limit exceeded at ' num2str(100*ThrottleLimit) '% throttle.'])
else
    disp('Current limit not exceeded.')
end

%% Plot Output

run PropellerPlotting