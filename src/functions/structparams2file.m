function Menaka_parameters_simulink_Structure = structparams2file(Menaka_parameters_simulink_Structure,parameters)
for imap = Menaka_parameters_simulink_Structure.parameters(1).map
    % NPS Name of Parameter in Simulink Model
    % Separado por '__'
    NPS = strsplit(imap.Identifier,'__');
    % 
    % Examples
% --------------------------
%
% >> NPS = 
%           1×1 cell array
%             {'CO2_ppm_ext'}
% 
% --------------------------
% >> NPS =
%           1×2 cell array
%           {'clima'}    {'G0'}
%
% --------------------------
  
    if length(NPS)>1
        name = ("parameters." +NPS{1}+".('"+NPS{2}+"')");        
    else
        name = ("parameters."+NPS{1}+"");
    end
    eval("Menaka_parameters_simulink_Structure.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2)) = "+name+";")
end
%
