%--------------------------------------------------------------------------
%
% lti  Class defining a linear time-invariant (LTI) state space system.
%
% Author: Tamas Kis
% Last Update: 2022-08-27
%
%--------------------------------------------------------------------------

classdef lti < handle
    
    properties
        A       % (n×n double) continuous dynamics matrix
        B       % (n×m double) continuous input matrix
        C       % (p×n double) continuous measurement matrix
        D       % (p×m double) continuous feedforward matrix
    end
    
    
    


    methods
        
        
        
        function obj = lti(A,B,C,D)
            %==============================================================
            % obj = GPS_Constellation(sim_file_name,gps_file_name,n)
            %
            % Constructor.
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   A       - (n×n double) continuous dynamics matrix
            %   B       - (n×m double) continuous input matrix
            %   C       - (p×n double) continuous measurement matrix
            %   D       - (p×m double) continuous feedforward matrix
            %
            % -------
            % OUTPUT:
            % -------
            %   obj     - (1×1 GPS_Constellation) LTI object
            %
            %==============================================================
            
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.D = D;

        end
        
        
        
        function [t,x,y] = sim(obj,x0,t0,tf,dt)
            %==============================================================
            % [t,x,y] = sim(obj,x0,t0,tf)
            %
            % Simulate an LTI system.
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   x0      - (n×1 double) initial condition
            %   t0      - (1×1 double) initial time
            %   tf      - (1×1 double) final time
            %   dt      - (1×1 double) time step
            %
            % -------
            % OUTPUT:
            % -------
            %   TODO
            %
            %==============================================================

        end
        
    end 
end