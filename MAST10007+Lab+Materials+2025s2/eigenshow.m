function eigenshow(arg)
%eigenshow Graphical demonstration of eigenvalues and singular values.
%
%   This is the same MATLAB's eigshow utility, except that more information
%   is displayed on the screen.
%
%   eigenshow presents a graphical experiment showing the effect on the
%   the unit circle of the mapping induced by various 2-by-2 matrices
%
%   The mouse can be used to move the vector x around the
%   unit circle.  The resulting trajectory of Ax is plotted.  The object
%   is to find vectors x so that Ax is parallel to x.  Each such x is an
%   eigenvector of A.  The length of Ax is the corresponding eigenvalue.
%
%
%   The figure title is a menu of selected matrices, including some
%   with fewer than two real eigenvectors.  eigenshow(A) inserts A,
%   which must be 2-by-2, in the menu.
%
%   Here are some questions to consider:
%      Which matrices are singular?
%      Which matrices have complex eigenvalues?
%      Which matrices have double eigenvalues?
%      Which matrices have eigenvalues equal to singular values?
%      Which matrices have nondiagonal Jordan canonical forms?

%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 1.2 $  $Date: 1997/11/21 23:25:37 $

% Adapted for MATLAB R2014b and MAST10007 Linear Algebra by Anthony Morphett, June 2016
% Further modifications for MAST10007 by Anthony Morphett, November 2017, December 2018
% and by James Clift September 2024


set(gcf,'Color','w')

if nargin == 0
    initialize
elseif arg == 0
    action
else
    initialize(arg);
end
figure(gcf) %focus the current figure

%------------------

