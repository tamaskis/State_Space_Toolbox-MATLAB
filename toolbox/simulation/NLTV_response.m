%==========================================================================
%
% NLTV_response  Dynamic response of a nonlinear time-variant system.
%
%   [t,x,~,u] = NLTV_response(f,[],[],dim)
%   [t,x,y,u] = NLTV_response(f,h,[],dim)
%   [t,x,y,u] = NLTV_response(f,h,u,dim)
%   [__] = NLTV_response(__,opts)
%
% Author: Tamas Kis
% Last Update: 2021-12-05
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (function_handle) nonlinear dynamics equation f(x,u,t) 
%             (f:Rn×Rm×R->Rn)
%   h       - (OPTIONAL) (function_handle) nonlinear output equation 
%             h(x,u,t) (h:Rn×Rm×R->Rp)
%   u       - (OPTIONAL) (function_handle or m×1 double) control input 
%             u(x,t), where u:Rn×R->Rp (defaults to step input)
%   dim     - (struct) system dimensions
%       • n - (1×1 double) state dimension
%       • m - (1×1 double) control input dimension
%       • p - (1×1 double) output dimension
%   opts    - (OPTIONAL) (struct) solver options
%       • x0    - (n×1 double) initial condition (defaults to 0)
%       • tspan - (1×2 double) time interval to solve over (defaults to 
%                 [0,10])
%
% -------
% OUTPUT:
% -------
%   t       - ((N+1)×1 double) time vector
%   x       - ((N+1)×n double) matrix storing time history of state
%   y       - ((N+1)×p double) matrix storing time history of output
%   u       - ((N+1)×m double) matrix storing time history of control input
%
% -----
% NOTE:
% -----
%   --> N+1 = length of time vector
%   --> The ith row of "x" is the TRANSPOSE of the state vector at time ti
%       (i.e. the state corresponding to the ith time in "t").
%   --> The ith row of "y" is the TRANSPOSE of the output vector at time ti
%       (i.e. the output corresponding to the ith time in "t").
%   --> The ith row of "u" is the TRANSPOSE of the control vector at time
%       ti (i.e. the control corresponding to the ith time in "t").
%   --> Any quantities that cannot be determined are returned as "NaN".
%
%==========================================================================
function [t,x,y,u] = NLTV_response(f,h,u,dim,opts)

    % --------------------------------------------------
    % Determines if optional parameters have been input.
    % --------------------------------------------------
    
    h_input = (nargin >= 2) && ~isempty(h);
    u_input = (nargin >= 3) && ~isempty(u);
    opts_input = (nargin == 5) && ~isempty(opts);

    % -----------
    % Dimensions.
    % -----------

    % state (n), control input (m), and output (p) dimensions
    n = dim.n;
    if isfield(dim,'m'), m = dim.m; end
    if isfield(dim,'p'), p = dim.p; end
    
    % ----------------------------------------------------
    % Sets unspecified parameters to their default values.
    % ----------------------------------------------------

    % defaults control input to a unit step input
    if ~u_input
        u = ones(m,1);
    end

    % sets initial condition (defaults to 0)
    if opts_input && isfield(opts,'x0')
        x0 = opts.x0;
    else
        x0 = zeros(n,1);
    end
    
    % sets time span for solving ODE (defaults to [0,10])
    if opts_input && isfield(opts,'tspan')
        tspan = opts.tspan;
    else
        tspan = [0,10];
    end
    
    % -----------
    % Simulation.
    % -----------

    % assigns function handle to a constant control input
    if isnumeric(u)
        u = @(x,t) u;
    end
    
    % function to simulate
    f = @(t,x) f(x,u(x,t),t);

    % runs simulation (i.e. find state time history)
    [t,x] = ode45(f,tspan,x0);
    
    % length of time vector minus 1
    N = length(t)-1;
    
    % control input time history
    u_history = zeros(N+1,m);
    for i = 1:(N+1)
        u_history(i,:) = u(x(i,:)',t(i))';
    end
    u = u_history;
    
    % output vector time history (returns NaN if C isn't input)
    if h_input
        y = zeros(N+1,p);
        for i = 1:(N+1)
            y(i,:) = h(x(i,:)',u(i,:)',t(i))';
        end
    else
        y = NaN;
    end

    % ------------------
    % Legends for plots.
    % ------------------

    % determines whether to produce output plot
    plot_y = ~isnan(y);

    % legend for state
    x_legend_str = cell(1,n);
    for i = 1:n
        x_legend_str{i} = strcat('$x_{',num2str(i),'}$');
    end

    % legend for output
    if plot_y
        y_legend_str = cell(1,p);
        for i = 1:p
            y_legend_str{i} = strcat('$y_{',num2str(i),'}$');
        end
    end

    % legend for control input
    u_legend_str = cell(1,m);
    for i = 1:m
        u_legend_str{i} = strcat('$u_{',num2str(i),'}$');
    end

    % --------------------------------------------------
    % Plot of state time history if not plotting output.
    % --------------------------------------------------
    
    if ~plot_y
        figure('position',[540,300,700,500]);
        plot(t,x,'linewidth',1.5);
        grid on;
        xlabel('$t$','interpreter','latex','fontsize',18);
        ylabel('$x_{i}$','interpreter','latex','fontsize',18);
        title('\textbf{State Time History}','interpreter','latex',...
            'fontsize',18);
        legend(x_legend_str,'interpreter','latex','fontsize',14,...
            'location','best');
    end

    % ---------------------------------------------------
    % Plot of state time history and output time history.
    % ---------------------------------------------------

    if plot_y
        
        % initialize figure
        figure('position',[270,300,1200,500]);

        % state time history
        subplot(1,2,1);
        hold on;
        plot(t,x,'linewidth',1.5);
        plot(t,zeros(size(t)),'k--','linewidth',1.5);
        hold off;
        grid on;
        xlabel('$t$','interpreter','latex','fontsize',18);
        ylabel('$x_{i}$','interpreter','latex','fontsize',18);
        title('\textbf{State Time History}','interpreter','latex',...
            'fontsize',18);
        legend(x_legend_str,'interpreter','latex','fontsize',14,...
            'location','best');

        % output time history
        subplot(1,2,2);
        plot(t,y,'linewidth',1.5);
        grid on;
        xlabel('$t$','interpreter','latex','fontsize',18);
        ylabel('$y_{i}$','interpreter','latex','fontsize',18);
        title('\textbf{Output Time History}','interpreter','latex',...
            'fontsize',18);
        legend(y_legend_str,'interpreter','latex','fontsize',14,...
            'location','best');

    end

    % -----------------------------------
    % Plot of control input time history.
    % -----------------------------------

    figure('position',[540,300,700,500]);
    plot(t,u,'linewidth',1.5);
    grid on;
    xlabel('$t$','interpreter','latex','fontsize',18);
    ylabel('$u_{i}$','interpreter','latex','fontsize',18);
    title('\textbf{Control Input Time History}','interpreter','latex',...
        'fontsize',18);
    legend(u_legend_str,'interpreter','latex','fontsize',14,...
        'location','best');
    
end