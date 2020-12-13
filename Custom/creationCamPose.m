%% Ce script enregistre les positions de prise de vues pour être interprétées 
% par l'algo de SfS ainsi que les paramètres intrinsèques de la caméra
 


% Paramètres

nbMasks = 1;

poseCam = [5,0,2.404];
RotCamInit = [0,0,0];
f = 50;
resolution = [1080 1920];
sensor_size = [24 36];
ku = resolution(2)/sensor_size(2);
kv = resolution(1)/sensor_size(1);
Rotimages = [0,45,90,135,180,225,270,315];
K = [ku*f 0   resolution(2)/2;
     0   kv*f resolution(1)/2;
     0    0      1    ];
% Construction des matrices [R t] de positions et multiplication par K

Rinit = rotx(RotCamInit(1))*roty(RotCamInit(2))*rotz(RotCamInit(3));
P={};
P{1} = K*[Rinit poseCam'];
R_cour=Rinit;
for i = 2:nbMasks
  R_cour = Rinit*rotz(Rotimages(i));
  P{i} = K*roty(Rotimages(i))*[Rinit poseCam'];
end
save Masks/Dino_Ps P;