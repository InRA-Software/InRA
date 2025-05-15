%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Export Integrated Data CSV %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function exportIntegratedDataCSV(src, ~)

% Recover data in btnIntegrationDataCSV
BinnedPpm = src.UserData.BinnedPpm;
IntegratedData = src.UserData.IntegratedData;

% User put file's name and where to save it
[file,path] = uiputfile('*.csv');
filename = fullfile(path,file);

% Export data to external csv file with user file's name
if ~isequal(file,0) || ~isequal(path,0)
    writematrix(transpose([BinnedPpm; IntegratedData]), filename);
end

end 

