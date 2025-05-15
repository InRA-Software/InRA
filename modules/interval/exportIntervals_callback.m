%%%%%%%%%%%%%%%%%%%%
% Export Intervals %
%%%%%%%%%%%%%%%%%%%%
function exportIntervals_callback(src, ~, axPre, listInterRngMin, ...
    listInterRngMdd, listInterRngMax)

% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

% Recover data in listInterval
intervals = {listInterRngMin.UserData, listInterRngMdd.UserData, ...
    listInterRngMax.UserData};

if size(intervals,2)==3
    for i=1:3
        % Number of intervals to save
        nSave = size(intervals{i},1);

        % Create empty cell array to save ppm and intensities for each interval
        PpmIntensities = cell(nSave,2);

        % Save ppm and intesities for each non empty interval
        for k = 1:nSave
            % Find indices of Interval k
            [lowInd, highInd] = findIndex(intervals{i}(k,1), ...
                intervals{i}(k,2), Cut_ppm_axis);

            % Save ppm, intensities, number of componentes, eigenvalues 
            % and empty-cell for future spectra
            PpmIntensities(k,1) = {Cut_ppm_axis(lowInd:highInd)};
            PpmIntensities(k,2) = {Cut_1HNMR_Data(:,lowInd:highInd)};
        end
        % Store ppm-intensity cell array
        if i==1
            IntervalsRegion1 = PpmIntensities;
        elseif i==2
            IntervalsRegion2 = PpmIntensities;
        else
            IntervalsRegion3 = PpmIntensities;
        end
    end
end

assignin("base", "IntervalsRegion1", IntervalsRegion1);
assignin("base", "IntervalsRegion2", IntervalsRegion2);
assignin("base", "IntervalsRegion3", IntervalsRegion3);

fig = ancestor(src, 'figure', 'toplevel');

uialert(fig,"The Intervals were successfully exported to Workspace as "+...
    "cell arrays." +newline + newline +...
    "First column corresponds to PPM values." + newline +...
    "Second column corresponds to Intensity values.", ...
    "Info", "Icon","info");


end


function [firstInd, lastInd] = findIndex(firstPPM, lastPPM, ppmVector)

% Find first index
firstInd = find(ppmVector >= firstPPM & ...
    ppmVector < (firstPPM + 0.01), 1, 'first');
% Find last index
lastInd = find(ppmVector >= lastPPM & ...
    ppmVector < (lastPPM + 0.01), 1, 'first');

end