function initialize(arg)

    set(gcf,'Position',[200,200,620,540])
    
    if nargin == 0
        arg = 1;
    end
    
    if isequal(get(gcf,'tag'),'eigenshow')
        h = get(gcf,'userdata');
        mats = h.mats;
    else
        set(gcf,'numbertitle','off','menubar','none')
        mats = {
            '[5/4 0; 0 3/4]'
            %'[5/4 0; 0 -3/4]'
            '[0 1; 1 0]'
            '[0 1; -1 0]'
            %'[1 3; 4 2]/4'
            %'[1 3; 2 4]/4'
            %'[3 1; 4 2]/4'
            '[2 4; 2 4]/4'
            '[3 1; -2 1]/4'
            '[2 4; -1 -2]/4'
            '[6 4; -1 2]/4'
            '[1 0; 0 1]'
            'random 2x2 matrix'};
    end
    
    if all(size(arg)==1)
        if (arg < length(mats))
            mindex = arg;
            A = eval(mats{mindex});
        else
            A = randn(2,2);
            S = ['[' sprintf('%4.2f %4.2f; %4.2f %4.2f',A) ']'];
            mindex = length(mats);
            mats = [mats(1:mindex-1); {S}; mats(mindex)];
        end
    else
        A = arg;
        if isstring(A)
            S = A;
            A = eval(A);
        else
            S = ['[' sprintf('%4.2f %4.2f; %4.2f %4.2f',A') ']'];
        end
        if any(size(A) ~= 2)
            error('Matrix must be 2-by-2')
        end
        mats = [{S};  mats];
        mindex = 1;
    end
    
    clf
    
    % eig/svd toggle button and help button disabled by Anthony Morphett,
    % November 2017
    
    uicontrol('style','popup', ...
        'units','normalized', ...
        'position',[.23 .92 .54 .08], ...
        'string',mats, ...
        'tag','mats', ...
        'fontname','courier', ...
        'fontweight','bold', ...
        'fontsize',14, ...
        'value',mindex, ...
        'callback','eigenshow(get(gco,''value''))');
    s = 1.1*max(1,norm(A));
    axis([-s s -s s])
    axis square
    xcolor = [0 .4 0];
    Axcolor = [0 0 .8];
    h.A = A;
    h.mats = mats;
    %x=[1 0]';
    %ax=A*x;
    
    %set our initial values for x and Ax
    x = [4/5;3/5];
    Ax = A*x;
    h.x = initv(x,'x',xcolor); %edit by JC: change the default vector
    h.Ax = initv(Ax,'Ax',Axcolor);
    
    h.uitext = text(0.9, 0.9, getUiText(x,A,false), Units='Normalized', Interpreter='latex', FontSize=12 );
    
    xlabel('x is an eigenvector when Ax is parallel to x','fontweight','bold')
    set(gcf,'name','eigenshow', ...
        'tag','eigenshow', ...
        'resize','off',...
        'userdata',h, ...
        'windowbuttondownfcn', ...
        'eigenshow(0); set(gcf,''windowbuttonmotionfcn'',''eigenshow(0)'')', ...
        'windowbuttonupfcn', ...
        'set(gcf,''windowbuttonmotionfcn'','''')')
    % Modified by S. J. Leon 8-4-02

    


%------------------

function h = initv(v,t,color)
    h.mark = line(v(1),v(2),'marker','o','color',color);
    if not(verLessThan('matlab','8.4'))
        % Use animatedline in new versions of Matlab
        h.markTrace = animatedline('marker','.','color',color,'LineStyle','none');
        addpoints(h.markTrace,v(1),v(2));
    end
    h.line = line([0 v(1)],[0 v(2)],'color',color);
    h.text = text(1.1*v(1),1.1*v(2),t,'fontsize',12,'color',color,'HorizontalAlignment','center');

%------------------

function action
    h = get(gcf,'userdata');
    pt = get(gca,'currentpoint');
    x = pt(1,1:2)';
    x = x/norm(x);
    A = h.A;
    [x,snapped] = snapToNearestEigenvector(x,A);
    x=fixNegativeZero(x);
    movev(h.x,x);
    movev(h.Ax,A*x);
    set(h.uitext, 'String', getUiText(x,A,snapped));
%------------------

function movev(h,v)
    set(h.mark,'xdata',v(1),'ydata',v(2));
    set(h.line,'xdata',[0 v(1)],'ydata',[0 v(2)]);
    set(h.text,'pos',1.1*v);
    if not(verLessThan('matlab','8.4'))
        addpoints(h.markTrace, v(1), v(2));
    end


%------------------

function text = getUiText(x,A,showLambda)
    Ax = A*x;
    lambda = x'*Ax;
    if showLambda
        text=sprintf(['$\\;\\;\\,\\mathbf x = \\left[\\matrix{ %6.2f \\cr %6.2f } \\right]$\n\n' ...
        '$A\\mathbf x = \\left[\\matrix{ %6.2f \\cr %6.2f } \\right]$\n\n' ...
        '$\\;\\;\\;\\lambda = %6.2f $'], x(1), x(2), Ax(1), Ax(2), lambda);
    else
        text=sprintf(['$\\;\\;\\,\\mathbf x = \\left[\\matrix{ %6.2f \\cr %6.2f } \\right]$\n\n' ...
        '$A\\mathbf x = \\left[\\matrix{ %6.2f \\cr %6.2f } \\right]$\n\n' ...
        '$\\;$'], x(1), x(2), Ax(1), Ax(2));
    end

function [v,snapped]=snapToNearestEigenvector(x,A)
    %if we are within 1.5 degrees of an eigenvector, snap to it
    snapthreshold = cos(1.5*pi/180); 
    [P,D] = eig(A);
    snapped=true;
    %handle the case where we have geometric multiplicity 2
    %i.e. multiple of the 2x2 identity matrix
    if isreal(A(1,1)) && A(1,1)==A(2,2) && A(1,2)==0 && A(2,1)==0
        v=x;
        return
    end
    %check if we are nearly parallel to the first eigenvector in P
    if isreal(D(1,1))
        v=P(:,1);
        cosangle = dot(x,v);
        if cosangle > snapthreshold
            return
        elseif cosangle < -snapthreshold
            v=-v;
            return
        end
    end
    %check if we are nearly parallel to the second eigenvector in P
    if isreal(D(2,2))
        v=P(:,2);
        cosangle = dot(x,v);
        if cosangle > snapthreshold
            return
        elseif cosangle < -snapthreshold
            v=-v;
            return
        end
    end
    snapped=false;
    v=x;

function v=fixNegativeZero(x)
    %due to floating point rounding MATLAB will sometimes display a
    %coordinate as -0.00. this function corrects that behaviour
    v=x;
    if abs(v(1))<0.0051
        v(1) = 0.0;
    end
    if abs(v(2))<0.0051
        v(2) = 0.0;
    end

