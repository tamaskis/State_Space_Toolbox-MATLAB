%==========================================================================
%
% hd2J_sym  Discrete feedforward Jacobian from discrete measurement
% equation.
%
%   J = hd2J_sym(hd,uk)
%   J = hd2J_sym(hd,uk,ue,xk,xe)
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
%   hd      - (p×1 sym) discrete measurement equation
%   uk      - (m×1 sym) control input at kth sample, uₖ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%   xk      - (n×1 sym) (OPTIONAL) state vector at kth sample, xₖ
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%
% -------
% OUTPUT:
% -------
%   J       - (p×n sym) discrete feedforward Jacobian at kth sample
%
%==========================================================================
function J = hd2J_sym(hd,uk,ue,xk,xe)
    
    % Jacobian of hd w.r.t. uk
    J = simplify(jacobian(hd,uk),'Steps',20);
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin >= 3) && ~isempty(ue)
        for i = 1:length(uk)
            H = simplify(subs(H,uk(i),ue(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin == 5) && ~isempty(xe)
        for i = 1:length(xk)
            H = simplify(subs(H,xk(i),xe(i)),'Steps',20);
        end
    end
    
end