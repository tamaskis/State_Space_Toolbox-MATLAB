%==========================================================================
%
% f2fd_fun  Discrete nonlinear dynamics equation from continuous nonlinear 
% dynamics equation (numerical approximation).
%
%   fd = f2fd_fun(f,dt)
%   fd = f2fd_fun(f,dt,t0)
%   fd = f2fd_fun(f,dt,[],method)
%   fd = f2fd_fun(f,dt,t0,method)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous nonlinear dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 
%             'Euler')
%
% -------
% OUTPUT:
% -------
%   fd      - (1×1 function_handle) discrete nonlinear dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%
%==========================================================================
function fd = f2fd_fun(f,dt,t0,method)

    % t as a function of k
    if (nargin == 3) && ~isempty(t0)
        t = k2t_fun(dt,t0);
    else
        t = k2t_fun(dt);
    end
    
    % defaults method to 'Euler' if not specified
    if (nargin < 4) || isempty(method)
        method = 'Euler';
    end

    % redfines f assuming a constant control input
    f_ctrl = @(t,x) f(x,0,t);

    % discretization
    if strcmpi(method,'Euler')
        fd = @(xk,uk,k) RK1_euler_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK2')
        fd = @(xk,uk,k) RK2_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK2 Heun')
        fd = @(xk,uk,k) RK2_heun_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK2 Ralston')
        fd = @(xk,uk,k) RK2_ralston_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK3')
        fd = @(xk,uk,k) RK3_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK3 Heun')
        fd = @(xk,uk,k) RK3_heun_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK3 Ralston')
        fd = @(xk,uk,k) RK3_ralston_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'SSPRK3')
        fd = @(xk,uk,k) SSPRK3_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK4')
        fd = @(xk,uk,k) RK4_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK4 Ralston')
        fd = @(xk,uk,k) RK4_ralston_step(f_ctrl,t(k),xk,dt);
    elseif strcmpi(method,'RK4 3/8')
        fd = @(xk,uk,k) RK4_38_step(f_ctrl,t(k),xk,dt);
    end

end