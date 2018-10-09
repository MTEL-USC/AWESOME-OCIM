function GUIplotting(DATA,doATLprof,doPACprof,doGLOBALprof,doLATLONprof,lat,lon,doATLsection,doPACsection,doGLOBALsection,doMERIDIONALsection,meridion,doZONALsection,zone,doGTsection,GTsection,GTorientation,doLIMITS,lowlim,highlim);
% GUIPLOTTING plots profiles or sections of a given tracer or a model-simulated file, 
% in Pacific, Atlantic, or globally. 
% Users can also input lat/lon information to customize their own plotting of interest.
% GEOTRACES_2017_IDP datasets are also available for plotting: just choose a cruise and an orientation, the section can be plotted.
% Conc limits range can be set manually.

%find the 'path' of the parent directory
parentpath = pwd;
load ([parentpath '/data/ao.mat']);
% Import data
% allDATA=importdata([parentpath '/output/' filename '.mat']);
% DATA=allDATA.E;

DATAMASK = ao.OCN;
DATAMASK(isnan(DATA))=0;

clf; set(gcf,'Renderer','opengl','color','w');

% Set limits range
if doLIMITS
    plotmin=lowlim;
    plotmax=highlim;
else
    clf;
    plot(DATA(:));
    lims = ylim;
    plotmin=lims(1);
    plotmax=lims(2);
end

% Plot profiles
if doATLprof; makeprof(DATA,'ATL',plotmin,plotmax); end
if doPACprof; makeprof(DATA,'PAC',plotmin,plotmax); end
if doGLOBALprof; makeprof(DATA,'OCN',plotmin,plotmax); end
if doLATLONprof; makeLATLONprof(DATA,lat,lon,plotmin,plotmax); end
% Plot sections
if doATLsection; makesection(DATA,'ATL',plotmin,plotmax); end
if doPACsection; makesection(DATA,'PAC',plotmin,plotmax); end
if doGLOBALsection; makesection(DATA,'OCN',plotmin,plotmax); end
if doMERIDIONALsection; makeMERIDIONALsection(DATA,meridion,plotmin,plotmax); end
if doZONALsection; makeZONALsection(DATA,zone,plotmin,plotmax); end

if doGTsection
    GTmask = ao.GTmasks.(GTsection);
    section = squeeze(nansum(GTmask.*DATAMASK.*DATA.*ao.VOL.*ao.OCN,GTorientation)./nansum(GTmask.*DATAMASK.*ao.VOL.*ao.OCN,GTorientation))';
    % Choose a GEOTRACES orientation
    if GTorientation == 1
        pcolor(ao.lon,ao.depth,section); shading flat;
    elseif GTorientation==2
        pcolor(ao.lat,ao.depth,section); shading flat;
    end
    set(gca,'Ydir','reverse','Clim',[plotmin plotmax])
    colorbar
end


