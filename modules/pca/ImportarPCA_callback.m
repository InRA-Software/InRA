function ImportarPCA_callback(~, ~, listMCR, tabPCA)
% Store MCRdata cell array in listMCR object
listMCR.UserData = evalin('base','MCRdata');

% Store concentrations array in tabPCA object
tabPCA.UserData = evalin('base','concentrations');

disp("Datos Cargado, jefazo!")

end

