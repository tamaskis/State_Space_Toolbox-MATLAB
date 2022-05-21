%==========================================================================
%
% f2A_num  Continuous dynamics Jacobian from continuous dynamics equation.
%
%   A = f2A_num(f,x)
%   A = f2A_num(f,x,u)
%   A = f2A_num(f,x,[],t)
%   A = f2A_num(f,x,u,t)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   x       - (n×1 double) state vector to linearize about
%   u       - (m×1 double) (OPTIONAL) control input to linearize about
%   t       - (1×1 double) (OPTIONAL) time at linearization
%
% -------
% OUTPUT:
% -------
%   A       - (n×n double) continuous dynamics Jacobian
%
% -----
% NOTE:
% -----
%   --> If linearizing about equilibrium point (xₑ,uₑ), input xₑ for x and
%       uₑ for u.
%   --> If linearizing about reference trajectory (xᵣ,uᵣ), input xᵣ at time
%       t for x and uᵣ at time t for u.
%
%==========================================================================
function A = f2A_num(f,x,u,t)
    
    % defaults control input to empty vector if not specified
    if (nargin < 3)
        u = [];
    end
    
    % defaults time to empty vector if not specified
    if (nargin < 4)
        t = [];
    end
    
    % continuous dynamics Jacobian
    A = ijacobian(@(x)f(x,u,t),x);
    
end