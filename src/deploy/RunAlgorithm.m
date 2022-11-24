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
Tend = 4;
%%

t0_span = ds.DateTime(1):days(Tend):ds.DateTime(end);
t0_span = t0_span(1:3);
BuildBusFlow;

best_benefit_span = [];
%
for j = 1:length(t0_span) 
    
    t0 = t0_span(j);
    % Comvertimos los datos de clima de la tabla ds en un formato tipo
    % estrutura determinada por matlab.
    EC = set_external_climate(ds,t0);
    % >> open SlowLayerControlMenaka
    SlowLayerControlMenaka;

    %best_simulation
    best_benefit_span(j).sim  = best_simulation;
    best_benefit_span(j).benefit = best_benefit;
    
    fprintf('=====================================================\n')
    fprintf('=====================================================\n')

end

%%
clf 
hold on
for j = 1:length(t0_span) 
    Tmax    = best_benefit_span(j).sim.input_parameters.Tmax;
    
    DT_span = best_benefit_span(j).sim.DT_span;
    Nt = length(DT_span);

    plot(DT_span , repmat(Tmax,1,Nt) - 273.15)
end