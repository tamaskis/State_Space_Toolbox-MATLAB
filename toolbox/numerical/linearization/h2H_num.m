%==========================================================================
%
% h2H_num  Discrete measurement Jacobian from continuous measurement
% equation.
%
%   H = h2H_num(h,x)
%   H = h2H_num(h,x,u)
%   H = h2H_num(h,x,[],t)
%   H = h2H_num(h,x,u,t)
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
%   Hk      - (p×n double) discrete measurement Jacobian
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
function Hk = h2H_num(h,x,u,t)
    if nargin == 4
        Hk = h2C_num(h,x,u,t);
    else
        Hk = h2C_num(h,x,u);
    end
end