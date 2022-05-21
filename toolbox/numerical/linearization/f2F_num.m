%==========================================================================
%
% f2F_num  Discrete dynamics Jacobian from continuous dynamics equation.
%
%   Fk = f2F_num(f,xk,uk,tk,dt)
%   Fk = f2F_num(f,xk,[],[],dt)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   xk      - (n×1 double) state vector at kth sample time, xₖ
%   uk      - (m×1 double) (OPTIONAL) control input at kth sample time, uₖ
%   tk      - (1×1 double) (OPTIONAL) time at kth sample time, tₖ
%   dt      - (1×1 double) time step, Δt
%
% -------
% OUTPUT:
% -------
%   Fk      - (n×n double) discrete dynamics Jacobian at kth sample time, 
%             Fₖ
%
% -----
% NOTE:
% -----
%   --> If linearizing about equilibrium point (xₑ,uₑ), input xₑ for x and
%       uₑ for u.
%   --> If linearizing about reference trajectory (xᵣ,uᵣ), input xᵣ at
%       sample k for x and uᵣ at sample k for u.
%   --> If "uk" is input, it is assumed that it is constant over the time
%       interval [tₖ,tₖ₊₁).
%   --> Fₖ = Φ(tₖ₊₁,tₖ)
%
%==========================================================================
function Fk = f2F_num(f,xk,uk,tk,dt)
    Fk = f2stm_num(f,xk,uk,tk,dt);
end