% This script uses Cd as an example to show how to grid data from the
% GEOTRACES 2017 Intermediate Data Product onto the AO grid. The GEOTRACES
% IDP user agreement does not allow for distribution of data by third
% parties, and thus users will need to download their own 2017 IDP
% datasets. Before running this script, you must download GEOTRACES
% Discrete Sample Data (NetCDF format) from:
% https://www.bodc.ac.uk/geotraces/data/idp2017/. Then, save the nc file in
% this folder (AweosomeOCIM_v1.3/data/GEOTRACES_2017_IDP)

clear all; close all;

% load target grid
load ../ao

% load GEOTRACES data and grid
lat = ncread('GEOTRACES_IDP2017_v2_Discrete_Sample_Data.nc','latitude');
lon = ncread('GEOTRACES_IDP2017_v2_Discrete_Sample_Data.nc','longitude');
cruise = ncread('GEOTRACES_IDP2017_v2_Discrete_Sample_Data.nc','metavar1');
depth = ncread('GEOTRACES_IDP2017_v2_Discrete_Sample_Data.nc','var2');
% Choose your own tracer; the number of your tracer can be found in the
% downloaded nc_variables.txt (e.g. for Cd, the number is var70). Also,
% note that and the end of this script, you must specify the filename to
% which you want to save the gridded data. 
data = ncread('GEOTRACES_IDP2017_v2_Discrete_Sample_Data.nc','var70'); 

cruiseid = sum(double(cruise),1)';

% GEOTRACES dimensions
nstations = size(cruise,2);
nsample = size(depth,1);
ntotal = nstations*nsample;

% repeat lat and lon
lat = repmat(lat',[nsample,1]);
lon = repmat(lon',[nsample,1]); 
cruiseid = repmat(cruiseid',[nsample,1]); 

% Cadmium data from GIPY11 (cruiseid 411) was incorrect in the 2017 version
% 1 IDP. Thus, we show how to remove those data from the final gridded
% dataset. Delete this line for other tracers, or delete your own outliers
% like this.
data(cruiseid==411) = NaN;

% find datapoints
Idata = find(~isnan(data));

% reshape into vectors
lon = lon(Idata);
lat = lat(Idata);
depth = depth(Idata);
data = data(Idata);
cruiseid = cruiseid(Idata);

% note, the bin3d code doesn't seem to be able to deal with data along the
% zero meridion, therefore change all values between 359 to 360 and 0 to 1
% to be exactly 1
lon(lon>359)=1; lon(lon<1)=1;

% estimated measurement error
dataerr = data*.05;

% grid data
[GTdata,GTvardata,GTndata,Q] = bin3d(lon,lat,depth,data,dataerr,ao.LON,ao.LAT,ao.DEPTH);

% replace missing values with NaN, instead of -9
GTdata(GTdata==-9)=NaN;
GTvardata(GTvardata==-9)=NaN;
GTdata(ao.OCN==0)=NaN;

% Now, you need to clarigy that the data you have gridded is for Cd (or
% whatever else your dataset is).
GTCd = GTdata;
save ('GTCd.mat', 'GTCd')