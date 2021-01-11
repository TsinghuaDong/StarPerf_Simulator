function [position, position_cbf]=Create_location(dT)
global No_leo  No_fac tStart tStop No_snap Lat Long;
load('Num_leo.mat');
load('Num_fac.mat');
index=1;
position = cell(No_leo + No_fac,1);
position_cbf = cell(No_leo + No_fac,1);
for i=1:No_leo % 每颗卫星
    leo_info=strcat('*/Satellite/Sat',num2str(num_leo(i)));
    [secData, secName] = stkReport(leo_info,'LLA Position',tStart, tStop, dT);

    % stkReport  Generate an object report
 
    % USAGE    [secData, secNames] = stkReport('objPath', 'rptStyle')
    %          [secData, secNames] = stkReport('objPath', 'rptStyle', tStart, tStop, dT)
   
    %    objPath  - String name of object obtained from stkObjNames.
    %    rptStyle  - String name of existing STK report style valid for the object.
    %    tStart  - Start time for report (override style default).
    %    tStop  - Stop time for report (override style default).
    %    dT  - Time step of data (override style default).
    %    secData  - Cell array of report data, one cell per report section.
    %    secNames  - Cell array of section names, one cell per report section.
   
    %    Each section of an STK report style is arranged into a fixed number
    %    of rows and columns (MxN).  Each cell array element of secData is a
    %    1xN structure with fields:
    %           name - the data element name, e.g. 'Time'
    %           data - Mx1 matrix of element values
   
    %    Use stkFindData to extract desired data elements from a report section.
   
    %    Reports generated from this interface are unitless.  This is a departure from
    %    STK reporting, where users may control the units of various dimensions.  This
    %    function returns all data in default internal units as follows:
   
    %    Dimension         Unit
    %    ---------------   ---------
    %    Distance          Meter
    %    SmallDistance     Meter
    %    Time              Second
    %    Angle             Radians
    %    Mass              Kilogram
    %    Date              EpochSec
    %    Latitude          Radians
    %    Longitude         Radians
    %    Temperature       Kelvin
    %    Power             Watt
    %    Frequency         Hertz
    %    SmallTime         Second
    %    Ratio             Decibel
    %    Rcs               Decibel
    %    DopplerVelocity   M/S
    %    SARTimeResProd    Meter*Sec
    %    PowerDensity      Db/Hz
    %    PRF               Hertz
    %    Bandwidth         Hertz
    %    Duration          Sec
    %    Force             Newton


    lat = stkFindData(secData{1}, 'Lat');
    long = stkFindData(secData{1}, 'Lon');
    alt = stkFindData(secData{1}, 'Alt');
    llapos = zeros(3,No_snap);%%[lat long high]' % 全是0
    for j = 1:No_snap
        llapos(1,j) = llapos(1,j)+ lat(j)*180/pi;%%lat
        llapos(2,j) = llapos(2,j)+ long(j)*180/pi;%%long
        llapos(3,j) = llapos(3,j) + alt(j);
    end
    position{index} = llapos; % 一颗卫星在不同时刻的位置
    position_cbf{index} = Lla2Cbf(position{index,1}); % 自定义函数Central Body Fixed position 中心体坐标系 Central Body Coordinate Systems
    index=index+1;
    
end
for i=1:No_fac
    llapos = zeros(3,No_snap);
    llapos(1,:) = llapos(1,:)+Lat(i); % Fac的位置没变过
    llapos(2,:) = llapos(2,:)+Long(i);
    position{index} = llapos;
    position_cbf{index} = Lla2Cbf(position{index,1});
    index=index+1;
end
end