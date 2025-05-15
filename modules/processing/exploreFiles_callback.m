%%%%%%%%%%%%%%%%%%%%%%%%%
% Import Data Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%
function exploreFiles_callback(src, ~, axRaw, ddVisualization, ...
         listSample, btnApplyVis, btnDeleteVis, btnEditVis, ...
         btnRange, btnAdd, btnIcoshift, btnBinning, btnDone, btnDelete, ...
         sFirstRange, sLastRange, sFirstPPM, sLastPPM, ...
         ddIcoshiftOption1, ddIcoshiftOption2, ddNormalization, ...
         sWidthBinning, btnRangeView, axPre, btnExportDataW, ...
         btnExportDataCSV, btnIntegration, btnIntegrationDataCSV, ...
         cbxPlot, btnBin2Com)

% Import data
[file,path] = uigetfile( ...
    {'*.csv;*.xlsx;*.xls',...
    'Data Files (*.csv,*.xlsx,*.xls)';
     '*.*',  'All Files (*.*)'}, 'Select a File');

% Loading Window for Importing Data 
%L1 = msgbox('Loading Spectra...','Loading', 'help','modal');

% Loading Window for Importing Data 
fig = ancestor(src, 'figure', 'toplevel');
loadingWindow = uiprogressdlg(fig,'Title','Loading',...
        'Message','Loading Spectra . . .', 'Indeterminate','on');


% Check if a file data is selected
if ischar(file)    
    % Check if a supported format
    if (contains(file,'.csv'))||(contains(file,'.xlsx')) ...
        ||(contains(file,'.xls'))
        % Get the extension of the file
        [~, ~, ext] = fileparts(file);
        % Add the title to the plot
        axRaw.Title.String = ['^1H-NMR Spectra' ext];
        % Save raw data to a matrix
        Raw_1HNMR_Data = transpose(readmatrix(fullfile(path, file)));
        % Delete NaN values
%        Raw_1HNMR_Data = Raw_1HNMR_Data(:,2:end);
        % Make a new matrix from the first row of the data (ppm axis) 
        Raw_ppm_axis = Raw_1HNMR_Data(1,:);
        % Delete the first row
        Raw_1HNMR_Data(1,:) = [];
        % Change the background color of the button to red
        src.BackgroundColor = 'red'; 

        % Disable Processing Options
        btnRange.Enable = 'off';
        btnAdd.Enable = 'off';
        btnIcoshift.Enable = 'off';
        btnBinning.Enable = 'off';
        btnDone.Enable = 'off';
        btnDelete.Enable = 'off';
        sFirstRange.Enable = 'off';
        sLastRange.Enable = 'off';
        sFirstPPM.Enable = 'off';
        sLastPPM.Enable = 'off';
        ddIcoshiftOption1.Enable = 'off';
        ddIcoshiftOption2.Enable = 'off';
        ddNormalization.Enable = 'off';
        sWidthBinning.Enable = 'off';
        btnRangeView.Enable = 'off';
        btnExportDataW.Enable = 'off';
        btnExportDataCSV.Enable = 'off';
        btnIntegration.Enable = "off";
        btnIntegrationDataCSV.Enable = "off";
        cbxPlot.Enable = "off";
        btnBin2Com.Enable = "off";

        % Erase UserData of Exclude Sample Button
        btnDeleteVis.UserData = [];

        % Default values Processing Options
        sFirstPPM.Value = 0;
        sLastPPM.Value = 0;
        ddIcoshiftOption1.Value = 'Average';
        ddIcoshiftOption2.Value = 'Whole';
        ddNormalization.Value = 'None';
        cla(axPre)
        axPre.Title.String = '';
        axPre.XLim = [-0.2 10];

        % Store data in btnApplyVis
        btnApplyVis.UserData = struct("ppm", Raw_ppm_axis, ...
            "RawData", Raw_1HNMR_Data);

        % Change DropDown Visualization Options
        ddVisualization.Items = {'Overlay',...
            'Average','Median'};

        % Set the value of the visualization dropdown to Superimpose
        ddVisualization.Value = 'Overlay';

        % Call the visualization callback function to plot the data
        ddRawVisualization_callback(ddVisualization, [], axRaw, ...
            btnApplyVis, btnDeleteVis, listSample);

        % Obtain Samples
        [row, ~] = size(Raw_1HNMR_Data);

        % Create list of Samples
        Sample_list = strings(1,row+1);
        Sample_listItemData = zeros(1,row+1);
        % Storage of Samples
        Sample_list(1) = "All";
        Sample_listItemData(1) = 0;
        for i = 2:row+1
            Sample_list(i) = "Sample "+num2str(i-1);
            Sample_listItemData(i) = i-1;
        end

        % Enable listSample
        listSample.Enable = 'on';
        % Add items to list
        listSample.Items = Sample_list;
        listSample.ItemsData = Sample_listItemData;
        % Select list's default value
        listSample.Value = 0;
        
        % Storage Sample array in ListSample
        listSample.UserData = row;

        ddVisualization.Enable = 'on';
        listSample.Visible = "on";
        btnApplyVis.Enable = 'on';
        %btnDeleteVis.Enable = 'on';
        %btnEditVis.Enable = "on";

% Close the Loading Window for Importing Data
close(loadingWindow);
     
     
    else
        msgbox('Not supported')
    end
end

end