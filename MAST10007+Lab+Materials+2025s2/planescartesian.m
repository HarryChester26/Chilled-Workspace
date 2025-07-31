function planescartesian
    plane1Cartesian = [2 0 -1 1];
    plane2Cartesian = [2 3 2 3];
    plane3Cartesian = [1 -2 3 4];

    plane1 = convertCartesianToVector(plane1Cartesian);
    plane2 = convertCartesianToVector(plane2Cartesian);
    plane3 = convertCartesianToVector(plane3Cartesian);

    plane1Visible = 1;
    plane2Visible = 0;
    plane3Visible = 0;

    colour1 = [0 0.45 0.7]; %blue
    colour2 = [0.9 0.4 0]; %red
    colour3 = [0.95 0.9 0.2]; %yellow
    
    %create the figure
    ui.figure = figure( ...
        'Position', [100 100 650 550], ...
        'Name', 'planescartesian', ...
        'Resize','off', ...
        'NumberTitle', 'off', ...
        'DockControls','off', ...
        'MenuBar', 'none' ...
    );
    ui.ax = axes( ...
        'units','pixels', ...
        'position',[200 145 400 400], ...
        'NextPlot', 'add', ...
        'Interactions',rotateInteraction, ...
        'View', [-22.5 20], ...
        'DataAspectRatioMode', 'manual', ...
        'DataAspectRatio', [1 1 1], ...
        'XGrid', 'on', ...
        'YGrid', 'on', ...
        'ZGrid', 'on' ...
    );
    ui.ax.XLabel.String = 'x';
    ui.ax.YLabel.String = 'y';
    ui.ax.ZLabel.String = 'z';
    %re-enable default interactivity, to allow the figure to be rotated
    enableDefaultInteractivity(ui.ax);
    
    setView([0 0 0], 3);
    
    %create the plane objects
    clear patchData;
    patchData.Vertices = zeros(12,3);
    patchData.Faces = [1 2 3 4 1; 5 6 7 8 5; 9 10 11 12 9];
    patchData.FaceVertexCData = [colour1;colour1;colour1;colour1;colour2;colour2;colour2;colour2;colour3;colour3;colour3;colour3];
    patchData.FaceAlpha = 0.9;
    patchData.FaceColor = 'flat';
    patchData.EdgeColor = 'flat';
    patchData.LineWidth = 4;
    faces = patch(patchData);

    %create our ui
    [ui.plane1Panel, ui.plane1Boxes] = createCartesianEqnUi([60 65], plane1Cartesian, colour1);
    [ui.plane2Panel, ui.plane2Boxes] = createCartesianEqnUi([60 40], plane2Cartesian, colour2);
    [ui.plane3Panel, ui.plane3Boxes] = createCartesianEqnUi([60 15], plane3Cartesian, colour3);
    ui.plane2Panel.Visible = 0;
    ui.plane3Panel.Visible = 0;
    ui.updateButton = uicontrol('style','pushbutton','position',[50 200 100 20], 'string', 'Update');
    ui.togglePlane1Button = uicontrol('style','checkbox','position',[25 65 20 20], 'value', 1);
    ui.togglePlane2Button = uicontrol('style','checkbox','position',[25 40 20 20], 'value', 0);
    ui.togglePlane3Button = uicontrol('style','checkbox','position',[25 15 20 20], 'value', 0);

    %set up the button callbacks
    ui.updateButton.Callback = @updateButtonCallback;
    ui.togglePlane1Button.Callback = @togglePlaneButtonCallback;
    ui.togglePlane2Button.Callback = @togglePlaneButtonCallback;
    ui.togglePlane3Button.Callback = @togglePlaneButtonCallback;


    %call the update button once to initially draw the planes to the screen
    updateButtonCallback();


    function updateButtonCallback(~,~)
        %update the planes based on user input
        %this requires converting the cartesian equations into vector
        %equations
        for i = 1:4
            plane1Cartesian(i) = str2double(ui.plane1Boxes(i).String);
            plane2Cartesian(i) = str2double(ui.plane2Boxes(i).String);
            plane3Cartesian(i) = str2double(ui.plane3Boxes(i).String);
        end
        plane1 = convertCartesianToVector(plane1Cartesian);
        plane2 = convertCartesianToVector(plane2Cartesian);
        plane3 = convertCartesianToVector(plane3Cartesian);
        
        %center the view between the three planes
        getBestView();
       
        %update the vertices of the planes
        %this also checks whether the planes are visible, and
        % enables/disables them accordingly
        faces.Vertices = [getPlaneVertices(plane1, plane1Visible);...
                          getPlaneVertices(plane2, plane2Visible);...
                          getPlaneVertices(plane3, plane3Visible)];
    end

    function togglePlaneButtonCallback(~,~)
        plane1Visible = ui.togglePlane1Button.Value;
        plane2Visible = ui.togglePlane2Button.Value;
        plane3Visible = ui.togglePlane3Button.Value;
        ui.plane1Panel.Visible = ui.togglePlane1Button.Value;
        ui.plane2Panel.Visible = ui.togglePlane2Button.Value;
        ui.plane3Panel.Visible = ui.togglePlane3Button.Value;

        updateButtonCallback();
    end

    function v = convertCartesianToVector(c)
        %input: 1x4 matrix c containing the coefficients of the cartesian equation 
        %output: 3x3 matrix v containing the coefficients of the vector equation
        if c(1) ~= 0
            v = [c(4)/c(1) 0 0; -c(2)/c(1) 1 0; -c(3)/c(1) 0 1];
        elseif c(2) ~= 0
            v = [0 c(4)/c(2) 0; 1 -c(1)/c(2) 0; 0 -c(3)/c(2) 1];
        elseif c(3) ~= 0
            v = [0 0 c(4)/c(3); 1 0 -c(1)/c(3); 0 1 -c(2)/c(3)];
        else 
            v = NaN*ones(3);
        end
    end

    function setView(point, scale) 
        %updates the axes to centre the camera view on the given point,
        % and sets the scale appropriately
        ui.ax.XLim = [point(1,1)-scale point(1,1)+scale];
        ui.ax.YLim = [point(1,2)-scale point(1,2)+scale];
        ui.ax.ZLim = [point(1,3)-scale point(1,3)+scale];
        ui.ax.XTick = floor(point(1,1)-scale):ceil(scale/3):ceil(point(1,1)+scale);
        ui.ax.YTick = floor(point(1,2)-scale):ceil(scale/3):ceil(point(1,2)+scale);
        ui.ax.ZTick = floor(point(1,3)-scale):ceil(scale/3):ceil(point(1,3)+scale);
    
    end

    function [panel, fields] = createCartesianEqnUi(position, initData, color)
        panel = uipanel(ui.figure,'units', 'pixels', 'Position',[position, 900 25], 'BorderType', 'none');
        uipanel(panel,'units', 'pixels', 'Position',[0 0 20 20], 'BackgroundColor', color, 'BorderType', 'none');
        uicontrol(panel,'style','text', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', "x + ", 'position',[62 0 100 20]);
        uicontrol(panel,'style','text', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', "y + ", 'position',[122 0 100 20]);
        uicontrol(panel,'style','text', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', "z = ", 'position',[182 0 100 20]);
        
        fields = gobjects(1,4);
        fields(1) = uicontrol(panel,'style','edit', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', initData(1), 'position',[30 1 27 20]);
        fields(2) = uicontrol(panel,'style','edit', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', initData(2), 'position',[90 1 27 20]);
        fields(3) = uicontrol(panel,'style','edit', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', initData(3), 'position',[150 1 27 20]);
        fields(4) = uicontrol(panel,'style','edit', 'FontSize', 10, 'HorizontalAlignment', 'left', 'string', initData(4), 'position',[210 1 27 20]);
    end

    function sol = findIntBetween2Planes(pa, pb)
        [psol, ~] = linsolve([pa(2,:)', pa(3,:)', -pb(2,:)', -pb(3,:)'], pb(1,:)'-pa(1,:)');
        %check if we actually had a solution
        if norm(pa(1,:) + psol(1,1)*pa(2,:) + psol(2,1)*pa(3,:) - pb(1,:) - psol(3,1)*pb(2,:) - psol(4,1)*pb(3,:))<0.0001
            sol = pa(1,:) + psol(1,1)*pa(2,:) + psol(2,1)*pa(3,:);
        else
            sol = [];
        end
    end


    function sol = findIntBetween3Planes(pa, pb, pc)
        M = [pa(2,:)', pa(3,:)', -pb(2,:)', -pb(3,:)', zeros(3,2);...
             -pa(2,:)', -pa(3,:)', zeros(3,2), pc(2,:)', pc(3,:)';...
             zeros(3,2), pb(2,:)', pb(3,:)', -pc(2,:)', -pc(3,:)'];
        b = [pb(1,:)'-pa(1,:)';pa(1,:)'-pc(1,:)'; pc(1,:)'-pb(1,:)'];
        [psol, ~] = linsolve(M, b);        
        %check if we actually had a solution
        if norm(pa(1,:) + psol(1,1)*pa(2,:) + psol(2,1)*pa(3,:) - pb(1,:) - psol(3,1)*pb(2,:) - psol(4,1)*pb(3,:))<0.0001 && norm(pa(1,:) + psol(1,1)*pa(2,:) + psol(2,1)*pa(3,:) - pc(1,:) - psol(5,1)*pc(2,:) - psol(6,1)*pc(3,:))<0.0001
            sol = pa(1,:) + psol(1,1)*pa(2,:) + psol(2,1)*pa(3,:);
        else
            sol = [];
        end
    end

    function getBestView()
        %determine the intersection between the three planes
        sol = findIntBetween3Planes(plane1, plane2, plane3);
        
        %if we have a solution, center the camera on it
        if ~isempty(sol)
            center = sol;
            scale = 3+1.5*max(abs(center));
        else
            %otherwise, we have no solution. we need to find somewhere to
            %put the camera that shows all points of interest.
            hasInt = [0 0 0];
            points = NaN*ones(6,3);
            
            %find any points where a pair of planes is intersecting
            sol = findIntBetween2Planes(plane1,plane2);
            if ~isempty(sol)
                points(1, :) = sol;
                hasInt = hasInt + [1 1 0];
            end
            
            sol = findIntBetween2Planes(plane2,plane3);
            if ~isempty(sol)
                points(2, :) = sol;
                hasInt = hasInt + [0 1 1];
            end
            
            sol = findIntBetween2Planes(plane3,plane1);
            if ~isempty(sol)
                points(3, :) = sol;
                hasInt = hasInt + [1 0 1];
            end
            
            %check which planes had no intersections; we need to make sure
            % that such planes still appear on screen
            if hasInt(1,1) == 0
                points(4, :) = plane1(1,:);
            end
            if hasInt(1,2) == 0
                points(5, :) = plane2(1,:);
            end
            if hasInt(1,3) == 0
                points(6, :) = plane3(1,:);
            end
            
            %set the view such that all of the points found above will 
            % appear on the screen
            minpoint=min(points);
            maxpoint=max(points);
            center = (minpoint+maxpoint)/2;
            scale = 1+1.5*max(abs(maxpoint-minpoint));
            
        end
        
        %update the view
        setView(center, scale);
        
    end

    function verts = getPlaneVertices(plane, visible)
        if visible
            %we scale up the plane by a large amount to ensure it will
            %extend all the way to the bounds of the axes, to prevent cut-off
            scale = 100000;
            verts = [plane(1,:)-scale*plane(2,:)-scale*plane(3,:);...
				     plane(1,:)-scale*plane(2,:)+scale*plane(3,:);...
				     plane(1,:)+scale*plane(2,:)+scale*plane(3,:);...
				     plane(1,:)+scale*plane(2,:)-scale*plane(3,:)];
            %handle the trivial case where the plane is just a point
            if norm(plane(2,:)) < 0.001 && norm(plane(3,:)) < 0.001
                verts = [plane(1,:) + [-0.1 -0.1 0];...
                         plane(1,:) + [0.1 -0.1 0];...
                         plane(1,:) + [0.1 0.1 0];...
                         plane(1,:) + [-0.1 0.1 0]];
            end
        else 
            verts = zeros(4,3);
        end
    end
end