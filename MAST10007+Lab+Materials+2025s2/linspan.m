function linspan
    handles.u = [1 0 0];
    handles.v = [0 1 0];
    handles.w = [0 0 1];
    handles.m = 1.5;
    animationID = 0;
    
    %create the figure and axes
    ui.figure = figure( ...
        'Position', [100 100 900 500], ...
        'Name', 'linspan', ...
        'Resize','off', ...
        'NumberTitle', 'off', ...
        'DockControls','off', ...
        'MenuBar', 'none', ...
        'DeleteFcn', @guiCloseCallback ...
    );
    ui.ax = axes( ...
        'units','pixels', ...
        'position',[100 50 400 400], ...
        'NextPlot', 'add', ...
        'Interactions',rotateInteraction, ...
        'View', [-45 30], ...
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
    
    handles.wvisual = quiver3(0,0,0,0,0,0,'color',[1 0.6 0],'linewidth',3);
    
    %create our UI
    ui.titletext = uicontrol('style','text', 'FontSize', 14, 'HorizontalAlignment', 'left', 'string', "Linear Combinations and Spans", 'position',[10 470 500 30], 'FontWeight', 'bold');
    ui.utext = uicontrol('style','text', 'FontSize', 15, 'HorizontalAlignment', 'right', 'string', "u = ", 'position',[600 400 50 30], 'ForegroundColor', [1 0 0], 'FontWeight','bold');
    ui.vtext = uicontrol('style','text', 'FontSize', 15, 'HorizontalAlignment', 'right', 'string', "v = ", 'position',[600 350 50 30], 'ForegroundColor', [0 0 1], 'FontWeight','bold');
    ui.wtext = uicontrol('style','text', 'FontSize', 15, 'HorizontalAlignment', 'right', 'string', "w = ", 'position',[600 150 50 30], 'ForegroundColor', [1 0.6 0], 'FontWeight','bold');
    ui.ux = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.u(1), 'position',[650 400 50 30]);
    ui.uy = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.u(2), 'position',[710 400 50 30]);
    ui.uz = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.u(3), 'position',[770 400 50 30]);
    ui.vx = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.v(1), 'position',[650 350 50 30]);
    ui.vy = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.v(2), 'position',[710 350 50 30]);
    ui.vz = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.v(3), 'position',[770 350 50 30]);
    ui.wx = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.w(1), 'position',[650 150 50 30]);
    ui.wy = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.w(2), 'position',[710 150 50 30]);
    ui.wz = uicontrol('style','edit', 'FontSize', 10, 'HorizontalAlignment', 'center', 'string', handles.w(3), 'position',[770 150 50 30]);
    ui.plotuv = uicontrol('style','pushbutton', 'string', 'Plot u and v', 'position',[650 300 170 30]);
    ui.plotlincombos = uicontrol('style','pushbutton', 'string', 'Plot linear combinations', 'position',[650 250 170 30]);
    ui.plotspan = uicontrol('style','pushbutton', 'string', 'Plot span{u,v}', 'position',[650 200 170 30]);
    ui.plotw = uicontrol('style','pushbutton', 'string', 'Plot w', 'position',[650 100 170 30]);

    ui.plotuv.Callback = @plotuvCallback;
    ui.plotlincombos.Callback = @plotlincombosCallback;
    ui.plotspan.Callback = @plotspanCallback;
    ui.plotw.Callback = @plotwCallback;

    resetAxes(1.5);

    function [u,v,w,m] = updateHandlesFromUserInput()
        %updates values of u,v,w and m (bounds of axes) from the text input
        handles.u = [str2double(ui.ux.String) str2double(ui.uy.String) str2double(ui.uz.String)];
        handles.v = [str2double(ui.vx.String) str2double(ui.vy.String) str2double(ui.vz.String)];
        handles.w = [str2double(ui.wx.String) str2double(ui.wy.String) str2double(ui.wz.String)];
        handles.m = 1.5*max([abs(handles.u),abs(handles.v),1]);%modified to avoid error when u=v=0
        u = handles.u;
        v = handles.v;
        w = handles.w;
        m = handles.m;
    end

    function resetAxes(m)
        cla(ui.ax);
        hold(ui.ax, "on")
        quiver3(0,0,0,m,0,0,'color',[0.65 0.65 0.65]);
        quiver3(0,0,0,0,m,0,'color',[0.65 0.65 0.65]);
        quiver3(0,0,0,0,0,m,'color',[0.65 0.65 0.65]);
        axis([-m m -m m -m m]);
    end

    function plotuvCallback(~,~)
        [u,v,~,m] = updateHandlesFromUserInput();
        resetAxes(m);
        quiver3(0,0,0,u(1),u(2),u(3),'r','linewidth',3);
        quiver3(0,0,0,v(1),v(2),v(3),'b','linewidth',3);
    end

    function plotwCallback(~,~)
        [~,~,w,~] = updateHandlesFromUserInput(); 
        
        delete(handles.wvisual); %overwrite the existing vector
        handles.wvisual = quiver3(0,0,0,w(1),w(2),w(3),'color',[1 0.6 0],'linewidth',3);
        
    end

    function plotlincombosCallback(~,~)
        animationID = animationID+1;
        localAnimationID = animationID;

        [u,v,~,m] = updateHandlesFromUserInput();
        
        [bu,bv]=genOrthonormalSet(u,v);
        bu = 1.99*m*bu;
        bv = 1.99*m*bv;
        
        A=zeros(3,20);
        
        for i=1:25
            try
                A(:,i)=(rand-0.5)*bu + (rand-0.5)*bv;
                quiver3(0,0,0,A(1,i),A(2,i),A(3,i),0,'k')
                pause(0.03)
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
        %z=zeros(1,20);
        %quiver3(z,z,z,A(1,:),A(2,:),A(3,:),0,'k')
    end

    function plotspanCallback(~,~)
        [u,v,~,m] = updateHandlesFromUserInput();

        if isfield(handles,'plane')
            delete(handles.plane);
        end

        %generate orthonormal basis for the plane
        [bu, bv] = genOrthonormalSet(u,v);
        
        %check if bv is non-zero; if it is zero, we only have a line/point
        if any(bv)
            %if bv is not the zero vector, we have a plane
            S = [-1 1; -1 1];
            T = S';
            
            X=2*m*bu(1)*S + 2*m*bv(1)*T;
            Y=2*m*bu(2)*S + 2*m*bv(2)*T;
            Z=2*m*bu(3)*S + 2*m*bv(3)*T;
           
            handles.plane = surf(X,Y,Z, 'FaceColor',[0.1, 1, 0.4], 'EdgeColor', 'none');
        elseif any(bu)
            %if bu is non-zero, we have a line
            linev = [-2*m*bu; 2*m*bu]';
	        handles.plane = line(linev(1,:), linev(2,:), linev(3,:), 'color', [0.1, 1, 0.4], 'LineWidth', 2);
        else
            %if both bu and bv are zero, we have a point
            handles.plane = plot(0,0,'.', 'color', [0.1, 1, 0.4], 'MarkerSize',15);
        end
    end

    % helper function used below; generates an orthonormal set from u and v
    % if u and v are lin dep, bv will be 0
    function [bu, bv] = genOrthonormalSet(u,v)
        nu = norm(u);
        if nu > 1.0e-4
            bu=u/nu;
        else
            bu = [0;0;0];
        end
        
        bv = v-dot(v,bu)*bu;
        nbv = norm(bv);
        if nbv > 1.0e-4
            bv = bv/nbv;
        else
            bv = [0;0;0];
        end
        
        %make sure that if we only have one non-zero vector, it is bu, not bv
        if ~any(bu)
            bu = bv;
            bv = [0;0;0];
        end
    end

    function guiCloseCallback(~,~)
        animationID = animationID+1; %cancel any active lin combo animations
    end
            
end