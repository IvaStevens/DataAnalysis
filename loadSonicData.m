function [DataF, Data] = loadSonicData(n)
baseDir = getenv('SONICDATA');
load([baseDir '/Formatted/Sonic.' sprintf('%05d',n)]);
DataF = Data;
load([baseDir '/Intermediate/Sonic.' sprintf('%05d',n)]);
end