function [ t, x, y, v_x, v_y, v ] = projectile(v0, theta, num)
%projectile Shoot something
%   Calculate the x and y position and velocity of a projectile at time t
%   when launched at angle theta with velocity v0.
%
%    Input:
%        v0    - initial velocity of the projectile when launched (m/s)
%        theta - angle projectile is launched (degrees)
%        num   - number of point calculations per flight used by np.linspace().
%    Output:
%        t     - time vector (seconds)
%        x     - x position vector (m)
%        y     - y position vector (m)
%        v_x   - x-component velocity vector (m/s)
%        v_y   - y-component velocity vector (m/s)
%        v     - velocity magnitude vector (m/s)

    
    % Gravitational Acceleration
    g = 9.81;  % m/s^2
    
    % Calculate total time of flight
    total_t = 2*v0*sind(theta)/g;
    % Create a time vector between 0 and total time
    t = linspace(0,total_t,num);
    
    % Calculate X and Y position of projectile
    x = v0*t*cosd(theta);
    %note that squaring a vector, so need to use .^
    y = v0*t*sind(theta) - .5*g*t.^2;
    
    % Compute velocity components and magnitude
    v_x = v0*cosd(theta); 
    %v_y is a vector
    v_y = v0*sind(theta) - g*t;
    % v_x is a scalar and v_y is a vector
    v = sqrt(v_x^2+v_y.^2);


