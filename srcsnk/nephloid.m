function [A,b,output] = nephloid(A,b,do);
%NEPHLOID adds a source of your element from nephloid layers
%    This function adds a source of your element to the bottom grid cell in
%    each water column which is proportional to the eddy kinetic energy
%    (EKE) calculated for the surface ocean at the top of that column. EKE
%    data  was provided by Yannice Faugere at CLS in France, with
%    assistance from Marie-Isabelle Pujol (also at CLS), and Prof. Dudley
%    Chelton at OSU. The EKE field will soon be published as: "DUACS
%    DT-2018 : 25 years of reprocessed sea level altimeter products." ,
%    Taburet et al, in prep. This script and any following work which draws
%    heavily upon this eke field should also acknowledge CMEMS for the data
%    from which this mean were derived as follows: "This study has been
%    conducted using E.U. Copernicus Marine Service Information." The
%    global relationship between surface eddy kinetic energy and nephloid
%    layers comes from work of Wilford Gardner and colleagues
%    as detailed in their publications: Gardner, W.D., B.E. Tucholke, M.J.
%    Richardson, and P.E. Biscaye. Benthic storms, nepheloid layers, and
%    linkage with upper ocean dynamics in the Western North Atlantic.
%    Invited Review article, 2016, Marine Geology, and Wilford D. Gardner,
%    Mary Jo Richardson, and Alexey V. Mishonov, 2018 Global assessment of
%    benthic nepheloid layers and linkage with upper ocean dynamics. EPSL
%    482, 126-134. Eddy kinetic energy is measured in units of cm^2 s-2,
%    and input is therefore in units of mmole m-3 y-1 E per cm^2 s-1 EKE.

fprintf('%s','nephloid...')

% load the grid and the He flux data
load ([do.highestpath '/data/ao.mat'])
load ([do.highestpath '/data/NEPHLOIDFLUX.mat'])

% unpack the E/He input ratio
K = do.nephloid.K;

% calculate the hydrothermal flux of your element in each grid cell
SOURCE = NEPHLOIDFLUX*K;

% turn the shoebox into a linear vector
sourceb = SOURCE(ao.iocn);

% add the nephloid layer flux (remember, when something is added to the rhs
% of an equation, it winds up subtraced from the lhs)
b = b - sourceb;

% package outputs
output.K=K;
output.sourceb=sourceb;
output.citations={'EKE data was provided by Yannice Faugere and Marie-Isabelle Pujol at CLS and Prof. Dudley Chelton at OSU. The EKE field will soon be published as: "DUACS DT-2018 : 25 years of reprocessed sea level altimeter products. Taburet et al, in prep. For the relationship between EKE and nephloid layers you should cite Gardner, W.D., B.E. Tucholke, M.J. Richardson, and P.E. Biscaye. Benthic storms, nepheloid layers, and linkage with upper ocean dynamics in the Western North Atlantic. Invited Review article, 2016, Marine Geology, and Wilford D. Gardner, Mary Jo Richardson, and Alexey V. Mishonov, 2018 Global assessment of benthic nepheloid layers and linkage with upper ocean dynamics. EPSL 482, 126-134.'};
