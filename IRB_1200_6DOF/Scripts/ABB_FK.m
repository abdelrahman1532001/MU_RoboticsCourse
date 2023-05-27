function [PX, PY, PZ, RZ, RY, RX] = ABB_FK(theta)

% define all links using DH paramters
L = [   
    Link('d', 39.8, 'a',    0, 'alpha', -pi/2);...
    Link('d',    0, 'a',   45, 'alpha',     0);...
    Link('d',    0, 'a', 4.20, 'alpha', -pi/2);...
    Link('d',   46, 'a',    0, 'alpha',  pi/2);...
    Link('d',    0, 'a',    0, 'alpha', -pi/2);...
    Link('d',  8.2, 'a',    0, 'alpha',     0)...
    ];

% define my ABB robot
ABB_ROBOT = SerialLink(L,'name','ABB1200');

% find transforamtion matrix
T06 = ABB_ROBOT.fkine(theta)

% extract position from transformation matrix
% Extract the position (translation) from the transformation matrix T
Pe = round(T06.t*100)/100;
PX = Pe(1);
PY = Pe(2);
PZ = Pe(3);

% extract euler 'ZYX' from transformation matrix
Rzyx = rotm2eul(T06.R);
RZ   = rad2deg( Rzyx(1) );
RY   = rad2deg( Rzyx(2) );
RX   = rad2deg( Rzyx(3) );

end