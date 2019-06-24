function [] = plotForces(DataF)
xyzForces = DataF.Position.Force(1:3,:);
magForces = sum(xyzForces.*xyzForces).^(1/2);
plot(magForces);
title('Forces During Trials')
xlabel('Time (ms)')
ylabel('Force (N)')
end