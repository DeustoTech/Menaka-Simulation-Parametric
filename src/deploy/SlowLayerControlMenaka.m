
% guardamos en fichero 
isim = setExternalInput(isim,EC);
%
%%
% 
% Ejecutamos la función BatchGenerator para genera una  para crear una matrix full_data
% Tendra en cada columna: 
%
%    - Tmax_h_ms(:)   Temperatura de apagado del heater cuando esta encendido
%    - Tmin_h_ms(:)   Temperatura de encendido del heater cuando esta apagado
%    - Tmax_w_ms(:)   Temperatura del aire del invernadero para que las ventanas cenitales estes abiertas al 100%
%    - Tmin_w_ms(:)   Temperatura del aire del invernadero cuando empiezan
%                     abrirse las ventanas. Tambien llamado temperatura de
%                     ventilacion
%    - Radth_ms(:)    Radiacion cuando las pantallas de sombreo se cierran

nslides = 5 ; % numero de cortes  
full_data = BatchGenerator(nslides);

nsamples = 10;
ind_rand = randperm(size(full_data,1),nsamples);
full_data = full_data(ind_rand,:);

%%
% Configuramos los paramteros que no se modificaran en toda el bucle de
% paramtros 
set_params;
simulation_out = {};
%%
for i = 1:nsamples
    %
    % modificamos los parametros del bucle
    %
    fprintf(i+" - iter\n")
    %
    % Modificamos las variables de interes en la estructura de parametros 
    parameters.Tmax          = full_data(i,1);      % Temperatura de apagado del heater cuando esta encendido
    parameters.Tstart        = full_data(i,2);      % Temperatura de encendido del heater cuando esta apagado
    parameters.Tven_max      = full_data(i,3);      % Temperatura del aire del invernadero para que las ventanas cenitales estes abiertas al 100%
    parameters.Tven_start    = full_data(i,4);      % Temperatura del aire del invernadero cuando empiezan
%                                                       abrirse las ventanas. Tambien llamado temperatura de
%                                                       ventilacion
    parameters.Radthhold     = full_data(i,5);      % Radiacion cuando las pantallas de sombreo se cierran

    % Actualizamos la estructura de Simulink
    UpdateParams

    try
        r = sim(isim);
        % Numero de dias de ejecucion
        
        fprintf("Simulacion : "+i+" Ejecutado correctamente\n")

    catch 
        fprintf("Simulacion : "+i+" Ejecutado Con Errores\n")
        continue
    end
    %
    % De la misma manera que antes el output de la simulacion que nos da simulink contiene mucha
    % informacion  aveces inecesaria. Es por ello que creamos la función
    % parsevars, ordenamos la informacion de las señales del modelo por
    % submodelos. Otra vez se toma un formato de clave valor (la clase struct nativa de MATLAB)
    %
    simulation_out{i} = parsevars_days(r,ds,parameters.crop,full_data(i,:),t0);
    %
    fprintf([repmat('=',1,10),'\n\n'])
end
%% Calculamos la funcion de coste
% 
alpha_th = 1e-2; % [ €/kW{thermal}    ]
alpha_el = 1e-3; % [ €/kW{electrical} ] 
alpha_to = 1e+3; % [ €/tomate{kg}     ]
alpha_wa = 1e-6; % [ €/water{kg}      ]
alpha_nu = 1e-6; % [ €/nutrients{kg}  ]
%
%%
% Calculamos el beneficio para cada uno de las simulaciones realizadas 
A_v = parameters.crop.A_v; % metros cuadrados de plantacion

benefit = zeros(1,nsamples);
%
for iter = 1:nsamples
    try 
        cost = simulation_out{iter}.total;
    
        benefit(iter) = cost.carbon*alpha_to*A_v - ...
                        cost.thermal*alpha_th    - ...
                        cost.electrical*alpha_el - ...
                        cost.water_c*alpha_wa    - ...
                        cost.nutrients*alpha_nu;
    catch 
         benefit(iter) = -inf;
    end
end
%%
[best_benefit,ind] = max(benefit);
best_simulation = simulation_out{ind};
%%
