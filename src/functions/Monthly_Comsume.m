function consumo = ReshapeComsume(consumo_cum)


DateTime = consumo_cum.DateTime;

new_tspan_index  = logical(diff(DateTime.Month));

%
new_tspan = DateTime(new_tspan_index);

new_tspan.Hour = 0;
new_tspan.Minute = 0;
new_tspan.Second = 0;

new_tspan = new_tspan + days(1);

t0 = DateTime(1);
t0.Hour = 0;
t0.Minute = 0;
t0.Second = 0;

if new_tspan(1) ~= t0
    new_tspan = [ t0 ;new_tspan];
end

tf = DateTime(end);
tf.Hour = 0;
tf.Minute = 0;
tf.Second = 0;
tf = tf + days(1);

if new_tspan(end) ~= tf
    tf.Month = tf.Month+1;
    tf.Day = 1;
    new_tspan = [ new_tspan ; tf];
end

%%
consumo.DateTime = new_tspan(2:end);
consumo.DateTime.Month = consumo.DateTime.Month - 1;

idx = seconds(diff(DateTime))> 1;
DateTime = DateTime(idx);
consumo_cum.water = consumo_cum.water(idx);

consumo.water = interp1(DateTime,consumo_cum.water,new_tspan,'nearest','extrap');
consumo.water = diff(consumo.water);
%

consumo.nutrients = interp1(DateTime,consumo_cum.nutrients(idx),new_tspan,'nearest','extrap');
consumo.nutrients = diff(consumo.nutrients);

consumo.thermal.heater = interp1(DateTime,consumo_cum.thermal.heater(idx),new_tspan,'nearest','extrap');
consumo.thermal.heater = diff(consumo.thermal.heater);
%
for ivar = fieldnames(consumo_cum.electrical)'
    cce = consumo_cum.electrical.(ivar{:});
    cce = cce(idx);
consumo.electrical.(ivar{:}) = interp1(DateTime,cce,new_tspan,'nearest','extrap');
consumo.electrical.(ivar{:}) = diff(consumo.electrical.(ivar{:}));
%
consumo.production = interp1(DateTime,consumo_cum.production(idx),new_tspan,'nearest','extrap');

consumo.production = diff(consumo.production);
consumo.production(consumo.production < 0) = 0;
end

