clear
% Cargamos los datos de clima exterior
%
ds = load('data/ds_EC','ds');
ds = ds.ds;

% Intante Inicial
% tomamos como intante inicial de la simulación la fecha t0
% determinada por el primer elemento de la tabla ds. Esta es la tabla de
% clima exterior.
% Podriamos tomar un valor inicial diferente variando el valor de t0 por
% ejemplo: 
% 
% - t0 = ds.DateTime(10);
% - t0 = datetime('01-Feb-2022')
% - t0 = datetime('01-Feb-2022 10:00:00')
% 
% Pero en este caso el instante inicial sera el primero dato de la tabla ds
%
% Es importante mencionar que todas las simulaciones empiezan en t=0;
% por lo que es importante desplazar las senales si fueran necesario
%

%%
% Definimos el numero de dias que durara la simulacion
% 
% Tend = 360 dias -> 60 - 70 segundos de simulacion
Tend = 2;
%%

t0_span = ds.DateTime(1):days(Tend):ds.DateTime(end);
t0_span = t0_span(1:4);
BuildBusFlow;

best_benefit_span = [];
%
load_system('MenakaModel')
isim = Simulink.SimulationInput('MenakaModel');
set_param('MenakaModel','StopTime',num2str(Tend));
set_param('MenakaModel','SimulationMode','accelerator');

for j = 1:length(t0_span) 
    
    t0 = t0_span(j);
    %

    fprintf([repmat('=',1,70),'\n\n'])
    fprintf("Calculo de mejores setpoints el: "+string(t0)+"\n")
    fprintf([repmat('=',1,70),'\n\n'])
    
    % Comvertimos los datos de clima de la tabla ds en un formato tipo
    % estrutura determinada por matlab.
    EC = set_external_climate(ds,t0);
    % >> open SlowLayerControlMenaka
    % Recibe el clima exterior EC
    % Devuelve Best Simulation 
    SlowLayerControlMenaka;

    %best_simulation
    best_benefit_span(j).sim  = best_simulation;
    best_benefit_span(j).benefit = best_benefit;

    fprintf([repmat('=',1,70),'\n\n'])
    fprintf("Calculo de mejores setpoints el: "+string(t0)+" ha terminado\n")
    fprintf([repmat('=',1,70),'\n\n'])
    fprintf([repmat('=',1,70),'\n\n'])

end

%%

Tstart_total = [];
Tmax_total = [];

Tstart_ven_total = [];
Tmax_ven_total = [];

DT_span_total = [];
WIN_span_total = [];

HS_span_total = [];
Ti_total = [];
for j = 1:length(t0_span) 
    Windows = best_benefit_span(j).sim.cc_st.Windows.value;
    HeaterSignal = best_benefit_span(j).sim.PowerH2COM;
    Ti = best_benefit_span(j).sim.clima_st.Temp.Tair;
    Tmax      = best_benefit_span(j).sim.input_parameters.Tmax;
    Tstart    = best_benefit_span(j).sim.input_parameters.Tstart ;

    Tmax_ven      = best_benefit_span(j).sim.input_parameters.Tven_max;
    Tstart_ven    = best_benefit_span(j).sim.input_parameters.Tven_start ;

    DT_span = best_benefit_span(j).sim.DT_span;
    Nt = length(DT_span);

    Tstart_total = [Tstart_total repmat(Tstart,1,Nt)];
    Tmax_total = [Tmax_total repmat(Tmax,1,Nt)];

    Tstart_ven_total = [Tstart_ven_total repmat(Tstart_ven,1,Nt)];
    Tmax_ven_total = [Tmax_ven_total repmat(Tmax_ven,1,Nt)];

    DT_span_total = [DT_span_total; DT_span];
    Ti_total = [Ti_total; Ti];

    HS_span_total = [HS_span_total;HeaterSignal];
    WIN_span_total = [WIN_span_total;Windows];

    

end


%%
clf
subplot(4,1,1)
hold on
plot(DT_span_total , Tmax_ven_total- 273.15,'color','r','LineStyle','--')
plot(DT_span_total , Tstart_ven_total- 273.15,'color','b','LineStyle','--')

plot(DT_span_total , Tmax_total- 273.15,'color','r')
plot(DT_span_total , Tstart_total- 273.15,'color','b')
plot(ds.DateTime,ds.temperature)
plot(DT_span_total,Ti_total-273.15)

xlim([DT_span_total(1) DT_span_total(end)])
xline(t0_span)
legend('T_{max}^{ven}','T_{start}^{ven}', ...
       'T_{max}^{heater}','T_{start}^{heater}','T_e','T_i','FontSize',5)

subplot(4,1,2)

plot(DT_span_total,HS_span_total)
legend('Heater')

subplot(4,1,3)

plot(DT_span_total,WIN_span_total)
legend('Windows')

subplot(4,1,4)

plot(ds.DateTime,ds.radiation)
xlim([DT_span_total(1) DT_span_total(end)])

