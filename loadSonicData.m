function loadSonicData(n)
% loadSonicData(n)
% loads data from trial 'n'
% Assumes existance of environment variable "SONICDATA"
% which contains the Formatted and Intermediate data
% creates Data and DataF structs in main workspace

baseDir = getenv('SONICDATA');
load([baseDir '/Formatted/Sonic.' sprintf('%05d',n) '.mat']);
assignin('base','DataF', Data);
load([baseDir '/Intermediate/Sonic.' sprintf('%05d',n) '.mat']);
assignin('base','Data', Data);

end