clear


r = what('simulations/');
load('simulations/ds')
simulations = {};
iter = 0;
for ifile = r.mat(2:end)'
   iter = iter + 1;
   load(ifile{1}) 
   simulations{iter} = simulation_out;
   fprintf("load simulation nº"+iter+"\n")
end
%%
nc = length(simulations);

tomtato = arrayfun(@(i) simulations{i}.total.tomato,1:nc);
[tomtato,ind]= sort(tomtato);
simulations = simulations(ind);

electrical = arrayfun(@(i) simulations{i}.total.electrical,1:nc);
nutrients = arrayfun(@(i) simulations{i}.total.nutrients,1:nc);
thermal = arrayfun(@(i) simulations{i}.total.thermal,1:nc);
water_c = arrayfun(@(i) simulations{i}.total.water_c,1:nc);

%%
figure(5)
clf

for iii = 1:min(4,nc)
    subplot(2,3,iii)
    hold on
    plot(simulations{iii}.DT_span,simulations{iii}.clima_st.Temp.Tair - 273.15,'LineWidth',2)
    yline(simulations{iii}.input_parameters.Tstart - 273.15,'LineStyle','--','color','b','LineWidth',2)
    yline(simulations{iii}.input_parameters.Tmax - 273.15,'LineStyle','--','color','r','LineWidth',2)

    yline(simulations{iii}.input_parameters.Tven_start - 273.15,'LineStyle','-.','color','b','LineWidth',2)
    yline(simulations{iii}.input_parameters.Tven_max - 273.15,'LineStyle','-.','color','r','LineWidth',2)


    plot(simulations{iii}.DT_span,simulations{iii}.Th - 273.15,'LineWidth',2)
    plot(ds.DateTime,ds.temperature,'LineWidth',2)

    ylabel('T [ºC]')

    ylim([0 35])

    yyaxis right
    ylabel('Windows [%]')

    plot(simulations{iii}.DT_span,simulations{iii}.cc_st.Windows.value,'LineWidth',1)
    xlim([simulations{iii}.DT_span(1) simulations{iii}.DT_span(end)])
    if iii == 1
        legend('T_i','T_{start}','T_{end}','T_{start}^{ven}','T_{end}^{ven}','T_h','T_e','Windows')
    end
    %
        ylim([-5 105])

    xlim([datetime('15-Feb-2022') datetime('25-Feb-2022')])
    title("Simulation"+iii)
end
%%
%%
figure(4)
clf
colors = jet(nc);

for i = 1:3
subplot(2,3,i)
hold on
grid on
end    
subplot(2,3,1)
ylabel('Acumulative kg Tomato')

subplot(2,3,2)
ylabel('Thermal Comsumption (kWh)')

subplot(2,3,3)
ylabel('Electrical Comsumption (kWh)')

for i = 1:nc
    subplot(2,3,1)
    plot(simulations{i}.DT_span,simulations{i}.tomato_values,'color',colors(i,:)); 
    
    %comsumo{i}.consumo_cum.instant.production
    
    
    subplot(2,3,2)
    plot(simulations{i}.DT_span,simulations{i}.consumo_cum.thermal.heater/(1e3*3600),'color',colors(i,:)); 
  %plot(comsumo{iii}{i}.DT_span,comsumo{iii}{i}.crop_st.Carbon.Cfruit); 
  
      subplot(2,3,3)

   plot(simulations{i}.DT_span,simulations{i}.consumo_cum.electrical.total/(3600*1e3),'color',colors(i,:))

end



%
subplot(2,3,4)
cla
hold on
for i = 1:nc
plot3(simulations{i}.total.thermal, ...
      simulations{i}.total.electrical, ...
      simulations{i}.total.tomato,'.','LineStyle','none','MarkerSize',25,'color',colors(i,:))
end
box on
grid on

ylabel('Electrical (kWh)')
xlabel('Thermal (kWh)')
zlabel('Tons Tomato')
view(3)
%
subplot(2,3,5)
cla
hold on
for i = 1:nc
plot3(simulations{i}.total.thermal,simulations{i}.total.water_c,simulations{i}.total.tomato,'.','LineStyle','none','MarkerSize',25,'color',colors(i,:))
end
box on
grid on
xlabel('Thermal (kWh)')
ylabel('Water (kg)')
view(3)

zlabel('Tons Tomato')

%
subplot(2,3,6)
cla
hold on
for i = 1:nc
plot3(simulations{i}.total.thermal, ...
      simulations{i}.total.nutrients, ...
      simulations{i}.total.tomato, ...
      '.','LineStyle','none','MarkerSize',25,'color',colors(i,:))
end
box on
grid on
xlabel('Thermal (kWh)')
ylabel('Nutrients (kg)')
view(3)

zlabel('Tons Tomato')


%%
outputs = {tomtato,thermal,electrical,nutrients,water_c};
names_out = {'kg_tons','thermal','electrical','nutrients','water_c'};
for j = 1:3
    fig = figure(j);
    fig.Name = names_out{j};
    clf
    names = {'Tven_start','Tven_max','Tmax','Tstart','Radthhold'};
    for ivar = 1:5
        subplot(2,3,ivar)
        hold on

        for i = 1:nc
            if strcmp(names{ivar},'Radthhold')
                Tk = 0;
            else
                Tk = 273.15;
            end
            plot(simulations{i}.input_parameters.(names{ivar}) - Tk,outputs{j}(i),'.','LineStyle','none','MarkerSize',25,'color',colors(i,:))
        end
        %ylim([55 65])

        title(names{ivar},'Interpreter','none')

        box on
        grid on
    end
end

%%
% text = printstruct(simulations{1},'printcontents', 1);
% writecell(text,'Parametros')
