function makeMERIDIONALsection(DATA,meridion,plotmin,plotmax) 

%find the 'path' of the parent directory
parentpath = pwd;
load ([parentpath '/data/ao.mat']);

if meridion<0
    meridion = meridion+360;
end
[~,index] = min(abs(ao.lon-meridion));
section = squeeze(DATA(:,index,:));
pcolor(ao.lat,ao.depth,section'); shading flat;
set(gca,'Ydir','reverse','Clim',[plotmin plotmax])
colorbar