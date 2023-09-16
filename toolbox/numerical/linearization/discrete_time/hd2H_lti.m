%==========================================================================
%
% hd2H_lti  Discrete measurement Jacobian from discrete measurement
% equation via linearization about an equilibrium point.
%
%   H = hd2H_lti(hd,d,xe)
%   H = hd2H_lti(hd,d,xe,ue)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-09-14
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
%   hd      - (1×1 function_handle) discrete measurement equation, 
%             yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%   d       - (1×1 Differentiator) differentiator
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   H       - (p×n double) discrete measurement Jacobian
%
%==========================================================================
function H = hd2H_lti(hd,d,xe,ue)
    
    % defaults equilibrium control input to empty vector
    if (nargin < 3)
        ue = [];
    end
    
    % discrete measurement Jacobian
    H = d.jacobian(@(x)hd(x,ue,0),xe);
    
end