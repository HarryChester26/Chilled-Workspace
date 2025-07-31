function det3danim
    animationID = 0;
    A = [2 0 0; 1 3 0; 2 3 4];

    %create the figure
    ui.figure = figure('Position', [10 10 650 500]);
    ax = axes('units','pixels','position',[200 50 400 400], 'NextPlot', 'add');
    view([37.5 20]);
    ax.Interactions = rotateInteraction;
    ax.DataAspectRatioMode = 'manual';
    ax.DataAspectRatio = [1 1 1];
    
    ax.XTick = 0:6;
    ax.YTick = 0:6;
    ax.ZTick = 0:6;
    ax.XLim = [0 6];
    ax.YLim = [0 6];
    ax.ZLim = [0 6];
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.ZGrid = 'on';

    clear patchData;
    patchData.Vertices = zeros(8,3);
    patchData.Faces = [1 2 3 4;1 2 6 5;1 5 8 4; 5 6 7 8; 2 3 7 6; 3 4 8 7];
    patchData.FaceVertexCData = (1:6)';
    patchData.FaceAlpha = 0.9;
    patchData.FaceColor = 'flat';
    patchData.LineWidth = 2;
    faces = patch(patchData);

    
    %create our ui
    ui.matrixA11 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(1,1), 'position',[50 250 35 20]);
    ui.matrixA12 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(1,2), 'position',[90 250 35 20]);
    ui.matrixA13 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(1,3), 'position',[130 250 35 20]);
    ui.matrixA21 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(2,1), 'position',[50 225 35 20]);
    ui.matrixA22 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(2,2), 'position',[90 225 35 20]);
    ui.matrixA23 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(2,3), 'position',[130 225 35 20]);
    ui.matrixA31 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(3,1), 'position',[50 200 35 20]);
    ui.matrixA32 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(3,2), 'position',[90 200 35 20]);
    ui.matrixA33 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(3,3), 'position',[130 200 35 20]);
    ui.detAText = uicontrol('style','text', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', 'det = ', 'position',[50 150 125 25]);
    ui.volumeText = uicontrol('style','text', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', 'volume = ', 'position',[50 125 125 25]);
    ui.playButton = uicontrol('style','pushbutton','position',[50 100 100 20], 'string', 'play');

    %set up the button callback
    ui.playButton.Callback = @playButtonCallback;

    function playButtonCallback(~,~)
        animationID = animationID+1;
        localAnimationID = animationID;
        %update the matrix based on user input
        A = [str2double(ui.matrixA11.String) str2double(ui.matrixA12.String) str2double(ui.matrixA13.String);...
             str2double(ui.matrixA21.String) str2double(ui.matrixA22.String) str2double(ui.matrixA23.String);...
             str2double(ui.matrixA31.String) str2double(ui.matrixA32.String) str2double(ui.matrixA33.String)];
         
        ui.detAText.String = ['det = ' num2str(det(A), '%4.2f')];
        
        %update the axes to fit both the original square and the
        %transformed parallelepiped
        axisMin = min([0,A(1,1),A(2,1),A(3,1),A(1,1)+A(2,1),A(1,1)+A(3,1),A(2,1)+A(3,1),A(1,1)+A(2,1)+A(3,1),A(1,2),A(2,2),A(3,2),A(1,2)+A(2,2),A(1,2)+A(3,2),A(2,2)+A(3,2),A(1,2)+A(2,2)+A(3,2),0,A(1,3),A(2,3),A(3,3),A(1,3)+A(2,3),A(1,3)+A(3,3),A(2,3)+A(3,3),A(1,3)+A(2,3)+A(3,3)]);
        axisMax = max([1,A(1,1),A(2,1),A(3,1),A(1,1)+A(2,1),A(1,1)+A(3,1),A(2,1)+A(3,1),A(1,1)+A(2,1)+A(3,1),A(1,2),A(2,2),A(3,2),A(1,2)+A(2,2),A(1,2)+A(3,2),A(2,2)+A(3,2),A(1,2)+A(2,2)+A(3,2),0,A(1,3),A(2,3),A(3,3),A(1,3)+A(2,3),A(1,3)+A(3,3),A(2,3)+A(3,3),A(1,3)+A(2,3)+A(3,3)]);
        ax.XLim = [axisMin,axisMax];
        ax.YLim = [axisMin,axisMax];
        ax.ZLim = [axisMin,axisMax];
        ax.XTick = floor(axisMin):ceil(axisMax);
        ax.YTick = floor(axisMin):ceil(axisMax);
        ax.ZTick = floor(axisMin):ceil(axisMax);

        %set the camera viewing angle. in the case of a negative
        % det(A), we'd like a good angle that clearly shows the
        % point where the parallelepiped is inverted
        %if det(A) is positive then any camera angle will do
        if (det(A) < 0.01)
            for t = 0:0.001:1
                B = (1-t)*eye(3) + t*A;
                if (det(B) < 0)
                    view(B(1,:));
                    break
                end
            end
        end
        
        %play the animation
        for t = 0:0.004:1
            try
                B = (1-t)*eye(3) + t*A;
                
                %calculate the new vertices of the parallelepiped
                z = [0 0 0];
                a = B(1,:);
                b = B(2,:);
                c = B(3,:);
                faces.Vertices = [z; a; a+b; b; c; c+a; c+b+a; c+b];
                
                %set the edge colours as red or blue depending on whether
                % the parallelepiped has inverted yet
                if (det(B) < 0)
                    faces.EdgeColor = 'red';
                else
                    faces.EdgeColor = 'blue';
                end
                
                %update the volume text
                ui.volumeText.String = ['volume = ' num2str(abs(det(B)), '%4.2f')];
                

                pause(0.01)
            catch
                %if we got an error here, probably the window was closed
                % so we should just return
                return
            end
            %if another animation has started playing, we should cancel
            % this one
            if (animationID ~= localAnimationID) 
                return
            end
        end
    end
end