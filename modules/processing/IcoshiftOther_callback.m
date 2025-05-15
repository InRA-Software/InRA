%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Icoshift Button Behaviour %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function IcoshiftOther_callback(src, ~, ddIcoshiftOption1, ...
    ddIcoshiftOption2, axPre)
% Recover data in axPre
data = axPre.UserData;
Cut_ppm_axis = data.CutPpm;
Cut_1HNMR_Data = data.CutData;

%%%%%%%%%%%%%%%%%%%%%%%
% Options of Icoshift %
%%%%%%%%%%%%%%%%%%%%%%%
% Default value for UserData
ddIcoshiftOption1.UserData = {'', 1, 'default'};
% Target Vector
switch ddIcoshiftOption1.Value
    case 'Average'
        xT = 'average';
    case 'Median'
        xT = 'median';
    case 'Max'
        xT = 'max';
    case 'Average 2'
        %xT = 'average2';
        % Window to choose multiplier
        powerWindow([], [], ddIcoshiftOption1)
        xT = ddIcoshiftOption1.UserData{1};
end

% Definition of alignment mode
switch ddIcoshiftOption2.Value
    case 'Whole'
        inter = 'whole';
    case 'Interval'
        intervalWindow([],[],axPre,ddIcoshiftOption2)
        inter = ddIcoshiftOption2.UserData;
end

% Loading Window for Aligning Spectra 
fig = ancestor(src, 'figure', 'toplevel');
loadingWindow = uiprogressdlg(fig,'Title','Loading',...
        'Message','Aligning Spectra . . .', 'Indeterminate','on');

multiplier = ddIcoshiftOption1.UserData{2};


Aligned_1HNMR_Data = icoshift(xT,Cut_1HNMR_Data,inter,'f', [0 1 1], [], ...
    multiplier);

% Get the dimensions of the matrix
[rows, cols] = size(Aligned_1HNMR_Data);

% Plot the data 
plot(axPre, Cut_ppm_axis, Aligned_1HNMR_Data);

% Add dimensions to the title
    dimText = text(axPre, 0.02, 0.95, ['Matrix Size: ' ...
            num2str(rows) ' x ' num2str(cols)],'Units', 'normalized', ...
            'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'k');

% Store data in axPre
axPre.UserData = struct("CutPpm", Cut_ppm_axis, ...
            "CutData", Aligned_1HNMR_Data);

% Close loading windows and delete corresponding object
close(loadingWindow)
delete(loadingWindow)

if strcmp(ddIcoshiftOption1.UserData{3}, 'closed')
    uialert(fig,"Since you closed Multiplier window, it was "...
        +"used Average Mode", "Info", "Icon","info");
end

end
