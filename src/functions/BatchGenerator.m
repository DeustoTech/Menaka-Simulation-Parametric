function full_data = BatchGenerator(nsamples)
% Creamos una matrix full_data
% Tendra en cada columna: 
%    - Tmax_h_ms(:)   Temperatura de apagado del heater cuando esta encendido
%    - Tmin_h_ms(:)   Temperatura de encendido del heater cuando esta apagado
%    - Tmax_w_ms(:)   Temperatura del aire del invernadero para que las ventanas cenitales estes abiertas al 100%
%    - Tmin_w_ms(:)   Temperatura del aire del invernadero cuando empiezan
%                     abrirse las ventanas. Tambien llamado temperatura de
%                     ventilacion
%    - Radth_ms(:)    Radiacion cuando las pantallas de sombreo se cierran
% 
% nsamples es el numero de particiones que tendremos en cada variable. 
% en principio generariamos nsamples^5 simulaciones. Sin embargo existe
% restricciones entre las variables. 
% Se debe cumplir que:
% 
% - Que la temperatura de apagado sea mayor que la temperatura de encendido
%           Tmax_h_ms(:) > Tmin_h_ms(:)
% 
% - Que la temperauta de ventilacion sea menor que la temperatura con
% ventana abierta al maximo.
%           Tmax_w_ms(:) > Tmin_w_ms( :)
% 

Tk = 273.15;
Tmax_h_ls = linspace(6,20,nsamples) + Tk;
Tmin_h_ls = linspace(6,20,nsamples) + Tk;
Tmax_w_ls = linspace(6,20,nsamples) + Tk;
Tmin_w_ls = linspace(6,20,nsamples) + Tk;
Radth_ls  = linspace(300,1000,nsamples);

[Tmax_h_ms,Tmin_h_ms,Tmax_w_ms,Tmin_w_ms,Radth_ms] = ndgrid(Tmax_h_ls,Tmin_h_ls,Tmax_w_ls,Tmin_w_ls,Radth_ls);

full_data = [Tmax_h_ms(:),Tmin_h_ms(:),Tmax_w_ms(:),Tmin_w_ms(:),Radth_ms(:)];

% Removemos los conjuntos de paramteros que no cumple la restriccion
ind1 = Tmax_h_ms(:) <= Tmin_h_ms(:);
ind2 = Tmax_w_ms(:) <= Tmin_w_ms(:);

ind = ind1 + ind2;
ind(ind > 0) = 1;
full_data(logical(ind),:) = [];