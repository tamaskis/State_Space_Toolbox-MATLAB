%==========================================================================
%
% h2D_lti  Continuous feedforward Jacobian from continuous measurement
% equation via linearization about an equilibrium point.
%
%   D = h2D_lti(h,xe,ue)
%   D = h2D_lti(h,xe,ue,tl)
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
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   D       - (p×m double) continuous feedforward Jacobian
%
%==========================================================================
function D = h2D_lti(h,xe,ue,tl)
    
    % defaults time to empty vector
    if (nargin < 4)
        tl = [];
    end
    
    % continuous measurement Jacobian
    D = ijacobian(@(u)h(xe,u,tl),ue);
    
end