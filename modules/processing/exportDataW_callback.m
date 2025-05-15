%%%%%%%%%%%%%%%%%%%%%%%%%
% Export Data Workspace %
%%%%%%%%%%%%%%%%%%%%%%%%%
function exportDataW_callback(src, ~, axPre)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Prompt the user for the matrix name
prompt = {'Enter matrix name for ppm Values', ['Enter matrix name ' ...
    'for Intensity Values']};
dlgtitle = 'Export to Workspace';
dims = [1 50];
definput = {'ppm_axis', 'Intensity_1HNMR'};
matrixNames = inputdlg(prompt, dlgtitle, dims, definput);

% Export data as a matrix to workspace
if ~isempty(matrixNames)
    assignin('base',matrixNames{1},Cut_ppm_axis);
    assignin('base',matrixNames{2},Cut_1HNMR_Data);
end

end
