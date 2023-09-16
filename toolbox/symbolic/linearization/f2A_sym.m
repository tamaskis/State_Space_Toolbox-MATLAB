%==========================================================================
%
% f2A_sym  Continuous dynamics Jacobian from continuous dynamics equation.
%
%   A = f2A_sym(f,x)
%   A = f2A_sym(f,x,xe)
%   A = f2A_sym(f,x,xe,u,ue)
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
%   x       - (n×1 sym) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   A       - (n×n sym) continuous dynamics Jacobian
%
%==========================================================================
function A = f2A_sym(f,x,xe,u,ue)
    
    % Jacobian of f w.r.t. x
    A = simplify(jacobian(f,x),'Steps',20);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(x)
            A = simplify(subs(A,x(i),xe(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(u)
            A = simplify(subs(A,u(i),ue(i)),'Steps',20);
        end
    end
    
end