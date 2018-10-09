function makesection(DATA,ocn,plotmin,plotmax)
% MAKESECTION make a section plot

%find the 'path' of the parent directory
parentpath = pwd;
load ([parentpath '/data/ao.mat']);

DATAMASK = ao.OCN;
DATAMASK(isnan(DATA))=0;
section = squeeze(nansum(DATA.*DATAMASK.*ao.VOL.*ao.(ocn),2)./nansum(DATAMASK.*ao.VOL.*ao.(ocn),2))';
pcolor(ao.lat,ao.depth,section); shading flat;
set(gca,'Ydir','reverse','Clim',[plotmin plotmax])
colorbar
    
end

