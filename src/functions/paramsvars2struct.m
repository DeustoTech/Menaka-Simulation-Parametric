function parameters = paramsvars2struct(parameters_simulink)
% cargamos la estrutura de paramteros de modelo. Este tiene el formato
% exigido por simulink

%% Leemos los parámetros disponibles en el modelo  y lo convertimos a structura
iter = 0;
for imap = parameters_simulink.parameters(1).map
    iter = iter + 1;
    nnn = strsplit(imap.Identifier,'__');
    if length(nnn)>1
        eval("parameters."+nnn{1}+".('"+nnn{2}+"') = parameters_simulink.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2));")
    else
        eval("parameters."+nnn{1}+" =  parameters_simulink.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2));")
    end
end