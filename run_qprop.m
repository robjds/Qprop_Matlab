function [Output] = run_qprop(propfile,motorfile,outputfile,Setpoint)
                          
inputs =   {'Velocity'
            'RPM'
            'Voltage'
            'dBeta'
            'Thrust'
            'Torque'
            'Current'
            'Pele'};

SetpointString = [];
for n=1:numel(inputs)
if isempty(Setpoint.(inputs{n}))==1
    SetpointString = [SetpointString ' 0'];
else    
    SetpointString = [SetpointString ' ' num2str(Setpoint.(inputs{n}))];
end
end

%% Run Qprop
% Run parameters definition order: 
% vel  rpm volt dbeta thrust torque amps pele

commandstring = ['qprop.exe InputDataFiles\' propfile ...
                 ' InputDataFiles\' motorfile ...
                 SetpointString ' > ' outputfile '.dat'];
             
system(commandstring);

%% Parse Output

run_results=importdata( [outputfile '.dat'],' ',17);

Output.Freestream         = run_results.data(:,1);
Output.RPMs               = run_results.data(:,2);
Output.Thrust             = run_results.data(:,4);
Output.Torque             = run_results.data(:,5);
Output.Voltage            = run_results.data(:,7);
Output.Current            = run_results.data(:,8);

delete([outputfile '.dat'])