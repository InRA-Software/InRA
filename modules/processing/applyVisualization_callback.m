
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%
function applyVisualization_callback(~, ~, ddNormalization, axPre, ...
    btnRange, btnIcoshift, btnAdd, btnBinning, btnDone, btnDelete, ...
    sFirstRange, sLastRange, sFirstPPM, sLastPPM, ...
    ddIcoshiftOption1, ddIcoshiftOption2, ...
    sWidthBinning, btnRangeView, btnApplyVis, btnExportDataW, ...
    btnExportDataCSV, btnImportData, btnDeleteVis, cbxPlot, btnBin2Com)

% Recover data in btnApplyVis
data = btnApplyVis.UserData;
Raw_ppm_axis = data.ppm;
Raw_1HNMR_Data = data.RawData;

% Calculate the samples to save in CutData
totalSamples = transpose(1:size(Raw_1HNMR_Data,1));
deletedSamples = btnDeleteVis.UserData;
remainingSamples = setdiff(totalSamples, deletedSamples);

CutData = Raw_1HNMR_Data(remainingSamples,:);

% Store data in axPre
axPre.UserData = struct("CutPpm", Raw_ppm_axis, ...
            "CutData", CutData);

% Change DropDown Normalization Options
ddNormalization.Items = {'None', 'Norm-1', 'Norm-2'};

% Enable Buttons
btnRange.Enable = 'on';
btnAdd.Enable = 'on';
btnIcoshift.Enable = 'on';
btnBinning.Enable = 'on';
btnDone.Enable = 'on';
btnDelete.Enable = 'on';
sFirstRange.Enable = 'on';
sLastRange.Enable = 'on';
sFirstPPM.Enable = 'on';
sLastPPM.Enable = 'on';
ddIcoshiftOption1.Enable = 'on';
ddIcoshiftOption2.Enable = 'on';
ddNormalization.Enable = 'on';
sWidthBinning.Enable = 'on';
btnRangeView.Enable = 'on';
btnExportDataW.Enable = 'on';
btnExportDataCSV.Enable = 'on';
cbxPlot.Enable = "on";
btnBin2Com.Enable = "on";
%btnView.Enable = 'on';
btnImportData.BackgroundColor = [0.7 0.9 1];

% Default Values
ddNormalization.Value = "None";
sFirstRange.Value = 0;
sLastRange.Value = 0;
sFirstPPM.Value = 0;
sLastPPM.Value = 0;
ddIcoshiftOption1.Value = "Average";
ddIcoshiftOption2.Value = "Whole";
sWidthBinning.Value = 0.001;

% Reset data for normalization options
ddNormalization.UserData = [];

plot(axPre,Raw_ppm_axis,CutData);
xlim(axPre, [-0.2 10]);

% Add dimensions to the title
  axPre.Title.String = 'Processed ^{1}H-NMR Spectra';
  axPre.Title.Color = 'blue';
% Get the dimensions of the matrix
  [rows, cols] = size(CutData);
% Add dimensions to the plot
  text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
  num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
  'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
  'FontSize', 12, 'Color', 'k');

end
 