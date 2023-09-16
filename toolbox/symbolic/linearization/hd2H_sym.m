%==========================================================================
%
% hd2H_sym  Discrete measurement Jacobian from discrete measurement
% equation.
%
%   H = hd2H_sym(hd,xk)
%   H = hd2H_sym(hd,xk,xeq)
%   H = hd2H_sym(hd,xk,xeq,uk,ue)
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
%   xk      - (n×1 sym) state vector at kth sample, xₖ
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   uk      - (m×1 sym) (OPTIONAL) control input at kth sample, uₖ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   H       - (p×n sym) discrete measurement Jacobian at kth sample
%
%==========================================================================
function H = hd2H_sym(hd,xk,xe,uk,ue)
    
    % Jacobian of hd w.r.t. xk
    H = simplify(jacobian(hd,xk),'Steps',20);
    
    % evaluates Jacobian at equilibrium state if provided
    if (nargin >= 3) && ~isempty(xe)
        for i = 1:length(xk)
            H = simplify(subs(H,xk(i),xe(i)),'Steps',20);
        end
    end
    
    % evaluates Jacobian at equilibrium control input if provided
    if (nargin == 5) && ~isempty(ue)
        for i = 1:length(uk)
            H = simplify(subs(H,uk(i),ue(i)),'Steps',20);
        end
    end
    
end