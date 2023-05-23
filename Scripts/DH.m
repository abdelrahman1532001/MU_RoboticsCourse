function [A] = DH(a, alpha, d, theta, unit)
    % Calculate rotation matrix using DH parameters
 
    if nargin < 5
        unit = 'rad';
    elseif strcmpi(unit, 'deg')
        theta = deg2rad(theta);
        alpha = deg2rad(alpha);
    elseif ~strcmpi(unit, 'rad') && ~strcmpi(unit, 'deg')
        error('invalid unit');
    end
    % Calculate the transformation matrix for the i-th joint
    A = [ cos(theta) , -sin(theta) * cos(alpha) ,  sin(theta) * sin(alpha) , a * cos(theta) ;...
          sin(theta) ,  cos(theta) * cos(alpha) , -cos(theta) * sin(alpha) , a * sin(theta) ;...
                   0 ,               sin(alpha) ,               cos(alpha) ,              d ;...
                   0 ,                        0 ,                        0 ,              1 ];

    
end