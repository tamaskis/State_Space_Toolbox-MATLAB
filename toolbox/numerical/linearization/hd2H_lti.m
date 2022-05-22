%==========================================================================
%
% hd2H_lti  Discrete measurement Jacobian from discrete measurement
% equation via linearization about an equilibrium point.
%
%   H = hd2H_lti(hd,xe)
%   H = hd2H_lti(hd,xe,ue)
%   H = hd2H_lti(hd,xe,[],kl)
%   H = hd2H_lti(hd,xe,ue,kl)
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
%   hd      - (1×1 function_handle) discrete measurement equation
%               --> if "u" NOT input, then yₖ = hd(xₖ,k) (hd : ℝⁿ×ℤ → ℝᵖ)
%               --> if "u" input, then yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%   kl      - (1×1 double) (OPTIONAL) sample number at linearization, kₗ
%
% -------
% OUTPUT:
% -------
%   H       - (p×n double) discrete measurement Jacobian
%
%==========================================================================
function H = hd2H_lti(hd,xe,ue,kl)
    
    % defaults equilibrium control input to empty vector
    if (nargin < 3)
        ue = [];
    end
    
    % defaults sample number at linearization to empty vector
    if (nargin < 4)
        kl = [];
    end
    
    % discrete measurement Jacobian
    H = ijacobian(@(x)hd(x,ue,kl),xe);
    
end