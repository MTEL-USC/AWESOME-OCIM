function [A,b,output] = dust(A,b,do);
%DUST adds a source of your element from aerosols 
%   The underlying aerosol deposition fields come from the lab of Natalie
%   Mahowald. The data was originally provided in units of kg m-2 y-1, but
%   they are stored in the AO in the structure AEROSOLDEP in units of mg
%   m-3 y-1. That is to say that the surface flux has already been adjusted
%   to assume that it is instantaneously mixed into the surface grid cell.
%   Therefore, to further convert these fluxes into the AO units of mmole
%   m-3 y-1, you will need to specify the amount of your element released
%   by the dust in units of mmole/mg.

fprintf('%s','dust...')

% unpack the key parameters
fire = do.dust.fire; % set to one to add a source from fire
Rfire = do.dust.Rfire; % the ratio of your element to total fire aerosols in mmole per mg
biofuel = do.dust.biofuel;
Rbiofuel = do.dust.Rbiofuel;
fossilfuel = do.dust.fossilfuel;
Rfossilfuel = do.dust.Rfossilfuel;
mineral = do.dust.mineral;
Rmineral = do.dust.Rmineral;
seasalt = do.dust.seasalt;
Rseasalt = do.dust.Rseasalt;
plants = do.dust.plants;
Rplants = do.dust.Rplants;
volcanic = do.dust.volcanic;
Rvolcanic = do.dust.Rvolcanic;

% load the ao grid and the aerosol deposition data
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/AEROSOLDEP.mat'])

% initialize the 'sourceb' vector which will contain all of the dust inputs
sourceb = zeros(ao.nocn,1);

if do.dust.fire
    SOURCE = AEROSOLDEP.FIRE * Rfire;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

if do.dust.biofuel
    SOURCE = AEROSOLDEP.BIOFUEL * Rbiofuel;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

if do.dust.fossilfuel
    SOURCE = AEROSOLDEP.FOSSILFUEL * Rfossilfuel;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

if do.dust.mineral
    SOURCE = AEROSOLDEP.MINERAL * Rmineral;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

if do.dust.seasalt
    SOURCE = AEROSOLDEP.SEASALT * Rseasalt;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

if do.dust.plants
    SOURCE = AEROSOLDEP.PLANTS * Rplants;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

if do.dust.volcanic
    SOURCE = AEROSOLDEP.VOLCANIC * Rvolcanic;
    % turn the shoebox into a linear vector
    sourceb = sourceb + SOURCE(ao.iocn);
end

% add the dust source fluxes (remember, when something is added to the rhs
% of an equation, it winds up subtraced from the lhs)
b = b - sourceb;

% don't modify the A matrix
A = A;

% package outputs
output.fire = fire;
output.Rfire = Rfire;
output.biofuel = biofuel;
output.Rbiofuel = Rbiofuel;
output.fossilfuel = fossilfuel;
output.Rfossilfuel = Rfossilfuel;
output.mineral = mineral;
output.Rmineral = Rmineral;
output.seasalt = seasalt;
output.Rseasalt = Rseasalt;
output.plants = plants;
output.Rplants = Rplants;
output.volcanic = volcanic;
output.Rvolcanic = Rvolcanic;
output.sourceb=sourceb;
output.citations={'aerosol deposition fields from Brahney, J., Mahowald, N. Ward, D., Ballantyne, A. Neff, J., Is atmospheric phosphorus pollution altering global alpine lake stoichiometry? Global Biogeochemical Cycles, 29, doi:10.1002/ 2015GB005137. and Chien, C.-T., K. Mackey, S. Dutkiewicz, N. Mahowald, J. Prospero, A. Paytan, Effects of African dust deposition on phytoplankton in the western tropical Atlantic Ocean off Barbados, Global Biogeochemical Cycles, 30, 716-734, doi:10.1002/2015GB005334.'};
