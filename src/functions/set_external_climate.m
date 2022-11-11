
function S01_EC = set_external_climate(ds,t0)
%% Creacion de clima exterior 
%


%
%%
% Cargamos el clima exterior en el una estructura 
% con nombre S01_EC.
tspan = days(ds.DateTime - t0);

wind_values = ds.wind;
wind_values(isnan(wind_values))= [];
%
S01_EC = [];
S01_EC.signals.values = [ds.temperature+273.15 ds.radiation+5 wind_values ds.humidity ];
S01_EC.signals.dimensions = 4;
S01_EC.time = tspan;

%%
end