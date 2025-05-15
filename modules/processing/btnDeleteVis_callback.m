function btnDeleteVis_callback(src, ~, listSample, btnApplyVis, ...
    btnImportData, ddVisualization)
% Recover data in btnApplyVis
data = btnApplyVis.UserData;
%Raw_ppm_axis = data.ppm;
Raw_1HNMR_Data = data.RawData;

if ~isequal(listSample.Value+1,1)
    % Update List Sample
    listSample.Items(listSample.Value+1) = {'__Excluded__'};
    % Disable Exclude Sample button
    src.Enable = 'off';
    % Store de number of sample excluded
    src.UserData = [src.UserData; listSample.Value];
    
    % Calculate number of remaining samples
    totalSamples = transpose(1:size(Raw_1HNMR_Data,1));
    deletedSamples = src.UserData;
    showSamples = setdiff(totalSamples, deletedSamples);
    
    % In case there are no remaining samples
    if isempty(showSamples)
        listSample.Items{1} = 'None';
        src.Enable = 'off';
        ddVisualization.Enable = 'off';
        btnApplyVis.Enable = 'off';
        ddVisualization.Enable = 'off';
        btnImportData.BackgroundColor = [0.7 0.9 1];
    end
end

end