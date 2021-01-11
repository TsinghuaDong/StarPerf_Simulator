clear all; close all; clc; % 清理内存变量函数；关闭图片；清理命令窗口
global cycle No_snap No_fac No_leo tStart tStop dT constellation % 定义全局变量
dT = 1.0;
tStart = 0;
dtr = pi/180;
rtd = 180/pi;
remMachine = stkDefaultHost; % 返回缺省的host和port
delete(get(0,'children')); % Clear any open charts within MATLAB.
conid=stkOpen(remMachine); % Open the Connect to STK.

scen_open = stkValidScen; % 是否有打开的scenario
if scen_open == 1
    rtn = questdlg('Close the current scenario?'); % GUI对话框命令，可以选择yes，no等
    if ~strcmp(rtn,'Yes')
        stkClose(conid)
    else
        stkUnload('/*')
    end
end

disp('Create a new scenario'); % 打印这句话
stkNewObj('/','Scenario','Matlab_Basic'); % 建立一个新场景
disp('Set scenario time period');
stkSetTimePeriod('1 Dec 2019 0:00:00.0','1 Dec 2019 10:00:00.0','GREGUTC');  % 设置场景的时间
stkSetEpoch('1 Dec 2019 0:00:00.0','GREGUTC');

rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'CurrentTime');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'TimeStep');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'Mode');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'TimePeriod');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RefreshMode');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RefreshDelta');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RealTimeX');
disp(rtn)


cmd1 = 'SetValues "1 Dec 2019 0:00:00.0" 11.0';
cmd1 = [cmd1 ' 0.123'];
disp(cmd1)
rtn = stkConnect(conid,'Animate','Scenario/Matlab_Basic',cmd1);

rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'CurrentTime');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'TimeStep');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'Mode');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'TimePeriod');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RefreshMode');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RefreshDelta');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RealTimeX');
disp(rtn)

cmd1 = ['SetValues "1 Dec 2019 0:00:00.0" ' mat2str(dT)];
cmd1 = [cmd1 ' 0.1'];
rtn = stkConnect(conid,'Animate','Scenario/Matlab_Basic',cmd1);

rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'CurrentTime');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'TimeStep');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'Mode');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'TimePeriod');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RefreshMode');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RefreshDelta');
disp(rtn)
rtn = stkConnect(conid,'GetAnimationData', 'Scenario/Matlab_Basic', 'RealTimeX');
disp(rtn)

stkClose(conid)
stkClose

% OUTPUT:
% Create a new scenario
% Set scenario time period
% "6 Jan 2021 04:00:00.000"
% 10.0000
% Using Time Step
% "1 Dec 2019 00:00:00.000", "1 Dec 2019 10:00:00.000"
% Using Refresh Delta
% 0.0100
% 1.0000
% SetValues "1 Dec 2019 0:00:00.0" 11.0 0.123
% "1 Dec 2019 00:00:00.000"
% 11.0000
% Using Time Step
% "1 Dec 2019 00:00:00.000", "1 Dec 2019 10:00:00.000"
% Using Refresh Delta
% 0.1230
% 1.0000
% "1 Dec 2019 00:00:00.000"
% 1.0000
% Using Time Step
% "1 Dec 2019 00:00:00.000", "1 Dec 2019 10:00:00.000"
% Using Refresh Delta
% 0.1000
% 1.0000