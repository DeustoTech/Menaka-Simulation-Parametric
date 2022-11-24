%%
%
% creamos estruturas de matlab para la modificacion de los parámtros 

% This load create the variable : Menaka_parameters_simulink_Structure 
load('Menaka_parameters_simulink_Structure')
parameters = paramsvars2struct(Menaka_parameters_simulink_Structure);
%%
parameters.clima.T0     = 20 + 273.15;
parameters.heater.power = 1e6;
parameters.heater.A_e   = 2.5e-4;
parameters.heater.A_i   = 1e-2;
parameters.heater.c     = 5e-9;
parameters.clima.tau_c  = 0.5;
parameters.WinAR            = 40;
parameters.clima.minWindows = 0.4;
parameters.clima.T_ss       = 8 + 273.15;
parameters.CO2_ppm_ext      = 450;
parameters.subtrate.DraingeConst     = 1e-5;
parameters.irrigation.IrrigationFlow = 3.5e-3;
parameters.irrigation.Xnutrients     = 30*[1.3000e-05 8.6671e-06 4.3329e-06 1.7329e-06 1.7329e-06 8.6710e-07 0 0];
parameters.irrigation.percent_irrigation = 10;
parameters.crop.A_v = 2800;
parameters.maxvelocity = 1;
parameters.crop.VelocityAbsortion = 2;
parameters.tau_win = 4800;
parameters.tinit_crop1 = -days(t0-datetime('16-Feb-2022'));
parameters.tend_crop1 = -days(t0-datetime('01-Aug-2022'));
parameters.tinit_crop2 = -days(t0-datetime('10-Jul-2022'));
parameters.tend_crop2 = -days(t0-datetime('10-Dec-2022'));
parameters.shift_temp_heat = 0;
parameters.gain_max_night = 8;
parameters.Gain_control_Tv_mean = 5;
parameters.Gain_control_Tv_mean_superior = 2.5;
parameters.GAIN_WIN = 1/(0.5*3600);
parameters.RadTh_windows = 50;
%%
% desde la estrutura lo seteamos al modelo;

Menaka_parameters_simulink_Structure = structparams2file(Menaka_parameters_simulink_Structure,parameters);

save('auxiliar_files/Menaka_parameters_simulink_Structure','Menaka_parameters_simulink_Structure')


