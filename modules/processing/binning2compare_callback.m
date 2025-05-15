%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binning Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function binning2compare_callback(src, ~, sWidthBinning, axPre, ...
     btnComparativePre)

% Loading Window for Aligning Spectra 
figLo = ancestor(src, 'figure', 'toplevel');
loadingWindow = uiprogressdlg(figLo,'Title','Loading',...
        'Message','Bucketing Spectra . . .', 'Indeterminate','on');

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Get the dimensions of the matrix
[rows, ~] = size(Cut_1HNMR_Data);


% Selection of binning width 
width_binning = sWidthBinning.Value;

% Loading Window for Bucketing Spectra
%L3 = msgbox('Bucketing Spectra...','Loading', 'help','modal');

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

%%%%%%%%%%%%%%%%%%
% Figure to plot %
%%%%%%%%%%%%%%%%%%
% Create
figBin2Com = uifigure();
figBin2Com.Position = [455 300 820 300];
% Style
figBin2Com.Name = "Binning to Compare";
figBin2Com.WindowStyle = 'modal';
figBin2Com.Resize = "on";
% Create layout
glBin2Com = uigridlayout(figBin2Com,[1,1]);
glBin2Com.RowHeight = {'1x'};

% Information Message
uialert(figBin2Com, "Spectra with and without bucketing has been saved to compare","Info", ...
    'icon', 'info');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Axe to plot binned Spectra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create
axB2C = uiaxes(glBin2Com);
% Positions
axB2C.Layout.Row = 1;
axB2C.Layout.Column = 1;
% Style
axB2C.XDir = 'reverse';
axB2C.XLabel.String = 'δ^{1}H(ppm)';
axB2C.YLabel.String = 'Intensity';
axB2C.XLim = [min(binning_ppm, [], "all"), max(binning_ppm, [], "all")];

% Plot Binned Spectra
plot(axB2C, binning_ppm, binning_data);

% Get the dimensions of the matrix
[rows, cols] = size(binning_data);
% Add dimensions to the title
text(axB2C, 0.02, 0.95, ['Matrix Size: ' ...
    num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
    'FontSize', 12, 'Color', 'k');

% Store Data in Comparative Treatment Button
btnComparativePre.UserData.InUse = 3;
btnComparativePre.UserData.BinnedPpm = binning_ppm;
btnComparativePre.UserData.BinnedData = binning_data;
btnComparativePre.UserData.OriginalPpm = Cut_ppm_axis;
btnComparativePre.UserData.OriginalData = Cut_1HNMR_Data;

% Close the Loading Window for Bucketing Spectra
close(loadingWindow)
delete(loadingWindow)

end

