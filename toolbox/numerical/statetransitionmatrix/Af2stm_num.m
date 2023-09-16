%==========================================================================
%
% Af2stm_num  State transition matrix and propagated state vector from 
% continuous dynamics Jacobian and continuous dynamics equation.
%
%   Phi = Af2stm_num(A,f,dt,x)
%   Phi = Af2stm_num(A,f,dt,x,u,t)
%   Phi = Af2stm_num(A,f,dt,x,u,t,dtau,method)
%   [Phi,x_next] = Af2stm_num(__)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-06-27
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
%   A       - (1×1 function_handle) continuous dynamics Jacobian, A(x,u,t)
%             (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   dt      - (1×1 double) macro time step, Δt
%   x       - (n×1 double) state vector at current time, x(t)
%   u       - (m×1 double) (OPTIONAL) control input at current time, u(t) 
%             (defaults to empty vector) TODO: ACTUALLY FUNCTION HANDLE,
%             ZOH?
%   t       - (1×1 double) (OPTIONAL) current time (defaults to 0)
%   dtau    - (1×1 double) (OPTIONAL) micro time step, Δτ
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
%   --> If you do not want to specify "u", "t", "dtau", or "method", you 
%       can input them as the empty vector "[]".
%   --> If "u" is input, it is assumed that it is constant over the time
%       interval [t,t+Δt).
%
%==========================================================================
function [Phi,x_next] = Af2stm_num(A,f,dt,x,u,t,dtau,method)
    
    % defaults control input to empty vector
    if (nargin < 5) || isempty(u)
        u = [];
    end
    
    % defaults time to 0
    if (nargin < 6) || isempty(t)
        t = 0;
    end
    
    % determines if micro step is input
    if (nargin < 7) || isempty(dtau)
        micro_step_input = false;
    else
        micro_step_input = true;
    end
    
    % defaults method to 'RK4'
    if (nargin < 8) || isempty(method)
        method = 'RK4';
    end
    
    % state dimension
    n = length(x);
    
    % initial condition for augmented STM (at time tₖ)
    Omegak = [eye(n),x];
    
    % function handle for dΩ/dt = [AΦ f]
    dOmegadt = @(t,Omega) [A(Omega(:,n+1),u(Omega(:,n+1),t),t)*Omega(:,...
        1:n),f(Omega(:,n+1),u(Omega(:,n+1),t),t)];
    
    % solve for Ω(t+Δt,t) via a macro step
    if ~micro_step_input
        if strcmpi(method,'Euler')
            Omega = RK1_euler(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK2')
            Omega = RK2(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK2 Heun')
            Omega = RK2_heun(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK2 Ralston')
            Omega = RK2_ralston(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK3')
            Omega = RK3(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK3 Heun')
            Omega = RK3_heun(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK3 Ralston')
            Omega = RK3_ralston(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'SSPRK3')
            Omega = SSPRK3(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK4')
            Omega = RK4(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK4 Ralston')
            Omega = RK4_ralston(dOmegadt,t,Omegak,dt);
        elseif strcmpi(method,'RK4 3/8')
            Omega = RK4_38(dOmegadt,t,Omegak,dt);
        end
    end
    
    % solve for Ω(t+Δt,t) via micro steps
    if micro_step_input
        
        % converts to vector-valued ODE
        g = odefun_mat2vec(F,n);
        omega0 = odeIC_mat2vec(Omegak);
        
        % solves equivalent vector-valued ODE and extracts final solution
        [~,omega] = ode(g,[t,t+dt],omega0,dtau,method);
        omega = omega(end,:);
        
        % converts back to matrix form
        Omega = ivpsol_vec2mat(omega,n);
        
    end
    
    % extract Φ(t+Δt,t) and x(t+Δt) from Ω(t+Δt,t)
    Phi = Omega(:,1:n);
    x_next = Omega(:,n+1);
    
end