%==========================================================================
%
% f2stm_num  State transition matrix and propagated state vector from 
% continuous dynamics equation.
%
%   Phi = f2stm_num(f,x,u,t,dt,method)
%   Phi = f2stm_num(f,x,[],[],dt,method)
%   [Phi,x_next] = f2stm_num(__)
%
% Author: Tamas Kis
% Last Update: 2022-03-28
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   x       - (n×1 double) state vector at current time, x(t)
%   u       - (m×1 double) (OPTIONAL) control input at current time, u(t)
%   t       - (1×1 double) (OPTIONAL) current time
%   dt      - (1×1 double) time step, Δt
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 
%             'Euler')
%
% -------
% OUTPUT:
% -------
%   Phi     - (n×n double) state transition matrix from current time to 
%             next time, Φ(t+Δt,t)
%   x_next  - (n×1 double) state vector at next time, x(t+Δt)
%
% -----
% NOTE:
% -----
%   --> If you would not like to specify "u" or "t", you can input them as
%       the empty vector "[]".
%   --> If "u" is input, it is assumed that it is constant over the time
%       interval [t,t+Δt).
%
%==========================================================================
function Phi = f2stm_num(f,x,u,t,dt,method)
    
    % function handle for dynamics Jacobian
    A = @(x,u,t) f2A_num(f,x,u,t);
    
    % solve for Φ(t+Δt,t)
    if (nargin == 6) && ~isempty(method)
        Phi = Af2stm_num(A,f,x,u,t,dt,method);
    else
        Phi = Af2stm_num(A,f,x,u,t,dt);
    end
    
end