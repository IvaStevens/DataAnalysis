dbstop if error

% Load Data
if ~strcmp(computer, 'GLNXA64')
    load('C:/Users/Ivana/Box/Motorlab_data/Formatted/Sonic.00093.mat');
    DataF = Data;
    load('C:/Users/Ivana/Box/Motorlab_data/Intermediate/Sonic.00093.mat');
else
    load('/home/ivana/Desktop/Data/Formatted/Sonic.00093.mat');
    DataF = Data;
    load('/home/ivana/Desktop/Data/Intermediate/Sonic.00093.mat');    
end

return;

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


% blah blah blah
success  = DataF.OutcomeMasks.Success;
ts_shortened = Data.QL.Data.SAMPLE_GENERATED.source_timestamp(1:end-11);
successfulTrials = findIfSuccessful(successTimes, success, ts_shortened);


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

% Are the channels zero-indexed???
u4c32 = getSpikesByChannel(Data.QL.Data.SPIKE_SNIPPET, 32, 0);

% Don't use counts
% 200 ms before and after force release
spikes4plotting = splitSamples(u4c32, spikeInd, 20); 

% There are 4 trial types (one force and 4 directions)
% Find indices for each
output = separateTrialType(reducedTargets, spikes4plotting);
bx = output{4};
ex = bx(:,559,:);
plotSpikeRaster(squeeze(ex) > 1,'PlotType', 'vertline');
ylabel('Arbitrarty Trial Nos')
xlabel('Time (ms)');
title('This is a title');
set(gca,'XTick',[]);

% Don't use counts! Use spike snippet to get the time
% filter by unit/channel


% This is plotting all of the trials (992 of them)
% reduce to only successful trials
% insure correct separation of trial types... should only be 4...
% run with good data
% Present Data along target trajectory

% determine which of the spikes are which

