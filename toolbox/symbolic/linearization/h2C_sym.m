%==========================================================================
%
% h2C_sym  Continuous measurement Jacobian from continuous measurement
% equation.
%
%   C = h2C_sym(h,x)
%   C = h2C_sym(h,x,xe)
%   C = h2C_sym(h,x,xe,u,ue)
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
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (p×1 sym) continuous measurement equation
%   x       - (n×1 sym) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   C       - (p×n sym) continuous measurement Jacobian
%
%==========================================================================
function C = h2C_sym(h,x,xe,u,ue)
    
    % Jacobian of h w.r.t. x
    C = simplify(jacobian(h,x),'Steps',20);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(x)
            C = simplify(subs(C,x(i),xe(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(u)
            C = simplify(subs(C,u(i),ue(i)),'Steps',20);
        end
    end
    
end