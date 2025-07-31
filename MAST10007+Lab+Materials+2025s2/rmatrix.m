function M = rmatrix
axisM=[1/3;-2/3;2/3];
angleM=pi/4;
M = cos(angleM)*eye(3) + sin(angleM)*[0 -axisM(3) axisM(2); axisM(3) 0 -axisM(1); -axisM(2) axisM(1) 0] + (1-cos(angleM))*axisM*(axisM');

