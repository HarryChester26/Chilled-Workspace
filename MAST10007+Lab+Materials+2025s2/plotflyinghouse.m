function plotflyinghouse
    clf;
    ax = axes('units','pixels');
    
    C=[1 -3 4;3 -3 4;1 -1 4;3 -1 4;1 -3 6;3 -3 6;1 -1 6;3 -1 6]';

    b1 = [1; -1; 0];
    b2 = [1; 1; 1];
    b3 = [-4; -6; 5];
    Psb = [b1 b2 b3];
    Pbs = inv(Psb);
    Tb = diag([1 1 0]);
    Ts = Psb*Tb*Pbs;

    house.Vertices = C';
    house.Faces = [1 2 4 3 1; 5 6 8 7 5; 1 2 6 5 1; 1 3 7 5 1; 2 4 8 6 2; 3 4 8 7 3];
    house.FaceVertexCData = [0.0 0.0 1.0];
    house.FaceAlpha = 0.2;
    house.EdgeAlpha = 0.8;
    house.FaceColor = 'flat';
    house.EdgeColor = 'flat';
    house.LineWidth = 1.5;
    patch(house);

    mountain.Vertices = [7 -7 0; 7 3 0; -3 3 0; 7 3 5];
    mountain.Faces = [1 2 3 1; 1 2 4 1; 1 3 4 1; 2 3 4 2];
    mountain.FaceVertexCData = [0.5 0.5 0.5];
    mountain.FaceAlpha = 0.9;
    mountain.FaceColor = 'flat';
    patch(mountain); 

    shadow.Vertices = (Ts*C+0.001*b3)'; %small offset to prevent z-fighting
    shadow.Faces = [1 2 4 3 1; 5 6 8 7 5; 1 2 6 5 1; 1 3 7 5 1; 2 4 8 6 2; 3 4 8 7 3];
    shadow.FaceVertexCData = [0.1 0.1 0.1];
    shadow.FaceAlpha = 0.8;
    shadow.FaceColor = 'flat';
    shadow.EdgeAlpha = 0.8;
    patch(shadow);

    %draw the light direction as a 3d arrow
    hold on;
    lightpos = [-1 -6 8.5];
    lightdir = -0.3*b3';
    lightcolour = [1 0.85 0];
    %draw the line of the arrow
    line = [lightpos; lightpos+0.8*lightdir];
    plot3(line(:,1), line(:,2), line(:,3), 'Color',lightcolour, 'LineWidth', 3)
    %draw the tip of the arrow as a cone
    p1 = cross(lightdir, [1 0 0]); %find two perpendicular vectors
    p2 = cross(lightdir, p1);
    p1 = p1/norm(p1);
    p2 = p2/norm(p2);
    angles = [cos(0:2*pi/8:2*pi); sin(0:2*pi/8:2*pi)];
    tip.Vertices = [lightpos+lightdir; lightpos+0.8*lightdir+0.2*angles'*[p1; p2]];
    tip.Faces = [1 2 3 1; 1 3 4 1; 1 4 5 1; 1 5 6 1; 1 6 7 1; 1 7 8 1; 1 8 9 1; 1 9 10 1];
    tip.FaceVertexCData = lightcolour;
    tip.EdgeColor = 'none';
    tip.FaceColor = 'flat';
    patch(tip); 

    view([12.5 10]);
    ax.Interactions = rotateInteraction;
    ax.DataAspectRatioMode = 'manual';
    axis([-3 7 -7 3 0 10]);
    ax.DataAspectRatioMode = 'manual';
    ax.DataAspectRatio = [1 1 1];
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.ZGrid = 'on';
    ax.XLabel.String = 'x';
    ax.YLabel.String = 'y';
    ax.ZLabel.String = 'z';
end