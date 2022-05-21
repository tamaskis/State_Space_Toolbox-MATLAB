%==========================================================================
%
% h2D_num  Continuous feedforward Jacobian from continuous measurement
% equation.
%
%   D = h2D_num(h,x,u)
%   D = h2D_num(h,x,u,t)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   x       - (n×1 double) state vector to linearize about
%   u       - (m×1 double) control input to linearize about
%   t       - (1×1 double) (OPTIONAL) time at linearization
%
% -------
% OUTPUT:
% -------
%   D       - (p×m double) continuous feedforward Jacobian
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
function D = h2D_num(h,x,u,t)
    
    % defaults time to empty vector if not specified
    if (nargin < 4)
        t = [];
    end
    
    % continuous feedforward Jacobian
    D = ijacobian(@(u)h(x,u,t),u);
    
end