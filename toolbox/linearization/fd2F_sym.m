%==========================================================================
%
% fd2F_sym  Discrete dynamics Jacobian from discrete dynamics equation.
%
%   F = fd2F_sym(fd,xk)
%   F = fd2F_sym(fd,xk,xe)
%   F = fd2F_sym(fd,xk,xe,uk,ue)
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
%   fd      - (n×1 sym) discrete dynamics equation
%   xk      - (n×1 sym) state vector at kth sample, xₖ
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   uk      - (m×1 sym) (OPTIONAL) control input at kth sample, uₖ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian at kth sample
%
%==========================================================================
function F = fd2F_sym(fd,xk,xe,uk,ue)
    
    % Jacobian of fd w.r.t. xk
    F = simplify(jacobian(fd,xk),'Steps',20);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(xk)
            F = simplify(subs(F,xk(i),xe(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(uk)
            F = simplify(subs(F,uk(i),ue(i)),'Steps',20);
        end
    end
    
end