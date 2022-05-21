%==========================================================================
%
% f2B_num  Continuous input Jacobian from continuous dynamics equation.
%
%   B = f2B_num(f,x,u)
%   B = f2B_num(f,x,u,t)
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
%   u       - (m×1 double) control input to linearize about
%   t       - (1×1 double) (OPTIONAL) time at linearization
%
% -------
% OUTPUT:
% -------
%   B       - (n×m double) continuous input Jacobian
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
function B = f2B_num(f,x,u,t)
    
    % defaults time to empty vector if not specified
    if (nargin < 4)
        t = [];
    end
    
    % continuous input Jacobian
    B = ijacobian(@(u)f(x,u,t),u);
    
end