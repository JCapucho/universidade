for T_a = [0.01, 0.1]
    t5 = 0:T_a:5;
    
    x = 2 * sin(4 * pi * t5);
    plotTitle = "x = 2sin(4 \\pi t)";
    plotAndAnalyse(sprintf("$$%s \\ @ \\ T_a = %f s$$", plotTitle, T_a), t5, x);
    
    y = cos(10 * pi * t5);
    plotTitle = "y = cos(10 \\pi t)";
    plotAndAnalyse(sprintf("$$%s \\ @ \\ T_a = %f s$$", plotTitle, T_a), t5, y);
    
    z = x .* y;
    plotTitle = "z = x(t)y(t)";
    plotAndAnalyse(sprintf("$$%s \\ @ \\ T_a = %f s$$", plotTitle, T_a), t5, z);
    
    t10 = 0:T_a:10;
    w = 3 * sin(pi * t10) + 2 * sin(6 * pi * t10);
    plotTitle = "w = 3sin(\\pi t) + 2sin(6\\pi t)";
    plotAndAnalyse(sprintf("$$%s \\ @ \\ T_a = %f s$$", plotTitle, T_a), t10, w);
end

%%

for T_a = [0.01, 0.1]
    figure;

    h = axes('Position',[0 0 1 1],'Visible','off');
    axes('OuterPosition',[.0 0.12 1 .88]);

    t1 = 0:T_a:5;
    t2 = t1';
    
    q = 2 * sin(2 * pi * (2 * t1 + t2));
    
    surf(t1, t2, q);
    plotTitle = sprintf("$$w = 2sin(2 \\pi (2t_1 + t_2) \\ @ \\ T_a = %f s$$", T_a);
    title(plotTitle, "Interpreter", "latex");

    set(gcf,'CurrentAxes',h);
    t1_mem = sprintf('x allocated memory = %d bytes', whos("t1").bytes);
    text(.5, .12, t1_mem, ...
        "HorizontalAlignment", "center", ...
        "VerticalAlignment","baseline");
    t2_mem = sprintf('x allocated memory = %d bytes', whos("t2").bytes);
    text(.5, .07, t2_mem, ...
        "HorizontalAlignment", "center", ...
        "VerticalAlignment","baseline");
    q_mem = sprintf('q allocated memory = %d bytes', whos("q").bytes);
    text(.5, .02, q_mem, ...
        "HorizontalAlignment", "center", ...
        "VerticalAlignment","baseline");
end