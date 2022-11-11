%%
%
% Este script compila el modelo de simulink "MenakaModel", con el fin de
% poder ejecutarse en un batch de simulaciones. 
%
clear 
%%
% El modelo de substrate bag tiene variables tipo Bus NoVirtual. Esto significa que existe una estructura de datos estatica que simulink debe conocer. 
% La función BuildBusFlow, crea este tipo de variable FLOW (Type Bus). Si
% no se ejecuta esta función no se puede usar los modelo "Subtrate Bag", ni
% "Tank Model"
%
BuildBusFlow;
% Cargamos los paramteros del modelo
% Si no existe todas las variables que necesita el modelo para ejecutarse
% no podrá compilar el modelo. 
%
load('data/params.mat')
%
%% Compile 
slbuild('MenakaModel')
%% 
% Con el fin de ejecutar el modelo compilado con otros parametros 
% es necesario crear un fichero .mat que contenga una variable generada por
% la funcion de MATLAB rsimgetrtp. Esta funcion toma como entrada el nombre
% del modelo de Simulink, de manera que crear un variable tipo structura
% que tiene el formato concreto para la introducción de los paramtros del
% modelo. 
%
% La variable del modelo estan definidas en Simulink. En la pestana Model
% Data Editor, en la subpestana Model WorkSpace. Alli se encuentra la
% variables que existen en el modelo. 
%
%
Menaka_parameters_simulink_Structure = rsimgetrtp('MenakaModel');
%
save('auxiliar_files/Menaka_parameters_simulink_Structure.mat','Menaka_parameters_simulink_Structure')
%%