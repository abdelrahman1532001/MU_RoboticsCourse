function R = rpy2rotm(roll, pitch, yaw, type)
    
    if ( nargin < 4 ) || ( strcmpi(type, 'rad'))
        % if rad convert to deg
        roll  = rad2deg(roll) ;
        pitch = rad2deg(pitch);
        yaw   = rad2deg(yaw)  ;

    elseif (strcmpi(type, 'deg'))
          % if deg do nothing

    elseif ~strcmpi(type, 'deg') && ~strcmpi(type, 'rad') 
        % if neither deg nor rad error.
        error('Invalid input. Neither ''rad'' nor ''deg'' .' );

    end

    % Calculate rotation matrix from roll pitch yaw angles
    R_roll  = [ 1 ,    0       ,     0       ;
                0 , cosd(roll) , -sind(roll) ;
                0 , sind(roll) ,  cosd(roll) ];

    R_pitch = [ cosd(pitch) , 0 , sind(pitch) ;
                    0       , 1 ,     0       ;
               -sind(pitch) , 0 , cosd(pitch) ];

    R_yaw  = [ cosd(yaw) , -sind(yaw) , 0 ;
               sind(yaw) ,  cosd(yaw) , 0 ;
                   0     ,      0     , 1 ];

    R = R_roll * R_pitch * R_yaw;

   % R(abs(R) < 0.1) = 0;
end