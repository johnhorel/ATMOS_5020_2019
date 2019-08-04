
clear all
close all

% Matlab Input-Output (I/O) Methods
% Objective: Reinforce concepts related to input operations and plotting

% Interactive Data Input
% First, let's manually enter values interactively
% Ask for user input. have to tell it to be a string
my_name = input('What is my name?','s');
%input a number 
my_address_str = input('what is my street address?');



% Download text from a URL
% We can access tons of information directly from the web and load that data into Python.

%One resource to get weather data is a Wyoming web site that provides observations made from rawinsondes of the vertical distribution of wind, tempeature, and moisure with height at hundreds of locations across the world. This data is otherwise known as a sounding.
%
%Take a look at http://weather.uwyo.edu/upperair/sounding.html and click on SLC.
%
%You will see an HTML file with data for different weather variables at different levels:

%http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST&YEAR=2018&MONTH=11&FROM=1112&TO=1112&STNM=72572

%from the python notes, see how the file was created

% but this has been cleaned up for this matlab code to only the data, not
% the header and footer
filename = 'data/slc_snd.txt';
% open the file and return an integer that is the id for the file
fileID = fopen(filename);
% use the matlab textscan and read as floats even if data are integers
S = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f %f');
%close the file
fclose(fileID);
%look at the contents of S. Each column is a cell, which allows different
% data types to be returned
%the function cell2mat converts all the cells of the same type
% (floats in this case) into an array
snd_vals = cell2mat(S);

%first row
fr = snd_vals(1,:);
% first column
fc = snd_vals(:,1);

% Plot Sounding Data
% Accessing variable data from the 2D array
%define plotting window
figure(1)
%plot temperature vs. height
plot(snd_vals(:,3), snd_vals(:,2))
xlabel('Temperature (C)')
ylabel('Elevation (m)')
title('Salt Lake Sounding Temperature')
% add grid
grid on

% some basic matlab concepts
% array from 2D List. how does this compare to python syntax?
a = [1 2 3 4; 5 6 7 8; 9 10 11 12];

% Reshape
% converting list from 1 to 12, to a 3x4 array
b = reshape(1:12,3,4);

%using meshgrid
% Given two different 1D vectors...
% how does the differ from python
x = -1:.25:1;
y = -1:.25:1;

% Create a grid of the data...
[X,Y] = meshgrid(x,y);

% Now, do some computations with the gridded data and plot a funky shape
EPS=1.0E-4;
% note the elementwise array multiplication
r = sqrt(X.^2 + Y.^2) + EPS;
Z = sin(r)./r;
figure(2)
%surface plot in 3 d with some transparency
surface(X, Y, Z,'FaceAlpha',0.5);
% define perspective of view angle
view(3)
grid on
colorbar

%go ahead and increase the range to +- 8

%more on shape and flattening arrays
%create an array with 2 3x5 arrays
c = reshape([1:30],[3,5,2]);
% Flatten that array to a column vector
d = reshape(c,[numel(c),1]);
% flatten that array to a row vector
e = reshape(c,[1,numel(c)]);

% matlab handles logical similar to python
g500 = snd_vals(:,1)>500;
%value 1 means true, value 0 means false

% Which index values for presssure in the slc_snd array are greater than 500 hPa?
%matlab find similar to python where
high_p = find(g500);

% So, what are those values of pressure greater than 500 hPa?
p_vals = snd_vals(high_p,1);

% find can use multiple logic but let's do it like we did for python...
high_Pressure = snd_vals(:,1) > 500;
high_wind_speed = snd_vals(:,8) > 15;
%we can do as before using logic
both = high_Pressure .* high_wind_speed;

% what are those values?
pres_values = snd_vals(find(both), 1);
wind_speed_values = snd_vals(find(both), 8);

%as before, want to plot when wind greaster than 15 knots only
%in python we created a mask, here we will set the light winds to NaN
% find all the elements with winds < 15 knots
%first plot everything
% plot all the winds in one color and then the stronger winds in another
figure(3)
plot(snd_vals(:,8),snd_vals(:,1),'r')
hold on
%want pressure to decrease with height
%gca is the handle for the plot, a way to define characteristics
%within the plot
set (gca,'Ydir','reverse')
ylim([0 875])
xlim([0 70])
xlabel('Wind Speed (knots)')
ylabel('Pressure (hPa)')
title('Salt Lake Sounding Wind Speed. ONLY Winds Greater than 15 knots in Green')
grid on

%now find the light winds
w_l_15 =  snd_vals(:,8)<15;
%got those index values so set the wind speed values to NaN
snd_vals(w_l_15,8) = NaN;
%plot again for the high winds
plot(snd_vals(:,8),snd_vals(:,1),'g', 'linewidth',3)



