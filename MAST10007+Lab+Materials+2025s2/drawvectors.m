function drawvectors(vecs)
% given an n-by-3 matrix vecs, drawvectors will plot the vectors given by the
% rows of vecs.

clf;
[m,n]=size(vecs);
if n~=3
    error("error: input should be an n-by-3 matrix")
end
xvalues = [zeros(1,m); vecs(:,1)'];
yvalues = [zeros(1,m); vecs(:,2)'];
zvalues = [zeros(1,m); vecs(:,3)'];
bounds = ceil(max(abs(vecs), [], "all")*1.1);
%plot the axes
plot3([0 bounds 0 0 0 0], [0 0 0 bounds 0 0], [0 0 0 0 0 bounds], 'Color', [0.65,0.65,0.65]);
%plot the vectors
hold(gca, "on")
plot3(xvalues, yvalues, zvalues,'.r-');
hold(gca, "off")
%set the axes bounds
axis([-bounds,bounds,-bounds,bounds,-bounds,bounds])
axis('square')
%set the axes properties
ax=gca;
ax.Interactions=[zoomInteraction,rotateInteraction];
ax.DataAspectRatioMode = 'manual';
ax.DataAspectRatio = [1 1 1];
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';
ax.XLabel.String = 'x';
ax.YLabel.String = 'y';
ax.ZLabel.String = 'z';

figure(gcf) %focus the current figure