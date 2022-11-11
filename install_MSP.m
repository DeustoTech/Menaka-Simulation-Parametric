clear 
%
r = which('install_MSP.m');
r = replace(r,'install_MSP.m','');
%
r = fullfile(r,'src','dependences');
%%
%
unzip('https://github.com/DeustoTech/HortiMED-Modelling-Platform/archive/refs/heads/main.zip',r)

%%
addpath(genpath(pwd))