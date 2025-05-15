%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binning Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function BinningOther_callback(src, ~, sWidthBinning, axPre, ...
    btnIntegration, ddNormalization, btnBin2Com)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Get the dimensions of the matrix
[rows, ~] = size(Cut_1HNMR_Data);

% Disable Normalization Options
ddNormalization.Enable = "off";
btnBin2Com.Enable = "off";

% Selection of binning width 
width_binning = sWidthBinning.Value;

% Loading Window for Bucketing Spectra
L3 = msgbox('Bucketing Spectra...','Loading', 'help','modal');

% Minimum and maximum range of ppm 
Min_range = min(Cut_ppm_axis);
Max_range = max(Cut_ppm_axis);

% Total number of bins 
num_bins = round((Max_range - Min_range) / width_binning);

% Matrix to store the average values of each bin 
binning_data = zeros(rows, num_bins);

% Binning of 1H-NMR spectra using "Average sum" 
    for i = 1:rows
        for j = 1:num_bins
            bin_indices = Cut_ppm_axis >= (Min_range + (j-1)*width_binning) ...
                & Cut_ppm_axis < (Min_range + j*width_binning);
            binning_data(i, j) = mean(Cut_1HNMR_Data(i, bin_indices));
        end
    end

% Binning ppm 
binning_ppm = linspace(Min_range, Min_range + (num_bins-1) * ... 
    width_binning, num_bins);

% Remove PPM corresponding to NaN Data
binning_ppm(isnan(binning_data(1,:))) = [];
% Remove NaN Data
binning_data(:, isnan(binning_data(1,:))) = [];

% Plot the data 
plot(axPre, binning_ppm, binning_data);

% Get the dimensions of the matrix
        [rows, cols] = size(binning_data);
        % Add dimensions to the title
        dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');

% Enable btnIntegration
btnIntegration.Enable = 'on';

% Close the Loading Window for Bucketing Spectra
close(L3);
        
% Store data in axPre
axPre.UserData = struct("CutPpm", binning_ppm, ...
            "CutData", binning_data);

% Store ppm without binning in Integration Button
btnIntegration.UserData = Cut_ppm_axis;

end

