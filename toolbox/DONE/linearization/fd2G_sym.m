%==========================================================================
%
% fd2G_sym  Discrete input Jacobian from discrete dynamics equation.
%
%   G = fd2G_sym(fd,uk)
%   G = fd2G_sym(fd,uk,ue,xk,xe)
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
%   uk      - (m×1 sym) control input at kth sample, uₖ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%   xk      - (n×1 sym) (OPTIONAL) state vector at kth sample, xₖ
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%
% -------
% OUTPUT:
% -------
%   G       - (n×m sym) discrete input Jacobian at kth sample
%
%==========================================================================
function G = fd2G_sym(fd,uk,ue,xk,xe)
    
    % Jacobian of fd w.r.t. uk
    G = simplify(jacobian(fd,uk),'Steps',20);
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin >= 3) && ~isempty(ue)
        for i = 1:length(uk)
            G = simplify(subs(G,uk(i),ue(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin == 5) && ~isempty(xe)
        for i = 1:length(xk)
            G = simplify(subs(G,xk(i),xe(i)),'Steps',20);
        end
    end
    
end