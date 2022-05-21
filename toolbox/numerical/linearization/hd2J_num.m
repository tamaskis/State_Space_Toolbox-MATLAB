%==========================================================================
%
% hd2J_num  Discrete feedforward Jacobian from discrete measurement
% equation.
%
%   Jk = hd2J_num(hd,x,u)
%   Jk = hd2J_num(hd,x,u,k)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   hd      - (1×1 function_handle) discrete measurement equation, 
%             yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%   x       - (n×1 double) state vector to linearize about
%   u       - (m×1 double) control input to linearize about
%   k       - (1×1 double) (OPTIONAL) sample number at linearization
%
% -------
% OUTPUT:
% -------
%   Jk      - (p×m double) discrete feedforward Jacobian at kth sample time
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
function Jk = hd2J_num(hd,x,u,k)
    
    % defaults sample number to empty vector if not specified
    if (nargin < 4)
        k = [];
    end

    % discrete feedforward Jacobian
    Jk = ijacobian(@(u)hd(x,u,k),u);
    
end