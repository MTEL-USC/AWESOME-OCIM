function makeZONALsection(DATA,zone,plotmin,plotmax) 

%find the 'path' of the parent directory
parentpath = pwd;
load ([parentpath '/data/ao.mat']);

[~,index] = min(abs(ao.lat-zone));
section = squeeze(DATA(index,:,:))';
pcolor(ao.lon,ao.depth,section); shading flat;
set(gca,'Ydir','reverse','Clim',[plotmin plotmax])
colorbar