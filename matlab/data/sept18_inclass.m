clear all
close all

%plot 3-d function
t=0:.1:6*pi;
x=sqrt(t).*sin(2*t);
y=sqrt(t).*cos(2*t);
z=0.5*t;
figure(1)
plot3(x,y,z,'r','linewidth',1);
grid on
xlabel('x'); ylabel('y');zlabel('z')

%create surface plot
figure(2)
clear x;y;
x=-1:3;
y=1:4;
[X,Y] = meshgrid(x,y);
Z = X.*Y.^2 ./ (X.^2 + Y.^2);
figure(2)
subplot(2,1,1)
surf(Z)
xlabel('columns of Z')
ylabel('rows of Z')

subplot(2,1,2)
surf(X,Y,Z)
xlabel('X')
ylabel('Y')

%plot terrain near Salt Lake
%define plotting area for Salt Lake area
minlat=40.25;
maxlat=41.25;
maxlon=-111.5;
minlon=-113.0;
latlim=[minlat maxlat];
lonlim=[minlon maxlon];
bbox = [minlon minlat;maxlon maxlat];

%read shapefiles
lakes = shaperead('lk24ap09.shp','UseGeoCoords',true,'BoundingBox',bbox,...
              'Attributes',{'NAME','FEATURE'});

roads = shaperead('roadtrl020.shp','UseGeoCoords',true,'BoundingBox',bbox,...
                'Attributes',{'NAME','FEATURE'});
 
%the state info is built into the mapping tool box
states = shaperead('usastatehi',...
        'UseGeoCoords', true, 'BoundingBox',bbox);
%dont really need this but is an alternative source for state boundaries
%states = shaperead('statesp020.shp','UseGeoCoords',true,'BoundingBox',bbox);

%use netcdf functions to open file containing terrain surrounding KMTX radar
ncid=netcdf.open('KMTX_terrain.nc','NC_NOWRITE');
%get all the info on the netcdf file
all_info = ncinfo('KMTX_terrain.nc');
[varname, xtype, varDimIDs, varAtts] = netcdf.inqVar(ncid,0);
varid = netcdf.inqVarID(ncid,'elevation');

%latg- vector from lowest lat to highest lat
latg = netcdf.getVar(ncid,1,'double');
%long- vector from lowest lon to highest lon
long = netcdf.getVar(ncid,2,'double');
%2d array of elev stored as long rows and latg columns
elev = netcdf.getVar(ncid,varid,'double');

%transpose elev so that latg rows and long columns
hgt=elev';
netcdf.close(ncid);

% plot base map using surfm
figure(3)
cmap = colormap(bone);
% use projection info supplied by matlab
ax=usamap(latlim, lonlim);
% handle labels
setm(ax,'MlabelLocation',0.2,'PlabelLocation',0.2,'MLineLocation',0.2,'PLineLocation',0.2);
surfm(latg,long,hgt);
%hold on
geoshow(ax,lakes, 'FaceColor','blue');
geoshow(ax,roads, 'color','c');
title('base map using surfm','FontSize',10);
saveas(gcf,'base_map_surfm','png');

% plot base map using contourfm
figure(4)
cmap = colormap(bone);
% use projection info supplied by matlab
ax=usamap(latlim, lonlim);
% handle labels
setm(ax,'MlabelLocation',0.2,'PlabelLocation',0.2,'MLineLocation',0.2,'PLineLocation',0.2);
h1=contourfm(latg,long,hgt,1000:250:3000);
colorbar;
hold on
geoshow(ax,lakes, 'FaceColor','blue');
geoshow(ax,roads, 'color','c');
geoshow(ax, states, 'FaceColor', 'none')
title('base map using contourfm','FontSize',10);
saveas(gcf,'base_map_contourfm','png');

%create a 2 x 2 image with RGB and white values
col = zeros(2,2,3);
% element 1x1 is red
col(1,1,1) = 255;
%element 1x2 is green
col(1,2,2) = 255;
%element 2x1 is blue
col(2,1,3) = 255;
%element 2x2 is white
col(2,2,1:3) = 255;
%convert to smallest size uint
coli = uint8(col);
figure(5)
image(coli)

%define nc as the number of elements in a colormap
nc = 100;
% define nc red, green, and blue values between 0-1
r = linspace(0,1,nc);
g = linspace(0,1,nc);
b = linspace(0,1,nc);
% define row vector of zeros
n = zeros(1,nc);

% create a row vector with nc elements
I = 1:nc;

figure(6)
%create grey colormap
map_grey = [r', g', b'];
%imagesc displays the colormap
imagesc(I)
colormap(map_grey)
%create a red colormap
map_red = [r',n',n'];
figure(7)
imagesc(I)
colormap(map_red)

%see how the jet color map is defined
figure(8)
imagesc(I)
cmap = colormap('jet');
%how many values are in the jet colormap?

%make a yellow color map!
%make a cyan color map!
figure(9)
map_yellow = [r',g',n'];
imagesc(I)
colormap(map_yellow)
