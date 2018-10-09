function makeprof(DATA,ocn,plotmin,plotmax)
% MAKEPROF make a depth profile of the tracer, as input of data 

%find the 'path' of the parent directory
parentpath = pwd;
load ([parentpath '/data/ao.mat']);

DATA(ao.(ocn)==0)=NaN;
DATAMASK=ao.OCN;
DATAMASK(isnan(DATA))=NaN;
prof = squeeze(nansum(nansum(DATA.*ao.VOL.*ao.(ocn)))./nansum(nansum(DATAMASK.*ao.VOL.*ao.(ocn))));
plot(prof,ao.depth)
set(gca,'Ydir','reverse','Xlim',[plotmin plotmax])
end