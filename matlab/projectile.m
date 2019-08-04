% clear all variables
clear all
%close all figure windows
close all
%repeat as in python code on November 8
velocity = 20;
angle = 45;
[t, x, y, v_x, v_y, v] = projectile_function(velocity, angle, 50);
figure(1)
plot(x, y)

% now do for a bunch
velocity = 20;           % m/s
figure(2)
for angle = 10:10:90
    % Compute the path for each angle
    [t, x, y, v_x, v_y, v] = projectile_function(velocity, angle, 50);
    plot(x, y)
    hold on
end

xlabel('Distance (m)')
ylabel('Height (m)')
title('Projectile Path');