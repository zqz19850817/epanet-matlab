function [errcode] = ENMatlabSetup(DLLname,Hname)
% Declaration:
% [errcode] =  ENMatlabSetup(DLLname,Hname)
% 
% Description:
% Opens the EPANET DLL library and sets global variables required by the 
% Matlab Epanet Toolkit
%
% EPANET Programmer's Toolkit Version:
% This version is consistent with the API defined for EPANET v2.00.12.
% If you are using another version of the EPANET programmer's toolkit DLL
% and header file, an error will be issued.
% 
% Arguments:
% DLLname   Name of the Epanet DLL file (w/o the *.dll extension)
% Hname     Name of the Epanet header file defining the exported symbols in
%           DLLname.dll (with the *.h extension).
% 
% Returns:
% Returns an error code (zero is normal termination).
%
% Globals:
% EN_CONSTANT is a global structure containing all integer codes defined
% for use of the Epanet programmer's toolkit (as defined in epanet2.h).  
% This structure can then be used for convenient access to these codes,
% by declaring 'global EN_CONSTANT' in the code module.
% 
% Notes:
% ENMatlabSetup must be called before any of the other toolkit functions.

global ENDLLNAME;
global EN_CONSTANT;

currentversion = 20012;
%errcode = 0;

% Load library
ENDLLNAME=DLLname;
ENHNAME=Hname;
if ~libisloaded(ENDLLNAME)
    loadlibrary(ENDLLNAME,ENHNAME);
end

% Check version of EPANET DLL
[errcode, version] = ENgetversion();
if version ~= currentversion
    errcode = 1;
    errstring = ['Current version ',num2str(version),' of EPANET is not supported. Update to version ',num2str(currentversion)];
    disp(errstring);
    return
end

EN_CONSTANT = struct(...
'EN_ELEVATION',    int32(0),...    % Node parameters
'EN_BASEDEMAND',   int32(1),...
'EN_PATTERN',      int32(2),...
'EN_EMITTER',      int32(3),...
'EN_INITQUAL',     int32(4),...
'EN_SOURCEQUAL',   int32(5),...
'EN_SOURCEPAT',    int32(6),...
'EN_SOURCETYPE',   int32(7),...
'EN_TANKLEVEL',    int32(8),...
'EN_DEMAND',       int32(9),...
'EN_HEAD',         int32(10),...
'EN_PRESSURE',     int32(11),...
'EN_QUALITY',      int32(12),...
'EN_SOURCEMASS',   int32(13),...
'EN_INITVOLUME',   int32(14),...
'EN_MIXMODEL',     int32(15),...
'EN_MIXZONEVOL',   int32(16),...
'EN_TANKDIAM',     int32(17),...
'EN_MINVOLUME',    int32(18),...
'EN_VOLCURVE',     int32(19),...
'EN_MINLEVEL',     int32(20),...
'EN_MAXLEVEL',     int32(21),...
'EN_MIXFRACTION',  int32(22),...
'EN_TANK_KBULK',   int32(23),...
'EN_DIAMETER',     int32(0),...    % Link parameters
'EN_LENGTH',       int32(1),...
'EN_ROUGHNESS',    int32(2),...
'EN_MINORLOSS',    int32(3),...
'EN_INITSTATUS',   int32(4),...
'EN_INITSETTING',  int32(5),...
'EN_KBULK',        int32(6),...
'EN_KWALL',        int32(7),...
'EN_FLOW',         int32(8),...
'EN_VELOCITY',     int32(9),...
'EN_HEADLOSS',     int32(10),...
'EN_STATUS',       int32(11),...
'EN_SETTING',      int32(12),...
'EN_ENERGY',       int32(13),...
'EN_DURATION',     int32(0),...    % Time parameters
'EN_HYDSTEP',      int32(1),...
'EN_QUALSTEP',     int32(2),...
'EN_PATTERNSTEP',  int32(3),...
'EN_PATTERNSTART', int32(4),...
'EN_REPORTSTEP',   int32(5),...
'EN_REPORTSTART',  int32(6),...
'EN_RULESTEP',     int32(7),...
'EN_STATISTIC',    int32(8),...
'EN_PERIODS',      int32(9),...
'EN_NODECOUNT',    int32(0),...    % Component counts
'EN_TANKCOUNT',    int32(1),...
'EN_LINKCOUNT',    int32(2),...
'EN_PATCOUNT',     int32(3),...
'EN_CURVECOUNT',   int32(4),...
'EN_CONTROLCOUNT', int32(5),...
'EN_JUNCTION',     int32(0),...    % Node types
'EN_RESERVOIR',    int32(1),...
'EN_TANK',         int32(2),...
'EN_CVPIPE',       int32(0),...    % Link types
'EN_PIPE',         int32(1),...
'EN_PUMP',         int32(2),...
'EN_PRV',          int32(3),...
'EN_PSV',          int32(4),...
'EN_PBV',          int32(5),...
'EN_FCV',          int32(6),...
'EN_TCV',          int32(7),...
'EN_GPV',          int32(8),...
'EN_NONE',         int32(0),...    % Quality analysis types
'EN_CHEM',         int32(1),...
'EN_AGE',          int32(2),...
'EN_TRACE',        int32(3),...
'EN_CONCEN',       int32(0),...    % Source quality types
'EN_MASS',         int32(1),...
'EN_SETPOINT',     int32(2),...
'EN_FLOWPACED',    int32(3),...
'EN_CFS',          int32(0),...    % Flow units types
'EN_GPM',          int32(1),...
'EN_MGD',          int32(2),...
'EN_IMGD',         int32(3),...
'EN_AFD',          int32(4),...
'EN_LPS',          int32(5),...
'EN_LPM',          int32(6),...
'EN_MLD',          int32(7),...
'EN_CMH',          int32(8),...
'EN_CMD',          int32(9),...
'EN_TRIALS',       int32(0),...   % Misc. options
'EN_ACCURACY',     int32(1),...
'EN_TOLERANCE',    int32(2),...
'EN_EMITEXPON',    int32(3),...
'EN_DEMANDMULT',   int32(4),...
'EN_LOWLEVEL',     int32(0),...   % Control types
'EN_HILEVEL',      int32(1),...
'EN_TIMER',        int32(2),...
'EN_TIMEOFDAY',    int32(3),...
'EN_AVERAGE',      int32(1),...   % Time statistic types.
'EN_MINIMUM',      int32(2),...
'EN_MAXIMUM',      int32(3),...
'EN_RANGE',        int32(4),...
'EN_MIX1',         int32(0),...   % Tank mixing models
'EN_MIX2',         int32(1),...
'EN_FIFO',         int32(2),...
'EN_LIFO',         int32(3),...
'EN_NOSAVE',       int32(0),...   % Save-results-to-file flag
'EN_SAVE',         int32(1),...
'EN_INITFLOW',     int32(10));    % Re-initialize flow flag
