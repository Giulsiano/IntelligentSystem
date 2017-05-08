function [tests] = test_plot_feature
tests = functiontests(localfunctions);
end

function test_output_structure_bar (tc)
feature = {[1 2 3], [4 5 6], [7 8 9];
       [10 20 30], [40 50 60], [70 80 90]};
exp_size = [2 3];
global SENSOR_NUM;
SENSOR_NUM = 3;
act = plot_feature(feature);
verifySize(tc, act, exp_size);
verifyClass(tc, act{1}, 'matlab.ui.Figure');
clear SENSOR_NUM;
end

function test_output_structure_plot (tc)
feature = {[1 2 3 0; 1 2 3 1; 1 2 3 2], [4 5 6 0; 4 5 6 1; 4 5 6 2], [7 8 9 0;7 8 9 1;7 8 9 2;];
       [10 20 30 0; 10 20 30 1; 10 20 30 2;], [40 50 60 0;40 50 60 1;40 50 60 2;], [70 80 90 0;40 50 60 1;40 50 60 2]};
exp_size = [2 3];
global SENSOR_NUM;
SENSOR_NUM = 3;
act = plot_feature(feature);
verifySize(tc, act, exp_size);
verifyClass(tc, act{1}, 'matlab.ui.Figure');
clear SENSOR_NUM;
end

function test_output_results_bar (tc)
feature = {[1 2 3], [4 5 6], [7 8 9];
       [10 20 30], [40 50 60], [70 80 90]};
global SENSOR_NUM;
SENSOR_NUM = 3;
act = plot_feature(feature);
for i = 1:numel(act)
    figure(act{i});
    title('Test figure. Press OK if it is a bar graph');
    setappdata(gcf, 'TestOk', false);
    setappdata(gcf, 'TestFail', false);
    pushbOK = uicontrol(gcf, 'style', 'pushbutton', ...
       'callback', 'setappdata(gcf, ''TestOk'', true)', ...
       'position', [400 20 120 20]);
    pushbFAIL = uicontrol(gcf, 'style', 'pushbutton', ...
       'callback', 'setappdata(gcf, ''TestFail'', true)', ...
       'position', [20 20 50 20]);
    set(pushbOK, 'string', 'OK');
    set(pushbFAIL, 'string', 'FAIL');
    while (getappdata(gcf, 'TestOk' ) || getappdata(gcf, 'TestFail' )) == false
        drawnow limitrate;
    end
    verifyEqual(tc, getappdata(gcf, 'TestFail'), false);
    verifyEqual(tc, getappdata(gcf, 'TestOk'), true);
    close(gcf);
end
clear SENSOR_NUM;
end

function test_output_results_plot (tc)
feature = {[1 2 3; 4 5 6; 7 8 9; 0 1 2], [4 5 6; 4 5 6; 7 8 9; 0 1 2], [7 8 9; 4 5 6; 7 8 9; 0 1 2];
           [10 20 30; 4 5 6; 7 8 9; 0 1 2], [40 50 60; 4 5 6; 7 8 9; 0 1 2], [70 80 90; 4 5 6; 7 8 9; 0 1 2]};
global SENSOR_NUM;
SENSOR_NUM = 3;
act = plot_feature(feature);
for i = 1:numel(act)
    figure(act{i});
    title('Test figure. Press OK if it is a bar graph');
    setappdata(gcf, 'TestOk', false);
    setappdata(gcf, 'TestFail', false);
    pushbOK = uicontrol(gcf, 'style', 'pushbutton', ...
       'callback', 'setappdata(gcf, ''TestOk'', true)', ...
       'position', [400 45 120 20]);
    pushbFAIL = uicontrol(gcf, 'style', 'pushbutton', ...
       'callback', 'setappdata(gcf, ''TestFail'', true)', ...
       'position', [20 20 50 20]);
    set(pushbOK, 'string', 'OK');
    set(pushbFAIL, 'string', 'FAIL');
    while (getappdata(gcf, 'TestOk' ) || getappdata(gcf, 'TestFail' )) == false
        drawnow limitrate;
    end
    verifyEqual(tc, getappdata(gcf, 'TestFail'), false);
    verifyEqual(tc, getappdata(gcf, 'TestOk'), true);
    close(gcf);
end
clear SENSOR_NUM;
end