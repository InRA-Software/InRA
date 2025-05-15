%%%%%%%%%%%%%%%%%%%%%%%%%
% Export Data CSV %
%%%%%%%%%%%%%%%%%%%%%%%%%
function exportDataCSV_callback(src, ~, axPre)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% User put file's name and where to save it
[file,path] = uiputfile('*.csv');
filename = fullfile(path,file);

% Export data to external csv file with user file's name
if ~isequal(file,0) || ~isequal(path,0)
    writematrix(transpose([Cut_ppm_axis; Cut_1HNMR_Data]), filename);
end

end 