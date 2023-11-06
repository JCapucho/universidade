function [] = plotAndAnalyse(plotTitle, x, y)
    figure;

    h = axes('Position',[0 0 1 1],'Visible','off');
    axes('OuterPosition',[.0 0.07 1 .93]);

    plot(x, y);
    title(plotTitle, "Interpreter", "latex");

    set(gcf,'CurrentAxes',h);
    x_mem = sprintf('x allocated memory = %d bytes', whos("x").bytes);
    text(.5, .07, x_mem, ...
        "HorizontalAlignment", "center", ...
        "VerticalAlignment","baseline");
    y_mem = sprintf('y allocated memory = %d bytes', whos("y").bytes);
    text(.5, .02, y_mem, ...
        "HorizontalAlignment", "center", ...
        "VerticalAlignment","baseline");
end