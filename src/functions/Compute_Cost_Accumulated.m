function consumo = ComputeCostCumulative(PowerH2COM,cc_st,DT_span,crop,ft_st,tomato)


    rtout = days(DT_span - DT_span(1));
    
    consumo = ComputeCost(PowerH2COM,cc_st,DT_span,crop,ft_st,tomato);
    consumo.instant = consumo;
    consumo.thermal.heater = 24*3600*cumtrapz(rtout,consumo.thermal.heater);
    
    for ivar = fieldnames(consumo.electrical)'
        consumo.electrical.(ivar{:}) = 24*3600*cumtrapz(rtout,consumo.electrical.(ivar{:}));
    end
    
    %consumo.nutrients = 24*3600*cumtrapz(rtout,consumo.nutrients');
    consumo.nutrients = 24*3600*cumtrapz(rtout,consumo.nutrients);

    consumo.water = 24*3600*cumtrapz(rtout,consumo.water);

end

