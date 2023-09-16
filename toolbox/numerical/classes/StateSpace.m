%==========================================================================
%
% StateSpace  Class defining a state space system.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-08-27
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%==========================================================================

classdef StateSpace
    
    % -----------
    % Properties.
    % -----------

    properties
        
        % State transition matrices.
        
        stm         % TODO

        % Continuous-time NLTV system.

        f           % (1×1 function_handle) continuous dynamics equation, dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
        h           % (1×1 function_handle) continuous measurement equation, y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
        
        % Continuous-time LTV system.

        A               % (1×1 function_handle) continuous dynamics Jacobian, A(x,u,t) (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
        B               % (1×1 function_handle) continuous input Jacobian, B(x,u,t) (B : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣᵐ)
        C               % (1×1 function_handle) continuous measurement Jacobian, C(x,u,t) (C : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣⁿ)
        D               % (1×1 function_handle) continuous feedforward Jacobian, D(x,u,t) (D : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣᵐ)
        
        % Discrete-time NLTV system.
        
        fd              % (1×1 function_handle) discrete dynamics equation, xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
        hd              % (1×1 function_handle) discrete measurement equation, yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)

        % Discrete-time LTV system.

        F               % (1×1 function_handle) discrete dynamics Jacobian, F(xₖ,uₖ,k) (F : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣⁿ)
        G               % (1×1 function_handle) discrete input Jacobian, G(xₖ,uₖ,k) (G : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣᵐ)
        H               % (1×1 function_handle) discrete measurement Jacobian, H(xₖ,uₖ,k) (H : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣⁿ)
        J               % (1×1 function_handle) discrete feedforward Jacobian, J(xₖ,uₖ,k) (J : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣᵐ)
        
        % Math objects.
        
        differentiator  % (1×1 Differentiator) differentiator object
        integrator      % (1×1 Integrator) integrator object

    end
    
    % --------
    % Methods.
    % --------
    
    methods
        
        % ------------
        % Constructor.
        % ------------

        function obj = StateSpace(opts)
            % state_space = StateSpace(opts)
            %
            % Constructor.
            %
            % -------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   opts    - (OPTIONAL) (1×1 struct) options structure
            %
            % -------
            % OUTPUT:
            % -------
            %   state_space - (1×1 StateSpace) state space object
            %
            % -------------------------------------------------------------
            
            % initializes default differentiator if not input
            if (nargin < 1) || isempty(numdiff)
                numdiff = NumDiff;
            end

            % initializes default integrator if not input
            if (nargin < 1) || isempty(integrator)
                integrator = Integrator;
            end

            % assigns properties of StateSpace object
            obj.numdiff = numdiff;
            obj.integrator = integrator;
            
        end

        
        % -----------------------------------------------------------------
        % Defines state space system using a continuous-time NLTV description.
        % -----------------------------------------------------------------

        function obj = NLTV(obj,f,h)
            % state_space.NLTV(f,h)
            %
            % Defines the state space system from a continuous-time 
            % nonlinear time-variant representation.
            %
            % -------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   f       - (1×1 function_handle) continuous dynamics 
            %             equation, dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
            %   h       - (1×1 function_handle) continuous measurement 
            %             equation, y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
            %
            % -------
            % OUTPUT:
            % -------
            %   state_space - (1×1 StateSpace) state space object
            %
            % -------------------------------------------------------------
            
            % linearizes to form continuous-time LTV system
            obj.A = f2A_fun(obj.f);
            obj.B = f2B_fun(obj.f);
            obj.C = h2C_fun(obj.h);
            obj.D = h2D_fun(obj.h);

            % discretizes to form discrete-time NLTV system
            obj.fd = f2fd_fun(obj.f,dt);
            obj.hd = f2fd_fun(obj.f,dt);

            % linearizes+discretizers to form discrete-time LTV system
            obj.F = f2F_fun(f,dt);
            
        end
        
    end 
end