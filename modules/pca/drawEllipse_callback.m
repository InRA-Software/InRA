function drawEllipse_callback(~, event, axScores)

% Draw ellipse?
ellipseVis = findobj(axScores, "Type", "line");
if event.Value 
    ellipseVis.Visible = "on";
else
    ellipseVis.Visible = "off";
end

end

