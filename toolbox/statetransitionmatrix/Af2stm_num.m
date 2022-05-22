%==========================================================================
%
% Af2stm_num  State transition matrix and propagated state vector from 
% continuous dynamics Jacobian and continuous dynamics equation.
%
%   Phi = Af2stm_num(A,f,x,u,t,dt,method)
%   Phi = Af2stm_num(A,f,x,[],[],dt,method)
%   [Phi,x_next] = Af2stm_num(__)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-05-22
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/documentation/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   A       - (1×1 function_handle) continuous dynamics Jacobian, A(x,u,t)
%             (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   x       - (n×1 double) state vector at current time, x(t)
%   u       - (m×1 double) (OPTIONAL) control input at current time, u(t)
%   t       - (1×1 double) (OPTIONAL) current time
%   dt      - (1×1 double) time step, Δt
%   method  - (char) (OPTIONAL) integration method --> 'Euler', 'RK2', 
%             'RK2 Heun', 'RK2 Ralston', 'RK3', 'RK3 Heun', 'RK3 Ralston', 
%             'SSPRK3', 'RK4', 'RK4 Ralston', 'RK4 3/8' (defaults to 'RK4')
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
%   --> If you do not want to specify "u" or "t", you can input them as the
%       empty vector "[]".
%   --> If "u" is input, it is assumed that it is constant over the time
%       interval [t,t+Δt).
%
%==========================================================================
function [Phi,x_next] = Af2stm_num(A,f,x,u,t,dt,method)
    
    % defaults method to 'RK4'
    if (nargin < 7) || isempty(method)
        method = 'RK4';
    end
    
    % state dimension
    n = length(x);
    
    % initial condition for augmented STM (at time tₖ)
    Psik = [eye(n),x];
    
    % function handle for dΨ/dt = [AΦ f]
    dPsidt = @(t,Psi) [A(Psi(:,n+1),u,t)*Psi(:,1:n),f(Psi(:,n+1),u,t)];
    
    % solve for Ψ(t+Δt,t)
    if strcmpi(method,'Euler')
        Psi = RK1_euler_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK2')
        Psi = RK2_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK2 Heun')
        Psi = RK2_heun_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK2 Ralston')
        Psi = RK2_ralston_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK3')
        Psi = RK3_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK3 Heun')
        Psi = RK3_heun_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK3 Ralston')
        Psi = RK3_ralston_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'SSPRK3')
        Psi = SSPRK3_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK4')
        Psi = RK4_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK4 Ralston')
        Psi = RK4_ralston_step(dPsidt,t,Psik,dt);
    elseif strcmpi(method,'RK4 3/8')
        Psi = RK4_38_step(dPsidt,t,Psik,dt);
    end
    
    % extract Φ(t+Δt,t) and x(t+Δt) from Ψ(t+Δt,t)
    Phi = Psi(:,1:n);
    x_next = Psi(:,n+1);
    
end