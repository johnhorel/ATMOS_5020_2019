%start with all variables undefined
clear all
%remove any figure windows
close all

% use the matlab function csvread to open the wildfires csv file that
% contains info on wildfires nationwide
% file_name is a string variable
file_name = 'data/wildfires.csv';
% first column is years, second is number of fires, and third is acres
% burned
%assign all the values to an array
fires = csvread(file_name);
% find the number of years (rows)
no_yrs = length(fires);
% find the dimensions of the fires vector
size_fires = size(fires);
%note that most recent year is in row 1
fires(1,:)
%create a vector of years
yrs = fires(:,1);
%create a vector of number of fires
no_fires = fires(:,2);
%create a vector of acres burned
acres = fires(:,3);

%plotting one vector vs another
% define the window for a plot
figure(1)
% create a simple x vs. y plot
plot(yrs,acres)
% handle labeling
xlabel('year')
ylabel('acres burned')
title('Acreage Burned Nationwide')

%could have done the same thing on the basis of columns in the fires array
figure(2)
%plot as vertical bars
bar(fires(:,1),fires(:,2))
xlabel('year')
ylabel('annual number of fires')
title('Number of Fires Annually Nationwide')

%create a column vector of ones of length yrs
yo = ones(length(yrs),1);
% yo has size 59 x 1
%compute the means of each column
fm = mean(fires);
% this is a row vector
%think about what happened here
%fm has size 1 x 3
%is fm(1) of much interest?
% create an array that has the means of each column in each correct row 
means = yo * fm;
% means is now 59 x 3

% let's create departures from the mean, those are anomalies
% requires having arrays of same dimensions
anom = fires - means;
figure(3)
% plot years vs acreage burned anomalies
bar(fires(:,1),anom(:,3))
xlabel('year')
ylabel('Anomalies of Acres Burned')
title('Annual Anomalies of Acres Burned')



