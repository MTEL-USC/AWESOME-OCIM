function makeLATLONprof(DATA,lat,lon,plotmin,plotmax) 

%find the 'path' of the parent directory
parentpath = pwd;
load ([parentpath '/data/ao.mat']);

if lon<0
    lon = lon+360;
end
% The ~ represents an output that is discarded
[~,latindex] = min(abs(ao.lat-lat));
[~,lonindex] = min(abs(ao.lon-lon));
prof = squeeze(DATA(latindex,lonindex,:));
plot(prof,ao.depth)
set(gca,'Ydir','reverse','Xlim',[plotmin plotmax])
