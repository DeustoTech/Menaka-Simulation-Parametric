clear
%% Crear carpetas 
% Se ejecute en la carpeta principal

mkdir('auxiliar_files')
addpath('auxiliar_files')
mkdir('simulations')
addpath('simulations')

% Comprobando si el modelo esta compilado 

if ~exist('./MenakaModel','file')
    warning("\nNo existe Modelo compilado. Se compilara primero, para ello se lanzará 'ModelCompiler'\n\n")
    ModelCompiler;
end
%% 
% Cargamos los datos de clima exterior
%
ds = load('data/ds_EC','ds');
ds = ds.ds;
%
%% 
% La estructura de la variable cargada es la siguiente
% 
% >> head(ds)
% 
% ans =
%   8×5 table
%           DateTime          temperature    humidity    wind    radiation
%     ____________________    ___________    ________    ____    _________
%     01-Feb-2022 01:00:00       10.22         80.4      1.19      10.72  
%     01-Feb-2022 02:00:00       10.78         73.9      1.05       7.55  
%     01-Feb-2022 03:00:00          11        69.99       0.9       8.36  
%     01-Feb-2022 04:00:00       10.88        70.72      1.26       7.73  
%     01-Feb-2022 05:00:00        10.8        69.65      0.77       9.16  
%     01-Feb-2022 06:00:00       10.87        68.95      1.27      10.63  
%     01-Feb-2022 07:00:00        10.8        72.15      1.08       8.81  
%     01-Feb-2022 08:00:00       10.87        65.82      0.85      23.29
%
%%
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

t0 = ds.DateTime(1);

% Comvertimos los datos de clima de la tabla ds en un formato tipo
% estrutura determinada por matlab simulink .
S01_EC = set_external_climate(ds,t0);
% guardamos en fichero 
save('auxiliar_files/external_climate_rsim.mat','S01_EC')
% liberamos memoria 
clear S01_EC
%%
% Definimos el numero de dias que durara la simulacion
% 
% Tend = 360 dias -> 60 - 70 segundos de simulacion
Tend = 360;
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
nsamples = size(full_data,1);
%nsamples = 5; % <= solo tomo 5.

%%
% Configuramos los paramteros que no se modificaran en toda el bucle de
% paramtros 
set_params;
%%
for i = 1:nsamples
    %
    % modificamos los parametros del bucle
    %
    fprintf(i+" - iter\n\n")
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
    % "Menaka_parameters_simulink_Structure" con ayuda de la estructura "parameters" 
    % 
    % Esto se realiza de esta manera porque el formato de la estructura que nos ofrece simulink esta muy bien
    % para unos cuando parámtros, sin embargo en este modelo existen
    % cientos de parametros de diferentes partes del modelo. Utilizamos un
    % formato clave valor para ordenar cada grupos de paramteros.
    %
    
    Menaka_parameters_simulink_Structure = structparams2file(Menaka_parameters_simulink_Structure,parameters);
    
    % Modificamos el fichero "Menaka_parameters_simulink_Structure.mat"
    save('auxiliar_files/Menaka_parameters_simulink_Structure', ...  % path del fichero de parametros con el formato simulink 
         'Menaka_parameters_simulink_Structure')                     % variable de la estructura simulink
    %
    try
        % Ejecutamos el modelo compilado
        system("./MenakaModel"                                                  + ... % modelo compilado        
                " -i auxiliar_files/external_climate_rsim.mat"                  + ... % External Climate en el formato requerido para el modelo compilado
                " -p auxiliar_files/Menaka_parameters_simulink_Structure.mat"   + ... % Parametros 
                " -o auxiliar_files/output_variables_MenakaModel.mat"           + ... % Nombre del fichero de salida
                " -tf "+num2str(Tend));                                               % Numero de dias de ejecucion
        
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
    simulation_out = parsevars('auxiliar_files/output_variables_MenakaModel.mat',ds,parameters.crop,full_data(i,:));
    %
    % Guardamos la salida de esta simulacion, ya parseada en la carpera
    % simulations
    %
    save("simulations/sim_"+num2str(i,'%04d'),'simulation_out')
end
%%
% Guardamos el clima exterior con el que se genero la simulacion
save("simulations/ds",'ds')
%%
