function sim_out = parsevars(name_file,ds,crop,full_data)

%%
% la salida de simulink en el fichero name_file
load(name_file)
%%
%
% Renombramos por legibilidad 
tspan = rt_tout; %  Grid temporal
x_out = rt_yout; % Variables de salida del modelo
%
%
% Creamos un nuevo grid temporal. El modelo se ejecuta con el paso variable
% de la simulink (ode45). Por esta razon puede ocurrir que el paso de timepo entre dos estados sea muy pequeno.
% Dado que la simulacion esta interesada en los resultados a largo plazo de
% del invernadero, interpolaremos la salida de la simulacion a un grid
% temporal mucho mas largo. Tomaremos una medida cada media hora.
% 
new_tspan = tspan(1):(0.5/24):tspan(end);
new_tspan = new_tspan';
%
new_x_out = x_out;
new_x_out.time = new_tspan;

% Existen senales scalares y vectoriales. La interporacion de cada uno de
% ellas es distinta.
for i=[1 3 7 11]
    sg = x_out.signals(i).values;
    sg_p = permute(sg,[3 1 2]);
    sg_interp1 = interp1(tspan,sg_p,new_tspan);
    new_x_out.signals(i).values  = permute(sg_interp1,[2 3 1]);
end

for i=[2 4 5 6 8 9 10 13]
    sg = x_out.signals(i).values;
    sg_interp1 = interp1(tspan,sg,new_tspan);
    new_x_out.signals(i).values  = sg_interp1;
end

% Luego de la interpolacion nos quedamos con los nuevas variables
% interpoladas con un paso de timepo de media hora 
x_out = new_x_out;
tspan = new_tspan;

%%
% Calculamos el grid temporal con fechas 
DT_span = ds.DateTime(1) + days(tspan);

%%
% Parsearemos las distinas senales de salida 
crop_matrix = x_out.signals(1).values;
crop_ds = parseCrop_matrix(crop_matrix);
crop_st =  parseTable2Struct(crop_ds);
%
crop_matrix_2 = x_out.signals(11).values;
crop_ds_2 = parseCrop_matrix(crop_matrix_2);
crop_st_2 =  parseTable2Struct(crop_ds_2);
%
clima_matrix = x_out.signals(2).values;
clima_ds = parseIndoorClimate_matrix(clima_matrix);
clima_st =  parseTable2Struct(clima_ds);
%
subs_matrix = x_out.signals(3).values;
subs_ds = parseSubstrate_matrix(subs_matrix);
subs_st =  parseTable2Struct(subs_ds);
%
cc_matrix = x_out.signals(4).values;
cc_ds = parseControlClimate_matrix(cc_matrix);
cc_st = parseTable2Struct(cc_ds); 
%
%
PowerH2GH  = x_out.signals(5).values(:,1);
PowerH2COM = x_out.signals(5).values(:,2);
Th         = x_out.signals(5).values(:,3);
QV_h_e     = x_out.signals(5).values(:,4);
%
%
tomato_values = (1/crop.fraction_DM)*(x_out.signals(9).values +x_out.signals(10).values )*crop.A_v;
%
ft = permute(x_out.signals(7).values,[1 3 2]);
ft_st.f = ft(1,:);
ft_st.T = ft(2,:);
ft_st.X = ft(3:end,:);

Rad_win = x_out.signals(13).values;
    
% Calculamos el consumo electrico, termico a partir de las senales de
% control
consumo_cum     = Compute_Cost_Accumulated(PowerH2COM,cc_st,DT_span,crop,ft_st,tomato_values);
consumo_monthly = Monthly_Comsume(consumo_cum);
%
kg_tons = sum(consumo_monthly.production/1e3);

    
%%
% guardaremos toda la informacion extraida en la variable sim_out
% esta es la unica variables que saldra de la funcion.
sim_out.DT_span         = DT_span;
sim_out.consumo_cum     = consumo_cum;
sim_out.consumo_monthly = consumo_monthly;
sim_out.tomato_values   = tomato_values;
sim_out.clima_st        = clima_st;
sim_out.crop_st_2       = crop_st_2;
sim_out.crop_st         = crop_st;
sim_out.cc_st           = cc_st;
sim_out.PowerH2COM      = PowerH2COM;
sim_out.Th              = Th;
sim_out.subs_st         = subs_st;
Tmax          = full_data(1);
Tstart        = full_data(2);
Tven_max      = full_data(3);
Tven_start    = full_data(4);
Radthhold     = full_data(5);

sim_out.input_parameters.Tstart        = Tstart;
sim_out.input_parameters.Tmax          = Tmax;
sim_out.input_parameters.Tven_start    = Tven_start;
sim_out.input_parameters.Tven_max      = Tven_max;
sim_out.input_parameters.Radthhold     = Radthhold;

%%
%sim_out.Total_Tomato_Tons = kg_tons;
sim_out.total.tomato = kg_tons;
sim_out.total.thermal = sim_out.consumo_cum.thermal.heater(end)/(1e3*3600);
sim_out.total.electrical = sim_out.consumo_cum.electrical.total(end)/(3600*1e3);
sim_out.total.water_c = sim_out.consumo_cum.water(end);
sim_out.total.nutrients = sum(sim_out.consumo_cum.nutrients(end,:));
    