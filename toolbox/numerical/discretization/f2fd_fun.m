%==========================================================================
%
% f2fd_fun  Discrete dynamics equation from continuous dynamics equation.
%
%   fd = f2fd_fun(f,dt)
%   fd = f2fd_fun(f,dt,t0)
%   fd = f2fd_fun(f,dt,[],method)
%   fd = f2fd_fun(f,dt,t0,method)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-06-04
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) time step, Δt
%   t0      - (1×1 double) (OPTIONAL) initial time, t₀ (defaults to 0)
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 'RK4')
%
% -------
% OUTPUT:
% -------
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%
%==========================================================================
function fd = f2fd_fun(f,dt,t0,method)
    
    % defaults initial time to 0
    if (nargin < 3) || isempty(t0)
        t0 = 0;
    end
    
    % defaults method to 'RK4'
    if (nargin < 4) || isempty(method)
        method = 'RK4';
    end
    
    % t as a function of k
    t = k2t_fun(dt,t0);
    
    % discretization
    if strcmpi(method,'Euler')
        fd = @(xk,uk,k) RK1_euler(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK2')
        fd = @(xk,uk,k) RK2(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK2 Heun')
        fd = @(xk,uk,k) RK2_heun(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK2 Ralston')
        fd = @(xk,uk,k) RK2_ralston(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK3')
        fd = @(xk,uk,k) RK3(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK3 Heun')
        fd = @(xk,uk,k) RK3_heun(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK3 Ralston')
        fd = @(xk,uk,k) RK3_ralston(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'SSPRK3')
        fd = @(xk,uk,k) SSPRK3(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK4')
        fd = @(xk,uk,k) RK4(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK4 Ralston')
        fd = @(xk,uk,k) RK4_ralston(@(t,x)f(x,uk,t),t(k),xk,dt);
    elseif strcmpi(method,'RK4 3/8')
        fd = @(xk,uk,k) RK4_38(@(t,x)f(x,uk,t),t(k),xk,dt);
    end
    
end