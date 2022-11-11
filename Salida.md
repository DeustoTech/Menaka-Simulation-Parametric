```
   |    
   |--- cc_st                                                        % Estructura que contiene la variacion de los controles                                                        
   |       |    
   |       |--- Screen                                                     % Pantalla de sombreo
   |       |       |    
   |       |       |------- beta :  [17281x1 Array]                              % Efecto termico de la pantalla de sombreo [-]
   |       |       |-- gamma_max :  [17281x1 Array]                              % atenuacion máxima de la pantalla de sombreo (generalmente constante) [-]
   |       |       |------ value :  [17281x1 Array]                              % posicion de la pantalla de sombreo [%]
   |       |    
   |       |--- Windows                                                    % Ventana 
   |       |       |     
   |       |       |----- AR :  [17281x1 Array]                                  % Area efectiva de la ventana [m^2]
   |       |       |-- value :  [17281x1 Array]                                  % posicion de la ventana [%]
   |       |    
   |       |------ CO2 :  [17281x1 Array]                                  % Flujo de CO2 [kg/s] desde una bomba artificial
   |       |------ Fog :  [17281x1 Array]                                  % Flujo de vapor de agua desde un sistema de humidificación 
   |    
   |--- clima_st                                                     % Estructura de clima 
   |       |    
   |       |--- Gas                                                      % Estructura de gases 
   |       |       |    
   |       |       |--- MC                                                   % Flujos de carbono
   |       |       |       |    
   |       |       |       |--- MC_i_e :  [17281x1 Array]                        % Flujo de CO2 desde el aire hacia el aire exterior [kg{CO2}/s]
   |       |       |       |-- MC_pump :  [17281x1 Array]                        % Flujo de CO2 de bomba artificial [kg{CO2}/s]
   |       |       |       |--- MC_v_i :  [17281x1 Array]                        % Flujo de CO2 desde la vegetación hacia el aire [kg{CO2}/s]
   |       |       |    
   |       |       |--- MW                                                % Flujo de vapor de agua 
   |       |       |       |    
   |       |       |       |-- MW_i_e :  [17281x1 Array]                         % Flujo de vapor agua desde el aire interior hacia el exterior [kg{H2O}/s]
   |       |       |       |-- QP_i_c :  [17281x1 Array]                         % Flujo de vapor agua desde el aire interior hacia la cubierta [kg{H2O}/s] (por condensacion)
   |       |       |       |-- QP_i_f :  [17281x1 Array]                         % Flujo de vapor agua desde el aire interior hacia el suelo [kg{H2O}/s] (por condensacion)
   |       |       |       |------ QT :  [17281x1 Array]                         % Flujo de vapor agua por Transpiracion de las plantas [kg{H2O}/s]
   |       |       |       |---- Qfog :  [17281x1 Array]                         % Flujo de vapor agua por sistema de humidificacion 
   |       |       |    
   |       |       |---------- C_c :  [17281x1 Array]          % Concentracion de CO2 en el aire interior [kg{CO2}/m^2]
   |       |       |------ C_c_ppm :  [17281x1 Array]          % Concentracion de CO2 en el aire interior [ppm]
   |       |       |--------- C_ce :  [17281x1 Array]          % Concentracion de CO2 en el exterior interior [kg{CO2}/m^2] (constante)
   |       |       |----- C_ce_ppm :  [17281x1 Array]          % Concentracion de CO2 en el exterior interior [ppm] (constante)
   |       |       |---------- C_w :  [17281x1 Array]          % Humedad Absoluta interior [kg{H2O}/m^3]
   |       |       |-- C_w_sat_T_c :  [17281x1 Array]          % Concentracion de saturación de humedad en la cubierta (T_c temperatura de cubierta) [kg{H2O}/m^3]
   |       |       |-- C_w_sat_T_f :  [17281x1 Array]          % Concentracion de saturación de humedad en el suelo (T_f temperatura de cubierta) [kg{H2O}/m^3]
   |       |       |-------- HRInt :  [17281x1 Array]          % Humedad Relativa interior [%]
   |       |       |----------- Xh :  [17281x1 Array]          % Ratio de humedad [-]https://www.engineeringtoolbox.com/humidity-ratio-air-d_686.html
   |       |       |------- Xh_sat :  [17281x1 Array]          % Ratio de humedad de saturación [-]
   |       |       |---- air_speed :  [17281x1 Array]          % Velocidad de aire interior [m/s]
   |       |       |---------- p_a :  [17281x1 Array]          % Presion de aire [Pa]
   |       |       |-------- rho_i :  [17281x1 Array]          % Densidad del aire [kg/m^3]
   |       |    
   |       |--- QD
   |       |       |    
   |       |       |-- QD_s12 :  [17281x1 Array]         % Calor por conducción entre el suelo y el subsuelo [W]
   |       |       |-- QD_sf1 :  [17281x1 Array]         % Calor por conduccion entre el subsuelo y el subsuelo 2 [W]
   |       |    
   |       |--- QR
   |       |       |    
   |       |       |-- QR_c_e :  [17281x1 Array]         % Calor por radiacion desde la cubierta al exterior [W]
   |       |    
   |       |--- QS
   |       |       |    
   |       |       |-- QS_c_abs :  [17281x1 Array]       % Calor solar absorbido por la cubierta [W]
   |       |       |-- QS_f_abs :  [17281x1 Array]       % Calor solar absorbido por el suelo [W]
   |       |       |-- QS_i_abs :  [17281x1 Array]       % Calor solar absorbido por el aire [W]
   |       |       |---- QS_tot :  [17281x1 Array]       % Calor solar total recibido [W]
   |       |       |----- R_int :  [17281x1 Array]       % Radiacion interior 
   |       |    
   |       |--- QT
   |       |       |    
   |       |       |---- QT :  [17281x1 Array]           % Calor latente por transpiracion de las plantas
   |       |       |-- Qfog :  [17281x1 Array]           % Calor latenten por evaporacion desde el sistema de humidificacion 
   |       |    
   |       |--- QV
   |       |       |    
   |       |       |-- QV_c_e :  [17281x1 Array]      % Calor sensible desde la cubierta hacia el exterior 
   |       |       |---- QV_i :  [17281x1 Array]      % Calor sensible desde el puerto EXT que contiente el modelo de climta, en este modelo concreto QV_i = Calor con las plantas y el heater
   |       |       |-- QV_i_c :  [17281x1 Array]      % Calor sensible desde el aire hacia la cubierta
   |       |       |-- QV_i_e :  [17281x1 Array]      % Calor sensible desde el aire hacia el exterior (ventilacion)
   |       |       |-- QV_i_f :  [17281x1 Array]      % Calor sensible desde el aire hacia el suelo
   |       |    
   |       |--- Temp
   |       |       |    
   |       |       |---- Tair :  [17281x1 Array]      % Temperatura del aire  [K]
   |       |       |-- Tcover :  [17281x1 Array]      % Temperatura de la cubieta   [K]
   |       |       |-- Tfloor :  [17281x1 Array]      % Temperatura del suelo [K]
   |       |       |--- Tsoil :  [17281x1 Array]      % Temperatura del subsuelo [K]
   |       |    
   |       |----- R :  [17281x1 Array]    % Radiacion interior 
   |    
   |--- consumo_cum
   |       |    
   |       |--- electrical
   |       |       |    
   |       |       |------ heater :  [17281x1 Array]  % Comsumo electrico del heater acumulado
   |       |       |-- irrigation :  [17281x1 Array]  % consumo electrico de la irrigacion acumulado
   |       |       |------ screen :  [17281x1 Array]  % Consumo electrico de la pantalla de sombreo acumulado
   |       |       |------- total :  [17281x1 Array]  % Comsumo electrico total acumulado 
   |       |       |----- windows :  [17281x1 Array]  % Consumo ellectrico de las ventanas 
   |       |    
   |       |--- instant
   |       |       |    
   |       |       |--- electrical
   |       |       |       |    
   |       |       |       |------ heater :  [17281x1 Array]
   |       |       |       |-- irrigation :  [17281x1 Array]
   |       |       |       |------ screen :  [17281x1 Array]
   |       |       |       |------- total :  [17281x1 Array]
   |       |       |       |----- windows :  [17281x1 Array]
   |       |       |    
   |       |       |--- thermal
   |       |       |       |    
   |       |       |       |-- heater :  [17281x1 Array]
   |       |       |    
   |       |       |-- production :  [17281x1 Array]
   |       |       |------- water :  [17281x1 Array]
   |       |       |--- nutrients : [17281x8 Array]
   |       |       |---- DateTime : [17281x1 Unknown]
   |       |    
   |       |--- thermal
   |       |       |    
   |       |       |-- heater :  [17281x1 Array]
   |       |    
   |       |-- production :  [17281x1 Array]
   |       |------- water :  [17281x1 Array]
   |       |--- nutrients : [17281x8 Array]
   |       |---- DateTime : [17281x1 Unknown]
   |    
   |--- consumo_monthly
   |       |    
   |       |--- electrical
   |       |       |    
   |       |       |------ heater : [3.20197e+09 9.36444e+08 1.5339e+09 0 0 0 0 0 3.25381e+07 7.89679e+08 2.56647e+09 4.82879e+09]
   |       |       |-- irrigation : [1.30536e+09 2.04624e+09 2.54016e+09 3.59856e+09 3.3516e+09 3.7044e+09 3.21048e+09 2.43432e+09 1.764e+09 7.7616e+08 2.1168e+08 4.2336e+08]
   |       |       |------ screen : [5.09819e+08 5.64683e+08 6.26738e+08 6.4946e+08 5.7374e+08 7.54367e+08 8.17232e+08 1.00996e+09 7.43663e+08 7.79961e+08 7.25198e+08 7.4272e+08]
   |       |       |------- total : [5.82231e+09 4.43622e+09 5.55673e+09 5.13013e+09 4.78517e+09 5.32927e+09 4.90982e+09 4.30254e+09 3.42874e+09 3.20352e+09 4.39564e+09 6.74347e+09]
   |       |       |----- windows : [8.05166e+08 8.88854e+08 8.5594e+08 8.82108e+08 8.59832e+08 8.70506e+08 8.82109e+08 8.58257e+08 8.88537e+08 8.57722e+08 8.92291e+08 7.48608e+08]
   |       |    
   |       |--- thermal
   |       |       |    
   |       |       |-- heater : [1.05139e+11 1.80958e+10 5.35895e+10 0 0 0 0 0 6.00294e+08 3.58437e+10 7.52768e+10 2.14164e+11]
   |       |    
   |       |--- nutrients : [254.545 399.017 495.331 701.719 653.562 722.358 626.044 474.692 343.98 151.351 41.2776 82.5552]
   |       |-- production : [0 0 0 13719.5 14053.8 2801.77 0 12914.1 12100.1 302.866 0 1.06581e-13]
   |       |------- water : [652680 1.02312e+06 1.27008e+06 1.79928e+06 1.6758e+06 1.8522e+06 1.60524e+06 1.21716e+06 882000 388080 105840 211680]
   |       |---- DateTime : [12x1 Unknown]
   |    
   |--- crop_st
   |       |    
   |       |--- Carbon
   |       |       |    
   |       |       |--- Cbuff :  [17281x1 Array]
   |       |       |-- Cfruit :  [17281x1 Array]
   |       |       |--- Cleaf :  [17281x1 Array]
   |       |       |--- Cstem :  [17281x1 Array]
   |       |    
   |       |--- HeatVars
   |       |       |    
   |       |       |-------- QS :  [17281x1 Array]
   |       |       |-------- QT :  [17281x1 Array]
   |       |       |-------- QV :  [17281x1 Array]
   |       |       |------ Tveg :  [17281x1 Array]
   |       |       |-- TvegMean :  [17281x1 Array]
   |       |    
   |       |--- MC_gro
   |       |       |    
   |       |       |-- MC_buf_fruit :  [17281x1 Array]
   |       |       |--- MC_buf_leaf :  [17281x1 Array]
   |       |       |--- MC_buf_stem :  [17281x1 Array]
   |       |    
   |       |--- Nutrients
   |       |       |    
   |       |       |-- Demand : [17281x8 Array]
   |       |       |---- Mass : [17281x8 Array]
   |       |    
   |       |--- Relative
   |       |       |    
   |       |       |-- Rfruit :  [17281x1 Array]
   |       |       |--- Rleaf :  [17281x1 Array]
   |       |       |--- Rstem :  [17281x1 Array]
   |       |    
   |       |--- Water
   |       |       |    
   |       |       |--- WaterFlows
   |       |       |       |    
   |       |       |       |-------- MW_QT :  [17281x1 Array]
   |       |       |       |-- WaterDemand :  [17281x1 Array]
   |       |       |       |-- WaterUptake :  [17281x1 Array]
   |       |       |    
   |       |       |--- WaterState
   |       |       |       |    
   |       |       |       |-- VegWater :  [17281x1 Array]
   |       |       |    
   |       |    
   |       |--- carbon_cc
   |       |       |    
   |       |       |---- MC_buf_i :  [17281x1 Array]
   |       |       |-- MC_fruit_i :  [17281x1 Array]
   |       |       |---- MC_i_buf :  [17281x1 Array]
   |       |       |--- MC_leaf_i :  [17281x1 Array]
   |       |       |--- MC_stem_i :  [17281x1 Array]
   |       |    
   |       |--- h
   |       |       |    
   |       |       |------- g_T_v24 :  [17281x1 Array]
   |       |       |--------- h_T_v :  [17281x1 Array]
   |       |       |------- h_T_v24 :  [17281x1 Array]
   |       |       |------ h_T_vsum :  [17281x1 Array]
   |       |       |-- h_buforg_buf :  [17281x1 Array]
   |       |       |---------- hini :  [17281x1 Array]
   |       |    
   |       |--- photo
   |       |       |    
   |       |       |-- C_stom :  [17281x1 Array]
   |       |       |--- Gamma :  [17281x1 Array]
   |       |       |------- J :  [17281x1 Array]
   |       |       |--- J_pot :  [17281x1 Array]
   |       |       |------- P :  [17281x1 Array]
   |       |       |----- PAR :  [17281x1 Array]
   |       |       |---- Resp :  [17281x1 Array]
   |       |    
   |       |------------- A_v :  [17281x1 Array]
   |       |-------------- CC :  [17281x1 Array]
   |       |--------- C_Total :  [17281x1 Array]
   |       |------------- LAI :  [17281x1 Array]
   |       |------------ Tsum :  [17281x1 Array]
   |       |------------- VPD :  [17281x1 Array]
   |       |-------------- WC :  [17281x1 Array]
   |       |---- WaterPercent :  [17281x1 Array]
   |       |-- plants_density :  [17281x1 Array]
   |    
   |--- crop_st_2
   |       |    
   |       |--- Carbon
   |       |       |    
   |       |       |--- Cbuff :  [17281x1 Array]
   |       |       |-- Cfruit :  [17281x1 Array]
   |       |       |--- Cleaf :  [17281x1 Array]
   |       |       |--- Cstem :  [17281x1 Array]
   |       |    
   |       |--- HeatVars
   |       |       |    
   |       |       |-------- QS :  [17281x1 Array]
   |       |       |-------- QT :  [17281x1 Array]
   |       |       |-------- QV :  [17281x1 Array]
   |       |       |------ Tveg :  [17281x1 Array]
   |       |       |-- TvegMean :  [17281x1 Array]
   |       |    
   |       |--- MC_gro
   |       |       |    
   |       |       |-- MC_buf_fruit :  [17281x1 Array]
   |       |       |--- MC_buf_leaf :  [17281x1 Array]
   |       |       |--- MC_buf_stem :  [17281x1 Array]
   |       |    
   |       |--- Nutrients
   |       |       |    
   |       |       |-- Demand : [17281x8 Array]
   |       |       |---- Mass : [17281x8 Array]
   |       |    
   |       |--- Relative
   |       |       |    
   |       |       |-- Rfruit :  [17281x1 Array]
   |       |       |--- Rleaf :  [17281x1 Array]
   |       |       |--- Rstem :  [17281x1 Array]
   |       |    
   |       |--- Water
   |       |       |    
   |       |       |--- WaterFlows
   |       |       |       |    
   |       |       |       |-------- MW_QT :  [17281x1 Array]
   |       |       |       |-- WaterDemand :  [17281x1 Array]
   |       |       |       |-- WaterUptake :  [17281x1 Array]
   |       |       |    
   |       |       |--- WaterState
   |       |       |       |    
   |       |       |       |-- VegWater :  [17281x1 Array]
   |       |       |    
   |       |    
   |       |--- carbon_cc
   |       |       |    
   |       |       |---- MC_buf_i :  [17281x1 Array]
   |       |       |-- MC_fruit_i :  [17281x1 Array]
   |       |       |---- MC_i_buf :  [17281x1 Array]
   |       |       |--- MC_leaf_i :  [17281x1 Array]
   |       |       |--- MC_stem_i :  [17281x1 Array]
   |       |    
   |       |--- h
   |       |       |    
   |       |       |------- g_T_v24 :  [17281x1 Array]
   |       |       |--------- h_T_v :  [17281x1 Array]
   |       |       |------- h_T_v24 :  [17281x1 Array]
   |       |       |------ h_T_vsum :  [17281x1 Array]
   |       |       |-- h_buforg_buf :  [17281x1 Array]
   |       |       |---------- hini :  [17281x1 Array]
   |       |    
   |       |--- photo
   |       |       |    
   |       |       |-- C_stom :  [17281x1 Array]
   |       |       |--- Gamma :  [17281x1 Array]
   |       |       |------- J :  [17281x1 Array]
   |       |       |--- J_pot :  [17281x1 Array]
   |       |       |------- P :  [17281x1 Array]
   |       |       |----- PAR :  [17281x1 Array]
   |       |       |---- Resp :  [17281x1 Array]
   |       |    
   |       |------------- A_v :  [17281x1 Array]
   |       |-------------- CC :  [17281x1 Array]
   |       |--------- C_Total :  [17281x1 Array]
   |       |------------- LAI :  [17281x1 Array]
   |       |------------ Tsum :  [17281x1 Array]
   |       |------------- VPD :  [17281x1 Array]
   |       |-------------- WC :  [17281x1 Array]
   |       |---- WaterPercent :  [17281x1 Array]
   |       |-- plants_density :  [17281x1 Array]
   |    
   |--- input_parameters
   |       |    
   |       |--- Radthhold : 300
   |       |-------- Tmax : 286.15
   |       |------ Tstart : 279.15
   |       |---- Tven_max : 286.15
   |       |-- Tven_start : 279.15
   |    
   |--- subs_st
   |       |    
   |       |--- Drainge
   |       |       |    
   |       |       |-- T :  [17281x1 Array]
   |       |       |-- f :  [17281x1 Array]
   |       |       |-- X : [17281x8 Array]
   |       |    
   |       |--- SusWater
   |       |       |    
   |       |       |-- VT :  [17281x1 Array]
   |       |    
   |       |--- Uptake
   |       |       |    
   |       |       |-- Water :  [17281x1 Array]
   |       |    
   |       |------ Mass : [17281x8 Array]
   |    
   |--- total
   |       |    
   |       |-- electrical : 16123.2
   |       |--- nutrients : 11541.5
   |       |----- thermal : 139641
   |       |------ tomato : 55.8922
   |       |----- water_c : 1.26832e+07
   |    
   |-------- PowerH2COM :  [17281x1 Array]
   |---------------- Th :  [17281x1 Array]
   |----- tomato_values :  [17281x1 Array]
   |----------- DT_span : [17281x1 Unknown]
```