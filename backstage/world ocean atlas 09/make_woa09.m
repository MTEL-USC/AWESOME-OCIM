% datasets originally from the 2009 world ocean atlas, then gridded to the
% OCIM grid by Tom Weber; here I'm just re-naming the variables

load woa09_ann

WOAPO4 = po4obs;
WOANO3 = no3obs;
WOASI = siobs;
WOATEMP = tempobs;
WOASAL = saltobs;
WOAO2 = o2obs;

save WOAPO4.mat WOAPO4
save WOANO3.mat WOANO3
save WOASI.mat WOASI
save WOATEMP.mat WOATEMP
save WOASAL.mat WOASAL
save WOAO2.mat WOAO2
