%%%%%%%%%%%%%%%%%%%%
% Sync Plot Option %
%%%%%%%%%%%%%%%%%%%%
function cbxPlot_callback(src, ~, axRaw, axPre, btnApplyVis)

    if src.Value
        % Si el checkbox está activado, sincronizar ejes y guardar límites de axRaw
        linkaxes([axRaw, axPre], 'x');
    else
        % Si el checkbox está desactivado, desvincular axPre
        linkaxes([axRaw, axPre], 'off');
        % Restablecer los límites del eje axPre
        data = axPre.UserData;
        Cut_ppm_axis = data.CutPpm;
        Cut_1HNMR_Data = data.CutData;
        xlim(axPre, [min(Cut_ppm_axis), max(Cut_ppm_axis)]);
        ylim(axPre, [min(Cut_1HNMR_Data, [], "all"), ...
            max(Cut_1HNMR_Data, [], "all")]);
        % Recover data in btnApplyVis
        data = btnApplyVis.UserData;
        Raw_1HNMR_Data = data.RawData;
        xlim(axRaw, [-0.2 10]);
        ylim(axRaw, [min(Raw_1HNMR_Data, [], "all"), ...
            max(Raw_1HNMR_Data, [], "all")]);
    end
end