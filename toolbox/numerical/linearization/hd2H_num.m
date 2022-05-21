%==========================================================================
%
% hd2H_num  Discrete measurement Jacobian from discrete measurement
% equation.
%
%   Hk = hd2H_num(hd,x)
%   Hk = hd2H_num(hd,x,u)
%   Hk = hd2H_num(hd,x,[],k)
%   Hk = hd2H_num(hd,x,u,k)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   hd      - (1×1 function_handle) discrete measurement equation
%               --> if "u" NOT input, then yₖ = hd(xₖ,k) (hd : ℝⁿ×ℤ → ℝᵖ)
%               --> if "u" input, then yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%   x       - (n×1 double) state vector to linearize about
%   u       - (m×1 double) (OPTIONAL) control input to linearize about
%   k       - (1×1 double) (OPTIONAL) sample number at linearization
%
% -------
% OUTPUT:
% -------
%   Hk      - (p×n double) discrete measurement Jacobian at kth sample time
%
% -----
% NOTE:
% -----
%   --> If linearizing about equilibrium point (xₑ,uₑ), input xₑ for x and
%       uₑ for u.
%   --> If linearizing about reference trajectory (xᵣ,uᵣ), input xᵣ at
%       sample k for x and uᵣ at sample k for u.
%
%==========================================================================
function Hk = hd2H_num(hd,x,u,k)
    
    % defaults sample number to empty vector if not specified
    if (nargin < 4)
        k = [];
    end

    % discrete measurement Jacobian
    if (nargin >= 3) && ~isempty(u)
        Hk = ijacobian(@(x)hd(x,u,k),x);
    else
        Hk = ijacobian(@(x)hd(x,k),x);
    end
    
end