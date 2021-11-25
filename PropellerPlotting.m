%% Plot Output

LineWidth = 2;
LabelFont = 16;
AxisFont  = 14;

%% FirstPlot

subplot(1,2,1)
hold on
plot(Throttle,[Output.Thrust]/9.81e-3,...
     'LineWidth',LineWidth)
plot(Throttle,Throttle*0+3000/4,'--r')

xlabel('Throttle','FontSize',LabelFont)
ylabel('Thrust (grams)','FontSize',LabelFont)
set(gca,'FontSize',AxisFont)  
title('Static Thrust','FontSize',LabelFont)
xlim([0 inf]) 
ylim([0 inf])
grid on

%% Second Plot
subplot(1,2,2)
hold on

ThrustEfficiency = [Output.Thrust]./([Output.Current].*[Output.Voltage]*9.81e-3);
plot(Throttle,ThrustEfficiency,'LineWidth',LineWidth)
plot([ThrottleLimit,ThrottleLimit],[0 max(ThrustEfficiency)],'--r')

xlabel('Throttle','FontSize',LabelFont)
ylabel('Thrust Efficiency (grams/W)','FontSize',LabelFont)
set(gca,'FontSize',AxisFont)  
title('Thrust ''Efficiency''','FontSize',LabelFont)
xlim([0 inf]) 
ylim([0 inf])
grid on

shg