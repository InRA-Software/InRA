function listScores_callback(src, event, axScores, cbxDrawEllipse)

% Recover data
scores = src.UserData.scores; 
selectedColors = src.UserData.selectedColors;
selectedSamples = src.UserData.selectedSamples;
drawVerticalLine = src.UserData.drawVerticalLine;

% Score Plot
cla(axScores)
hold(axScores,'on')
for i=1:size(selectedColors,1)  
    firstS = selectedSamples(i,1);
    lastS = selectedSamples(i,2);
    
    s = scatter(axScores,scores(firstS:lastS,1), ...
        scores(firstS:lastS,event.Value), "filled");
    s.MarkerEdgeColor = selectedColors(i,:);
    s.MarkerFaceColor = selectedColors(i,:);
end
axScores.YLabel.String = "PC"+num2str(event.Value);

% Axis at (0,0)
if drawVerticalLine
    xline(axScores, 0,'Color','black', 'Alpha', 0.4)
end
yline(axScores, 0,'Color','black', 'Alpha', 0.4)

% Draw the 95% error ellipse
[XX, YY] = ellipse(scores(:,1), scores(:,event.Value));
plot(axScores, XX, YY, '--', 'Color', [0, 0, 0, 0.4]);

% Draw ellipse?
ellipseVis = findobj(axScores, "Type", "line");
if cbxDrawEllipse.Value 
    ellipseVis.Visible = "on";
else
    ellipseVis.Visible = "off";
end

hold(axScores,'off')

end