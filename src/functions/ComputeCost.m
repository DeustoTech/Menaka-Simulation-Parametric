function consumo = ComputeCost(PowerH2COM,cc_st,DT_span,crop,ft_st,tomato)

    rt_tout = days(DT_span - DT_span(1));
    consumo = [];

    consumo.thermal.heater = PowerH2COM;

    %%
    dHdt = gradient(PowerH2COM,rt_tout) ;
    dHdt(dHdt<=0) = 0;
    dHdt(dHdt>0) = 1;
    
    maxpower_on = 5000;
    maxpower = 6000;

    consumo.electrical.heater  = maxpower*PowerH2COM/max(PowerH2COM) +maxpower_on*dHdt;
    %%

    load_curve = (1/(24*3600))*abs(gradient(cc_st.Windows.value,rt_tout));

    %max_win = max(load_curve);
    max_win =0.0167;
    max_power_windows = 2400; % 
    load_curve = max_power_windows*load_curve/max_win;
    consumo.electrical.windows = load_curve;
    
    %%
    load_curve = (1/(24*3600))*abs(gradient(cc_st.Screen.value,rt_tout));

    max_win = max(load_curve);
    max_power_screen = 2400; % 
    load_curve = max_power_screen*load_curve/max_win;
    
    consumo.electrical.screen  = load_curve;
    %%
    ft_flow  =  crop.A_v.*ft_st.f;   % [kg{H2O}/m^2] -> [kg{H2O}]
    mass_nutr = ft_st.X.*ft_flow;    % [kg{H2O}]x[]
    % 
    consumo.nutrients = mass_nutr';
    consumo.water = ft_flow';
    
    power_irrigation = 2000;
    %consumo.electrical.irrigation  = power_irrigation*ft_flow';
    consumo.electrical.irrigation  = power_irrigation*ft_flow';

    %base = 110/3e6;
    consumo.electrical.total = consumo.electrical.irrigation  +  ...
                               consumo.electrical.heater      +  ...
                               consumo.electrical.windows      +  ...
                               consumo.electrical.screen      ;
                           
                           

    consumo.DateTime = DT_span ;
    
    tomato(tomato<=0) = 0;
    consumo.production = tomato;
end

