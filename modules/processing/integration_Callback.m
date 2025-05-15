%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Integration Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function integration_Callback(src, ~, axPre, btnIntegrationDataCSV)

% Recover data in axPre
data = axPre.UserData;
binned_ppm = data.CutPpm;
binned_1HNMR_Data = data.CutData;

% Recover ppm without binning
Cut_ppm_axis = src.UserData;

% Enable Export Integration Data
btnIntegrationDataCSV.Enable = "on";

% Buscando índices que cumplen w(i+1)-w(1) ~ Binning_Step
idxD = 0;     
binning_step = binned_ppm(3)-binned_ppm(2);
while Cut_ppm_axis(1+idxD)-Cut_ppm_axis(1) <= binning_step
    idxD = idxD + 1;
end

numSamples = size(binned_1HNMR_Data,1);
numCol = size(Cut_ppm_axis,2);
numBin = size(binned_ppm,2);

interpolateObjects = cell(numSamples,1);
interpolatedData = zeros(numSamples, numCol);

% Interpolated data to numerical integration
for ii = 1:numSamples
    interpolateObjects{ii} = ...
        griddedInterpolant(binned_ppm, binned_1HNMR_Data(ii,:));
    interpolatedData(ii,:) = interpolateObjects{ii}(Cut_ppm_axis);
end

integratedData = zeros(numSamples,numBin-2);

for jj = 1:numSamples 
    integratedData(jj,1) = trapz(Cut_ppm_axis(1:idxD), ...
            interpolatedData(jj,1:idxD));
    for ii = 1:numBin-2
        startInd = (ii)*idxD-ii;
        endInd = (ii+1)*idxD-ii;
        integratedData(jj,ii) = trapz(Cut_ppm_axis(startInd:endInd), ...
            interpolatedData(jj, startInd:endInd));
    end
end

% Store Integrated Data
btnIntegrationDataCSV.UserData.BinnedPpm = binned_ppm(1:end-2);
btnIntegrationDataCSV.UserData.IntegratedData = integratedData;

figIntegration = ancestor(src, 'figure', 'toplevel');
uialert(figIntegration,"Integration Done.","Message","Icon","info");


end

