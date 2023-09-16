%==========================================================================
%
% LTI_CL_response  Dynamic response of a linear time-invariant system given
% the closed loop matrices using output feedback.
%
%   [t,x] = LTI_CL_response(Acl,Bcl,[],[],r)
%   [t,x,y] = LTI_CL_response(Acl,Bcl,Ccl,Dcl,r)
%   [t,x,y,u,e] = LTI_CL_response(Acl,Bcl,Ccl,Dcl,r,Kfb,Kff,L)
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
%   Acl     - (2n×n double) closed loop dynamics matrix
%   Bcl     - (2n×m double) closed loop input matrix
%   Ccl     - (OPTIONAL) (p×2n double) closed loop output matrix
%   Dcl     - (OPTIONAL) (p×m double) closed loop feedforward matrix
%   r       - (OPTIONAL) (function_handle or p×1 double) reference input 
%             r(t), where r:R->Rp (defaults to 0)
%   Kfb     - (OPTIONAL) (m×n double) feedback gain matrix
%   Kff     - (OPTIONAL) (m×p double) feedforward gain matrix
%   L       - (OPTIONAL) (n×p double) observer gain matrix
%   opts    - (OPTIONAL) (struct) solver options
%       • x0    - (n×1 double) initial condition (defaults to 0)
%       • e0    - (n×1 double) initial error (defaults to 0)
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
%   e       - ((N+1)×n double) matrix storing time history of state
%             estimate error
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
%   --> The ith row of "e" is the TRANSPOSE of the state estimate error at
%       time ti (i.e. the control corresponding to the ith time in "t").
%   --> If a "C" matrix is specified but a "D" is not, it is assumed that 
%       D = 0.
%   --> Any quantities that cannot be determined are returned as "NaN".
%
%==========================================================================
function [t,x,y,u,e] = LTI_CL_response(Acl,Bcl,Ccl,Dcl,r,Kfb,Kff,L,opts)

    % --------------------------------------------------
    % Determines if optional parameters have been input.
    % --------------------------------------------------

    Ccl_input = (nargin >= 3) && ~isempty(Ccl);
    Dcl_input = (nargin >= 4) && ~isempty(Dcl);
    r_input = (nargin >= 5) && ~isempty(r);
    Kfb_input = (nargin >= 6) && ~isempty(Kfb);
    Kff_input = (nargin >= 7) && ~isempty(Kff);
    L_input = (nargin >= 8) && ~isempty(L);
    opts_input = (nargin >= 9) && ~isempty(opts);

    % -----------
    % Dimensions.
    % -----------

    % state (n), control input (m), and output (p) dimensions
    n = size(Acl,1)/2;
    m = size(Bcl,2);
    if Ccl_input, p = size(Ccl,1); end
    
    % ----------------------------------------------------
    % Sets unspecified parameters to their default values.
    % ----------------------------------------------------

    % defaults reference input to a unit step input
    if ~r_input
        r = zeros(p,1);
    end

    % defaults Dcl to 0 if Ccl is input but Dcl is not
    if Ccl_input && ~Dcl_input
        Dcl = zeros(p,m);
    end

    % sets initial condition (defaults to 0)
    if opts_input && isfield(opts,'x0')
        x0 = opts.x0;
    else
        x0 = zeros(n,1);
    end

    % sets initial error (defaults to 0)
    if opts_input && isfield(opts,'e0')
        e0 = opts.e0;
    else
        e0 = zeros(n,1);
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
    f = @(t,xcl) Acl*xcl+Bcl*r(t);

    % runs simulation (i.e. find state and error time histories)
    [t,xcl] = ode45(f,tspan,[x0;e0]);
    
    % length of time vector minus 1
    N = length(t)-1;

    % extracts state vector and state estimate error time histories
    x = xcl(:,1:n);
    e = xcl(:,(n+1):2*n);
    
    % control vector time history (returns NaN if Kfb is not input)
    if Kfb_input
        u = zeros(N+1,m);
        if Kff_input
            for i = 1:(N+1)
                u(i,:) = -Kfb*x(i,:)'+Kff*r(t(i));
            end
        else
            for i = 1:(N+1)
                u(i,:) = -Kfb*x(i,:)';
            end
        end
    else
        u = NaN;
    end
    
    % output vector time history (returns NaN if Ccl isn't input)
    Dcl_exists = exist('Dcl','var');
    if Ccl_input
        y = zeros(N+1,p);
        if Dcl_exists
            for i = 1:(N+1)
                y(i,:) = (Ccl*xcl(i,:)'+Dcl*r(t(i)))';
            end
        else
            for i = 1:(N+1)
                y(i,:) = (Ccl*xcl(i,:)')';
            end
        end
    else
        y = NaN;
    end

end