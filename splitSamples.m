function M = splitSamples(data, indices, sampleSize)
% splitSamples  Create matrix of samples.
%   M = splitSamples(data, ind, sampleSize)
%

indices = indices + sampleSize;
[mm,~] = size(data);

nn = nan(mm, sampleSize);
M = nan(length(indices),mm,sampleSize);

adjustedData = [nn, data, nn];

for i = 1:length(indices)
  ind = indices(i);
  if mod(sampleSize,2) == 1
    M(i,:,:) = adjustedData(:,(ind-floor(sampleSize/2)):ind+floor(sampleSize/2));
  else
    M(i,:,:) = adjustedData(:,(ind+1-floor(sampleSize/2)):ind+floor(sampleSize/2));
  end
end
