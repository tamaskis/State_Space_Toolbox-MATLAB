%==========================================================================
%
% h2C_num  Continuous measurement Jacobian from continuous measurement
% equation.
%
%   C = h2C_num(h,x)
%   C = h2C_num(h,x,u)
%   C = h2C_num(h,x,[],t)
%   C = h2C_num(h,x,u,t)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (1×1 function_handle) continuous measurement equation
%               --> if "u" NOT input, then y = h(x,t) (h : ℝⁿ×ℝ → ℝᵖ)
%               --> if "u" input, then y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   x       - (n×1 double) state vector to linearize about
%   u       - (m×1 double) (OPTIONAL) control input to linearize about
%   t       - (1×1 double) (OPTIONAL) time at linearization
%
% -------
% OUTPUT:
% -------
%   C       - (p×n double) continuous measurement Jacobian
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
function C = h2C_num(h,x,u,t)
    
    % defaults time to empty vector if not specified
    if (nargin < 4)
        t = [];
    end
    
    % continuous measurement Jacobian
    if (nargin >= 3) && ~isempty(u)
        C = ijacobian(@(x)h(x,u,t),x);
    else
        C = ijacobian(@(x)h(x,t),x);
    end
    
end