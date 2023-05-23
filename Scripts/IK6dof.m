% thetad = IK6dof(Pend, roll, pitch, yaw)
% Pend is 3x1 

function thetad = IK6dof(Pend, roll, pitch, yaw, config)
    % Position of end effector as 3x1 vector
    P06   = Pend;

    % DH parameters
    a      = [  0   ;  45  ;  4.2  ;  0  ;  0  ;  0  ];
    alphad = [ -90  ;  0   ;  -90  ;  90 ; -90 ;  0  ];
    d      = [ 39.8 ;  0   ;   0   ;  46 ;  0  ; 8.2 ];
    thetad = [  0   ;  0   ;   0   ;  0  ;  0  ;  0  ];

    % Calculate wrist center position(P0C)
    R06 = rpy2rotm(roll, pitch, yaw, 'deg');
    OC  = P06 - d(6) * R06(:, 3);
    OCx = OC(1);
    OCy = OC(2);
    OCz = OC(3);

    % Joint 1
    thetad(1) = atan2d(OCy, OCx);

    %Joint 3
    betax    =  norm([OCx, OCy])    ;
    betay    =  OCz - d(1)          ;
    D        =  norm([betax, betay]);
    a3_mod   =  norm([a(3), d(4)])  ;
    if (nargin < 4) || strcmpi(config, 'eup')

        q3i = -acosd( -( (a(2)^2 + a3_mod^2 - D^2) / (2*a(2)*a3_mod) ) ); %take negative for elpw up
    
    elseif strcmpi(config, 'edwn')

        q3i = acosd( -( (a(2)^2 + a3_mod^2 - D^2) / (2*a(2)*a3_mod) ) ); %take negative for elpw down

    elseif (~strcmpi(config, 'eup')) && (~strcmpi(config, 'edwn'))  

        error('Invalid Configuration only ''eup'' or ''edwn'' ');

    end
    thetad(3) = -(q3i + atan2d(d(4), a(3)));
    
    %Joint 2
    beta      = atan2d(betay, betax)     ;
    alphax    = a(2) + a3_mod * cosd(q3i);
    alphay    = a3_mod * sind(q3i)       ;
    alpha     = atan2d(alphay, alphax)   ;
    thetad(2) = -(beta - alpha)          ;

    % Calculate rotation matrix R03
    R03 = dh2rotm(a, alphad, d, thetad(1:3));

    % Joint 4
    R36 = R03' * R06;
    thetad(4) = atan2d(R36(2, 3), R36(1, 3));

    % Joint 5
    thetad(5) = 0;%atan2(sqrt(1 - R36(3, 3)^2), R36(3, 3));

    % Joint 6
    thetad(6) = atan2d(-R36(3, 2), R36(3, 1));


end





