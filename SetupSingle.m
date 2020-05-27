% Start fresh by clearing all variables and plots
clear all
close all

% Change the highest path to the directory of the AwesomeOCIM
do.highestpath = '/Users/hengdi/Desktop/AwesomeOCIM_v1.1' ;

% Change the filename that you want to save your model results to
filename = 'test' ;

% If you have started to create any subfolders which contain your own personal
% functions that interface with the AWESOME OCIM (AO), add those path names here
% e.g.,
%
%>> addpath Seth_Cdmodel

% Note that not all of the functions listed below are compatible. For
% example, conc only works if your model doesn't have any other external
% sources or sinks, and a model with only internal cycling won't work
% correctly without conc to set the mean ocean concentration. If you leave
% all of the code below intact so that all of the standard do.functions.on
% variables exist, then the AO will automatically check for many of the
% common incompatibilities. Deleting the reference to any of the
% functions below disables the incompatibility-checking in the AO.
% (Incompatibility-checking is always enabled when using the GUI.)

% Set the mean ocean concentration
do.conc.on = 1 ;
do.conc.c = 6 ; % μmol m⁻³

% Radioactive decay
do.decay.on = 0 ;
do.decay.halflife = 1 ; % yr

% Reversible scavenging to a particle field with unform distribution in the oceans
do.revscav.on = 1 ;
do.revscav.K = 0.8 ;      % unitless
do.revscav.w = 100 ;      % m yr⁻¹
do.revscav.sedremin = 1 ; % unitless

% Reversible scavenging onto POC
do.revscavPOC.on = 0 ;
do.revscavPOC.K = 1 ; % (μmolPOC m⁻³)⁻¹
do.revscavPOC.w = 1 ; % m yr⁻¹
do.revscavPOC.sedremin = 1 ;

% Irreversible scavenging onto POC
do.nonrevscavPOC.on = 0 ;
do.nonrevscavPOC.K = 1 ; % (μmolPOC m⁻³)⁻¹

% Biological uptake and remineralization where uptake is determined as a fractionation
% of P uptake (with fractionation factor `alpha`)
do.bioalpha.on = 1 ;
do.bioalpha.alpha = 0.3 ;    % unitless
do.bioalpha.martinb = 0.86 ; % unitless
do.bioalpha.sedremin = 1 ;

% Biological uptake and remineralization with a fixed redfield ratio
do.bioredfield.on = 0 ;
do.bioredfield.Rep = 1 ; % (μmolE m⁻³ yr⁻¹)/(μmolP m⁻³ yr⁻¹)
do.bioredfield.martinb = 1 ;
do.bioredfield.sedremin = 1 ;

% a 'sponge'-type boundary condition for some tracer along any number of GEOTRACES sections
do.boundcon.on = 0 ;
do.boundcon.tracer = 'GTCd' ;
do.boundcon.masknames = {'GA02' 'GP16' 'GP18'} ;

% hydrothermal input
do.hydrothermal.on = 0 ;
do.hydrothermal.K = 1 ; % (μmolE m⁻³ yr⁻¹)/(μmolHe m⁻³ yr⁻¹)

% input from nephloid layers
do.nephloid.on = 0 ;
do.nephloid.K = 1 ; % (μmolE m⁻³ yr⁻¹)/(cm² s⁻¹ EKE)

% aerosol input
do.dust.on = 0 ;
do.dust.fire = 1 ;
do.dust.Rfire = 1 ; % (μmolE m⁻³ yr⁻¹)/(mg m⁻³ yr⁻¹ aerosol)
do.dust.biofuel = 1 ;
do.dust.Rbiofuel = 1 ;
do.dust.fossilfuel = 1 ;
do.dust.Rfossilfuel = 1 ;
do.dust.mineral = 1 ;
do.dust.Rmineral = 1 ;
do.dust.seasalt = 1 ;
do.dust.Rseasalt = 1 ;
do.dust.plants = 1 ;
do.dust.Rplants = 1 ;
do.dust.volcanic = 1 ;
do.dust.Rvolcanic = 1 ;

% run the Awesome code with the do structure defined above
Awesome (filename,do)

