global x1 x2 T_a;

T_a = 0.01;

min = 0;
max = 5;

t = min;

x1 = -5:0.1:5;
x2 = x1';

q = applyFormula(x1, x2, t);

f = figure;
ax = axes('Parent',f,'OuterPosition', [0 0.16  1 0.84]);
p = surf(x1, x2, q);

title(sprintf("Sampling rate @ %f s", T_a));

step = T_a / abs(max - min);

slider = uicontrol('Parent',f, 'Style','slider', ...
    'Units', 'normalized', 'Position',[0.1 0.1, 0.8, 0.06], ...
    'value', t, 'min', min, 'max', max, 'SliderStep', [step, step]);
label = uicontrol('Parent',f, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0 0.05, 1, 0.05],...
    'String', labelValue(t));

addlistener(slider, "ContinuousValueChange", ...
    @(es, ed) sliderUpdate(es.Value, p, label));

function [q] = applyFormula(x1, x2, t)
    q = 2 * sin(2 * pi * sqrt(x1.^2 + x2.^2) - 2 * pi * t);
end

function [str] = labelValue(t)
    str = sprintf("t = %fs", t);
end

function sliderUpdate(t, plot, label)
    global x1 x2 T_a;

    normalizedT = T_a * floor(t/T_a);

    set(plot, "ZData", applyFormula(x1, x2, normalizedT));
    set(label, "String", labelValue(normalizedT));
end
