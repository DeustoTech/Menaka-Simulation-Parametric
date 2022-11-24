
for imap = Menaka_parameters_simulink_Structure.parameters(1).map
    % NPS Name of Parameter in Simulink Model
    % Separado por '__'
    NPS = strsplit(imap.Identifier,'__');
    % 

    if length(NPS)>1
        name = ("parameters." +NPS{1}+".('"+NPS{2}+"')"); 
        to_name = NPS{1}+"__"+NPS{2};
    else
        name = ("parameters."+NPS{1}+"");
        to_name = NPS{1};
    end
    eval(to_name + " = "+ name + ";")
end