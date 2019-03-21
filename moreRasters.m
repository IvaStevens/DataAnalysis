% Load Data
load('C:/Users/Ivana/Box/Motorlab_data/Formatted/Sonic.00073.mat');
DataF = Data;
load('C:/Users/Ivana/Box/Motorlab_data/Intermediate/Sonic.00073.mat');

% Find where id == 3 (eg: when in forceRamp task state)
forceTaskState = Data.QL.Data.TASK_STATE_CONFIG.id == 3;

% Find where id+1 == 4 (eg: sucessful forceRamp to Move progression)
nextTaskState = [diff(Data.QL.Data.TASK_STATE_CONFIG.id), 0] == 1;
force2move = forceTaskState.*nextTaskState;

% Find the timestamps where the trial succeeded
nextTaskState = [nextTaskState(3:end), 0, 0];
force2end = force2move.*nextTaskState;

% Find the timestamps for these events
successTimes = Data.QL.Data.TASK_STATE_CONFIG.ts_time(force2end==1);

% Sort the timestamps by task requirements
targets =  Data.QL.Data.TASK_STATE_CONFIG.target(1:4,:);
reducedTargets = targets(:,force2end==1);

% For each neural unit...
% Find which units have activity on them
activeUnits = sum( Data.QL.Data.RAW_SPIKECOUNT.counts,2) ~= 0;
spikeLocations = activeUnits > 0;

% Find index for timestamp at same time as a successTime
spikeInd = getSpikeIndices(successTimes,...
    Data.QL.Headers.RAW_SPIKECOUNT.recv_time,...
    0.01);

spikes4plotting = splitSamples(Data.QL.Data.RAW_SPIKECOUNT.counts,...
    spikeInd,...
    20); % 200 ms before and after force release

% There are 4 trial types (one force and 4 directions)
% Find indices for each
output = separateTrialType(reducedTargets, spikes4plotting);



