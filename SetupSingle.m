clear all; close all;

% change the highest path to the directory of the AwesomeOCIM
do.highestpath='/Users/hengdi/Desktop/AwesomeOCIM_v1.1';

% change the filename that you want to save your model results to
filename='test';

% if you have started to create any subfolders which contain your own personal
% functions with interface with the AO, add those path names here 
% e.g. addpath Seth_Cdmodel

% note that not all of the functions listed below are compatible; for
% example conc only works if your model doesn't have any other external
% sources or sinks, and a model with only internal cycling won't work
% correctly without conc to set the mean ocean concentration; if you leave
% all of the code below intact so that all of the standard do.functions.on
% variables exist, then Awesome will automatically check for many of the
% common incompatabilites; if you choose to delete reference to any of the
% functions below, you will also wind up disabling the error-checking in
% Awesome; incompatability-checking is always enabled when usng the GUI

% set the mean ocean concentration
do.conc.on=1;
do.conc.c=6; % μmole m-3

% radioactive decay
do.decay.on=0;
do.decay.halflife=1; % y

% reversible scavenging to a particle field with unform distribution in the oceans
do.revscav.on=1;
do.revscav.K=0.8;
do.revscav.w=100; % m y-1
do.revscav.sedremin=1;

% reversible scavenging onto POC
do.revscavPOC.on=0;
do.revscavPOC.K=1; % (μmole m-3 POC)-1
do.revscavPOC.w=1; % m y-1
do.revscavPOC.sedremin=1;

% irreversible scavenging onto POC
do.nonrevscavPOC.on=0;
do.nonrevscavPOC.K=1; % (μmole m-3 POC)-1 y-1

% biological uptake and remineraliztion where uptake is determined by an 'alpha' compared to P uptake
do.bioalpha.on=1;
do.bioalpha.alpha = 0.3;
do.bioalpha.martinb = 0.86;
do.bioalpha.sedremin=1;

% biological uptake and remineralization with a fixed redfield ratio
do.bioredfield.on = 0;
do.bioredfield.Rep = 1; % (μmole m-3 y-1 E)/(μmole m-3 y-1 P)
do.bioredfield.martinb = 1;
do.bioredfield.sedremin=1;

% a 'sponge'-type boundary condition for some tracer along any number of GEOTRACES sections
do.boundcon.on=0;
do.boundcon.tracer='GTCd';
do.boundcon.masknames={'GA02' 'GP16' 'GP18'};

% hydrothermal input
do.hydrothermal.on=0;
do.hydrothermal.K=1; % (μmole m-3 y-1 E)/(μmole m-3 y-1 He)

% input from nephloid layers
do.nephloid.on=0;
do.nephloid.K=1; % (μmole m-3 y-1 E)/(cm2 s-1 EKE)

% aerosol input
do.dust.on=0;
do.dust.fire=1;
do.dust.Rfire=1; % (μmole m-3 y-1 E)/(mg m-3 y-1 aerosol)
do.dust.biofuel=1;
do.dust.Rbiofuel=1;
do.dust.fossilfuel=1;
do.dust.Rfossilfuel=1;
do.dust.mineral=1;
do.dust.Rmineral=1;
do.dust.seasalt=1;
do.dust.Rseasalt=1;
do.dust.plants=1;
do.dust.Rplants=1;
do.dust.volcanic=1;
do.dust.Rvolcanic=1;

% run the Awesome code with the do structure defined above
Awesome (filename,do)
