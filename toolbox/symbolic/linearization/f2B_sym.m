%==========================================================================
%
% f2B_sym  Continuous input Jacobian from continuous dynamics equation.
%
%   B = f2B_sym(f,u)
%   B = f2B_sym(f,u,ue,x,xe)
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
%   f       - (n×1 sym) continuous dynamics equation
%   u       - (m×1 sym) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%   x       - (n×1 sym) (OPTIONAL) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%
% -------
% OUTPUT:
% -------
%   B       - (n×m sym) continuous input Jacobian
%
%==========================================================================
function B = f2B_sym(f,u,ue,x,xe)
    
    % Jacobian of f w.r.t. u
    B = simplify(jacobian(f,u),'Steps',20);
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin >= 3) && ~isempty(ue)
        for i = 1:length(u)
            B = simplify(subs(B,u(i),ue(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin == 5) && ~isempty(xe)
        for i = 1:length(x)
            B = simplify(subs(B,x(i),xe(i)),'Steps',20);
        end
    end
    
end