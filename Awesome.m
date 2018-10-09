function Awesome(filename,do);

% add path for the folder with source and sink functions
addpath srcsnk

% load information about the model grid and the water transport matrix
load data/ao
load data/water_transport

% initailize the b array with zeros
b = zeros(200160,1);

% initalize the A array with zeros
A = sparse(200160,200160);

% modify the A and b matrices to represent biogeochemical cycling; this
% searches for do.function.on equal to 1, where the function is any of the
% specific source and sink functions in srcsnk; of course, if you add a
% path to your subfolder then you can also make new functions which can be
% called by do
fprintf('\n%s','Modifying A and b...'); tic
whatfields=fieldnames(do);cits={};
for i=1:length(whatfields)
    if isfield(do.(whatfields{i}),'on') && do.(whatfields{i}).on==1
        fun=str2func(whatfields{i});str=whatfields{i};
        [A,b,output]=fun(A,b,do); op.(str)=output; cits(i)=output.citations;
    end
end
toc

% identify possible incompatabilities between various source and sink
% functions, see SetupSingle for more information
if ((isfield(do,'revscavPOC')&isfield(do.revscavPOC,'sedremin'))&isfield(do,'revscav')&isfield(do,'nonrevscavPOC')&isfield(do,'nephloid')&isfield(do,'hydrothermal')&isfield(do,'dust')&isfield(do,'decay')&isfield(do,'conc')&isfield(do,'boundcon')&(isfield(do,'bioredfield')&isfield(do.bioredfield,'sedremin'))&(isfield(do,'bioalpha')&isfield(do.bioalpha,'sedremin')))
    if max(abs(b))==0; warning('It looks like you dont have any external sources or sinks in your model, which means that your model is underdetermined. If you dont want to include any sources or sinks, then you at least need to set the mean ocean concentration using conc.'); end;
    if (do.conc.on&(do.dust.on|do.hydrothermal.on|do.nephloid.on|do.boundcon.on|do.decay.on|(do.bioalpha.on&~do.bioalpha.sedremin)|(do.bioredfield.on&~do.bioredfield.sedremin))); warning('It looks like you are trying to use the conc function, but the model may also include some other source or sink of E from the model which will overwhelm the conc.'); end;
    if ((do.hydrothermal.on|do.dust.on|do.nephloid.on)&~(do.decay.on|(do.bioalpha.on&~do.bioalpha.sedremin)|(do.bioredfield.on&~do.bioredfield.sedremin)|(do.revscav.on&~do.revscav.sedremin)|(do.revscavPOC.on&~do.revscavPOC.sedremin))); warning('It looks like you have included a source of your tracer without including a sink, and therefore there isnt a steady-state solution'); end;
    if (~(do.hydrothermal.on|do.dust.on|do.nephloid.on)&(do.decay.on|(do.bioalpha.on&~do.bioalpha.sedremin)|(do.bioredfield.on&~do.bioredfield.sedremin)|(do.revscav.on&~do.revscav.sedremin)|(do.revscavPOC.on&~do.revscavPOC.sedremin))); warning('It looks like you have included a sink of your tracer without including a source, and therefore there isnt a steady-state solution'); end;
end

% every run of the model needs water circulation, so add the transport to A matrix
A = A + water_transport;

fprintf('\nSolving the tracer distribution by matrix division...')
tic
e=A\b; % these six characters perform the magic of linear algebra!
toc

% linear algebra solution yields an array of the 200160 values of elemental
% concentrations (e), which we then need to put into a shoebox (put them
% into the 3d model grid E)
E = ao.nanOCN;
E(ao.iocn) = e;

fprintf('\n%s%s%s\n\n','Solving complete! Saving solution to the output folder as ',filename,'.mat')

% print a list of all the citable datasets this model run used
fprintf('Your model run used the following citable materials:\n\ttransport: T. DeVries, The oceanic anthropogenic CO2 sink: Storage, air sea fluxes, and transports over the industrial era. Global Biogeochem. Cycles 28, 631?647 (2014). doi:10.1002/2013GB004739. \n');
for k=1:length(whatfields)
    if isfield(do.(whatfields{k}),'on') && do.(whatfields{k}).on==1
        if ~isempty(cits{k}); fprintf('\t%s: %s\n',whatfields{k},cits{k}); end
    end
end    

save ([do.highestpath '/output/' filename '.mat'],'E','e','op');

end