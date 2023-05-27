
%% Pend , roll, pitch, yaw = FK6dof(thetad)

function [Pe, RXYZ] = FK6dof(thetad)

if numel(thetad) ~= 6
    error('define all 6 angle');
end
% DH parameters
a      = [   0  , 45 ,  4.2  ,  0  ,   0  ,  0  ];
alphad = [ -90  , 0  ,  -90  ,  90 ,  -90 ,  0  ];
d      = [ 39.8 , 0  ,   0   ,  46 ,   0  , 8.2 ];
% Forward kinematics calculations
T = eye(4);  % Transformation matrix initialization
% Iterate through each joint
for i = 1:6
    A = [ cosd(thetad(i)) , -sind(thetad(i))*cosd(alphad(i)) ,  sind(thetad(i))*sind(alphad(i)), a(i)*cosd(thetad(i));
        sind(thetad(i)) ,  cosd(thetad(i))*cosd(alphad(i)) , -cosd(thetad(i))*sind(alphad(i)), a(i)*sind(thetad(i));
        0          ,       sind(alphad(i))            ,          cosd(alphad(i))        ,        d(i)         ;
        0          ,            0                     ,                0                ,         1           ];
    T = T * A;  % Update transformation matrix
end
% Approximate the values of the transformation matrix to 3 decimal points
T(abs(T) < 0.001) = 0;
% Extract end effector position from transformation matrix
Pe =  T(1:3,4);
% Extract rotation matrix from transformation matrix
R = T(1:3, 1:3);
% Calculate roll, pitch, and yaw angles from rotation matrix
RXYZ = solveRotationMatrix(R);

end
function RXYZ = solveRotationMatrix(R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        [cos(RY)*cos(RZ), cos(RZ)*sin(RX)*sin(RY) - cos(RX)*sin(RZ), sin(RX)*sin(RZ) + cos(RX)*cos(RZ)*sin(RY)]%
% XYZ =  [cos(RY)*sin(RZ), cos(RX)*cos(RZ) + sin(RX)*sin(RY)*sin(RZ), cos(RX)*sin(RY)*sin(RZ) - cos(RZ)*sin(RX)]%
%        [       -sin(RY),                           cos(RY)*sin(RX),                           cos(RX)*cos(RY)]%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RY = atan2d( -R(3, 1) , norm([R(1, 1),R(2, 1)]) );
if round(RY) == 90
    RZ = 0;
    RX = atan2d( R(1, 2) , R(2, 2) );
elseif round(RY) == -90
    RZ = 0;
    RX = -atan2d( R(1, 2) , R(2, 2) );
else
    RZ = atan2d( ( R(1, 2) / cosd(RY) ) , ( R(1, 1) / cosd(RY) ) );
    RX = atan2d( ( R(3, 2) / cosd(RY) ) , ( R(3, 3) / cosd(RY) ) );
end
RXYZ = [RX ; RY ; RZ];
end

