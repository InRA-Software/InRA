function listLoading_callback(src, event, axLoading, btnComparativePre)

% Recover data
loadings = src.UserData.loadings; 
loadingReg = src.UserData.loadingsRegion;
colorsReg = src.UserData.colorsRegion;
NumConcReg = src.UserData.concentrationsRegion;

%bar(axLoading, loadings(:,event.Value), ...
%    "DisplayName", "PC"+num2str(event.Value));

cla(axLoading)
axLoading.Title.String = "Loading Plot  -  PC"+num2str(event.Value);
hold(axLoading, "on")

if btnComparativePre.UserData.InUse == 3
% C-Features
    b = bar(axLoading, loadings(:,event.Value));
    b.FaceColor = 'flat';
    % Coloring regions
    b.CData(loadingReg{1},:) = repmat(colorsReg{1}, NumConcReg{1}, 1);
    b.CData(loadingReg{2},:) = repmat(colorsReg{2}, NumConcReg{2}, 1);
    b.CData(loadingReg{3},:) = repmat(colorsReg{3}, NumConcReg{3}, 1);
elseif btnComparativePre.UserData.InUse == 2
% Binned Spectra
    Ppm = btnComparativePre.UserData.BinnedPpm;
    plot(axLoading, Ppm(loadingReg{1}), ...
        loadings(loadingReg{1},event.Value), 'Color', colorsReg{1});
    plot(axLoading, Ppm(loadingReg{2}), ...
        loadings(loadingReg{2},event.Value), 'Color', colorsReg{2});
    plot(axLoading, Ppm(loadingReg{3}), ...
        loadings(loadingReg{3},event.Value), 'Color', colorsReg{3});
else
% Original Spectra
    Ppm = btnComparativePre.UserData.OriginalPpm;
    plot(axLoading, Ppm(loadingReg{1}), ...
        loadings(loadingReg{1},event.Value), 'Color', colorsReg{1});
    plot(axLoading, Ppm(loadingReg{2}), ...
        loadings(loadingReg{2},event.Value), 'Color', colorsReg{2});
    plot(axLoading, Ppm(loadingReg{3}), ...
        loadings(loadingReg{3},event.Value), 'Color', colorsReg{3});
end

hold(axLoading, "off")

end