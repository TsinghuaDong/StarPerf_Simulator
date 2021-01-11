function [parameter] = Create_LEO(conid,path)
% Create LEOs in STK
% input:
%   conid: used to connect to STK
%   path: configuration file path of mega-constellations

    global No_leo cycle No_snap tStop constellation dT;
    parameter = readtable(path);
    parameter = parameter.Value;
    constellation = parameter{1,1}; % 名字
    Altitude = str2num(parameter{2,1}); % 高度,km
    cycle = str2num(parameter{3,1}); % 飞行周期，sec
    No_snap = floor(cycle/dT)+1; % 飞行周期除以time step为快照
    tStop = cycle;
    dtr = pi/180;
    inc = str2num(parameter{4,1})*dtr; % 弧度制倾斜角
    F = str2num(parameter{5,1}); % 相位
    leo_plane = str2num(parameter{6,1}); % 轨道数量
    no = str2num(parameter{7,1}); % 一个轨道上卫星数量
    if (str2num(parameter{4,1}) > 80) && (str2num(parameter{4,1}) < 100) % 度数在80-100里的raan计算方式不一样？
        raan=[0:180/leo_plane:180/leo_plane*(leo_plane-1)];
    else
        raan=[0:360/leo_plane:360/leo_plane*(leo_plane-1)];
    end
    meanAnomaly1 = [0:360/no:360/no*(no-1)];
    raan = raan.*dtr;
    No_leo = leo_plane*no;
    disp('LEO:');
    disp(No_leo);
    for i =1:leo_plane
        for j=1:no
            ra = raan(i);
            ma = (mod(meanAnomaly1(j) + 360*F/(leo_plane*no)*(i-1),360))*dtr;
            num = j+no*(i-1);%%index of satellite-ID
            sat_no = strcat('Sat',num2str(num));
            stkNewObj('*/','Satellite',sat_no); % 此处的sat_no是obj的名字
            sat_no = strcat('*/Satellite/',sat_no); % 此处的sat_no是下面的函数需要用的objPath
            stkSetPropClassical(sat_no,'J4Perturbation','J2000',0.0,tStop,dT,0,6371000 + Altitude * 10^3,0.0,inc,0.0,ra,ma); % 配置轨道参数

            % USAGE    stkSetPropClassical('objPath', 'propagator', 'coordSystem', ...
            % tStart, tStop, dt, orbitEpoch, semimajorAxis, eccentricity,...
            % inclination, argOfPerigee, RAAN, meanAnomaly, coordEpoch)

            % objPath - Valid path, may be obtained from stkObjNames.
            % propagator - 'TwoBody', 'J2Perturbation', 'J4Perturbation', 'HPOP' or 'PODS'
            %     This parameter is case sensitive!
            % coordSystem - string name of coordinate system, valid choices are:
            %     'Fixed', 'J2000', 'MeanOfDate', 'MeanOfEpoch', 
            %     'TrueOfDate', 'TrueOfEpoch', 'B1950',
            %     'TEMEOfDate', 'TEMEOfEpoch', 'AlignmentAtEpoch'.
            %     This parameter is case sensitive!
            % tStart, tStop - times in epoch seconds.
            % dt - time step in seconds.
            % orbitEpoch - reference time of orbit data, in scenario epoch seconds
            % coordEpoch - coordinate system epoch, required by all '...OfEpoch'
            %     coordinate systems.

            % For information on the following parameters, please consult the STK Users Manual:

            % semimajorAxis - units in meters
            % eccentricity - unitless
            % inclination - units in radians
            % argOfPerigee - units in radians
            % RAAN - units in radians
            % meanAnomaly - units in radians

            num_leo(num) = num;
        end
    end
    save('Num_leo.mat','num_leo','leo_plane');
    mkdir(strcat(constellation,'\\delay'))
end


