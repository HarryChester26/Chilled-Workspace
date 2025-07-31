function det2danim
    animationID = 0;
    A = [2 0; 1 3];

    %create the figure and axes
    ui.figure = figure('Position', [10 10 650 500]);
    ax = axes('units','pixels','position',[200 50 400 400], 'NextPlot', 'add');
    ax.Interactions = panInteraction;
    ax.XTick = 0:3;
    ax.YTick = 0:3;
    ax.XLim = [0 3];
    ax.YLim = [0 3];
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    p = plot(0,0, 'LineWidth', 2);
    

    %create our ui
    ui.matrixA11 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(1,1), 'position',[50 225 35 20]);
    ui.matrixA12 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(1,2), 'position',[90 225 35 20]);
    ui.matrixA21 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(2,1), 'position',[50 200 35 20]);
    ui.matrixA22 = uicontrol('style','edit', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', A(2,2), 'position',[90 200 35 20]);
    ui.detAText = uicontrol('style','text', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', 'det = ', 'position',[50 150 100 25]);
    ui.areaText = uicontrol('style','text', 'FontSize', 12, 'HorizontalAlignment', 'left', 'string', 'area = ', 'position',[50 125 100 25]);
    ui.playButton = uicontrol('style','pushbutton','position',[50 100 100 20], 'string', 'play');

    %set up the button callback
    ui.playButton.Callback = @playButtonCallback;

    function playButtonCallback(~,~)
        animationID = animationID+1;
        localAnimationID = animationID;
        
        %update the matrix based on user input
        A = [str2double(ui.matrixA11.String) str2double(ui.matrixA12.String); str2double(ui.matrixA21.String) str2double(ui.matrixA22.String)];
        ui.detAText.String = ['det = ' num2str(det(A), '%4.2f')];
        
        %update the axes to fit both the original square and the
        % transformed parallelogram
        axisMin = min([0,A(1,1),A(2,1),A(1,1)+A(2,1),A(1,2),A(2,2),A(1,2)+A(2,2)]);
        axisMax = max([1,A(1,1),A(2,1),A(1,1)+A(2,1),A(1,2),A(2,2),A(1,2)+A(2,2)]);
        ax.XLim = [axisMin,axisMax];
        ax.YLim = [axisMin,axisMax];
        ax.XTick = floor(axisMin):ceil(axisMax);
        ax.YTick = floor(axisMin):ceil(axisMax);
        
        %play the animation
        for t = 0:0.004:1
            try
                B = (1-t)*eye(2) + t*A;
                
                %set the edge colours as red or blue depending on whether
                % the parallelogram has inverted yet
                p.XData = [0, B(1,1), B(1,1) + B(2,1), B(2,1), 0];
                p.YData = [0, B(1,2), B(1,2) + B(2,2), B(2,2), 0];
                
                if (det(B) < 0)
                    p.Color = 'red';
                else
                    p.Color = 'blue';
                end
                
                %update the area text
                ui.areaText.String = ['area = ' num2str(abs(det(B)), '%4.2f')];
                
                pause(0.01)
            catch
                %if we got an error here, probably the window was closed
                % so we should just return
                return
            end
            %if another animation has started playing, we should cancel
            % this one
            if (animationID ~= localAnimationID) 
                break
            end
        end
    end
end