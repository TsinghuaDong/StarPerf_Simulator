clear all; close all; clc; % 清理内存变量函数；关闭图片；清理命令窗口
global cycle No_snap No_fac No_leo tStart tStop dT constellation % 定义全局变量
dT = 1.0; % time step，用在了动画和卫星建立。可能是delta time的意思
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
stkSetTimePeriod('1 Jan 2021 0:00:00.0','1 Jan 2021 10:00:00.0','GREGUTC');  % 设置场景的时间
stkSetEpoch('1 Jan 2021 0:00:00.0','GREGUTC');
cmd1 = ['SetValues "1 Jan 2021 0:00:00.0" ' mat2str(dT)];
cmd1 = [cmd1 ' 0.1'];
rtn = stkConnect(conid,'Animate','Scenario/Matlab_Basic',cmd1);
rtn = stkConnect(conid,'Animate','Scenario/Matlab_Basic','Reset');
disp('Set up the propagator and nodes for the satellites');
[parameter] = Create_LEO(conid,'../etc/parameter-test.xlsx');
% Create_Fac(conid);
% inc = str2num(parameter{4,1})*dtr;
% 
% disp('save position info');
% [position, position_cbf]=Create_location(dT);
% filename = [constellation '\position.mat'];
% save(filename,'position','position_cbf');
% disp('save delay info');
% for t = 1:cycle
%     [delay] = Create_delay(position_cbf,t,inc);
% end



% stkClose(conid)
% stkClose
