%==========================================================================
%
% LTI_CCL_response  Dynamic response of a linear time-invariant system
% given the controller closed loop matrices.
%
%   [t,x] = LTI_CCL_response(Accl,Bccl,[],[],r)
%   [t,x,y] = LTI_CCL_response(Accl,Bccl,Cccl,Dccl,r)
%   [t,x,y,u] = LTI_CCL_response(Accl,Bccl,Cccl,Dccl,r,Kfb,Kff)
%   [__] = LTI_CL_response(__,opts)
%
% Author: Tamas Kis
% Last Update: 2021-12-05
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   Accl    - (n×n double) controller closed loop dynamics matrix
%   Bccl    - (n×m double) controller closed loop input matrix
%   Cccl    - (OPTIONAL) (p×n double) controller closed loop output matrix
%   Dccl    - (OPTIONAL) (p×m double) controller closed loop feedforward
%             matrix
%   r       - (OPTIONAL) (function_handle or p×1 double) reference input 
%             r(t), where r:R->Rp (defaults to step input)
%   Kfb     - (OPTIONAL) (m×n double) feedback gain matrix
%   Kff     - (OPTIONAL) (m×p double) feedforward gain matrix
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
%   --> The ith row of "u" is the TRANSPOSE of the control input at time
%       ti (i.e. the control corresponding to the ith time in "t").
%   --> If a "C" matrix is specified but a "D" is not, it is assumed that 
%       D = 0.
%   --> Any quantities that cannot be determined are returned as "NaN".
%
%==========================================================================
function [t,x,y,u] = LTI_CCL_response(Accl,Bccl,Cccl,Dccl,r,Kfb,Kff,opts)

    % --------------------------------------------------
    % Determines if optional parameters have been input.
    % --------------------------------------------------

    Cccl_input = (nargin >= 3) && ~isempty(Cccl);
    Dccl_input = (nargin >= 4) && ~isempty(Dccl);
    r_input = (nargin >= 5) && ~isempty(r);
    Kfb_input = (nargin >= 6) && ~isempty(Kfb);
    Kff_input = (nargin >= 7) && ~isempty(Kff);
    opts_input = (nargin == 8) && ~isempty(opts);

    % -----------
    % Dimensions.
    % -----------

    % state (n), control input (m), and output (p) dimensions
    n = size(Accl,1);
    m = size(Bccl,2);
    if Cccl_input, p = size(Cccl,1); end
    
    % ----------------------------------------------------
    % Sets unspecified parameters to their default values.
    % ----------------------------------------------------

    % defaults reference input to a unit step input
    if ~r_input
        r = ones(p,1);
    end

    % defaults Dccl to 0 if Cccl is input but Dccl is not
    if Cccl_input && ~Dccl_input
        Dccl = zeros(p,m);
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

    % assigns function handle to a constant reference input
    if isnumeric(r)
        r = @(t) r;
    end
    
    % function to simulate
    f = @(t,x) Accl*x+Bccl*r(t);

    % runs simulation (i.e. find state time history)
    [t,x] = ode45(f,tspan,x0);
    
    % length of time vector minus 1
    N = length(t)-1;
    
    % reference input time history
    r_history = zeros(N+1,p);
    for i = 1:(N+1)
        r_history(i,:) = r(t(i))';
    end
    r = r_history;

    % control input time history (returns NaN if Kfb is not input)
    if Kfb_input
        u = zeros(N+1,m);
        if Kff_input
            for i = 1:(N+1)
                u(i,:) = -Kfb*x(i,:)'+Kff*r(i,:)';
            end
        else
            for i = 1:(N+1)
                u(i,:) = -Kfb*x(i,:)';
            end
        end
    else
        u = NaN;
    end
    
    % output vector time history (returns NaN if Cccl isn't input)
    Dccl_exists = exist('Dccl','var');
    if Cccl_input
        y = zeros(N+1,p);
        if Dccl_exists
            for i = 1:(N+1)
                y(i,:) = (Cccl*x(i,:)'+Dccl*r(i,:)')';
            end
        else
            for i = 1:(N+1)
                y(i,:) = (Cccl*x(i,:)')';
            end
        end
    else
        y = NaN;
    end

    % ------------------
    % Legends for plots.
    % ------------------

    % determines which plots to produce
    plot_y = ~isnan(y);
    plot_u = ~isnan(u);

    % legend for state
    x_legend_str = cell(1,n);
    for i = 1:n
        x_legend_str{i} = strcat('$x_{',num2str(i),'}$');
    end

    % legend for output
    if plot_y
        y_legend_str = cell(1,p+1);
        for i = 1:p
            y_legend_str{i} = strcat('$y_{',num2str(i),'}$');
        end
        y_legend_str{p+1} = '$r(t)$';
    end

    % legend for control input
    if plot_u
        u_legend_str = cell(1,m);
        for i = 1:m
            u_legend_str{i} = strcat('$u_{',num2str(i),'}$');
        end
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
        plot(t,zeros(size(t)),'k--','linewidth',1.5,'handlevisibility',...
            'off');
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
        hold on;
        plot(t,y,'linewidth',1.5);
        plot(t,r,'k--','linewidth',1.5);
        hold off;
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

    if plot_u
        figure('position',[540,300,700,500]);
        plot(t,u,'linewidth',1.5);
        grid on;
        xlabel('$t$','interpreter','latex','fontsize',18);
        ylabel('$u_{i}$','interpreter','latex','fontsize',18);
        title('\textbf{Control Input Time History}','interpreter',...
            'latex','fontsize',18);
        legend(u_legend_str,'interpreter','latex','fontsize',14,...
            'location','best');
    end
    
end