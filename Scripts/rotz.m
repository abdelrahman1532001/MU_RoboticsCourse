function R = rotz(angle, units)
    % Check if units argument is provided
    if (nargin < 2) || (strcmpi(units, 'rad'))
        units = 'rad';  % Default units is radians
    end

    % Convert the angle to radians if units is 'deg'
    if strcmpi(units, 'deg')
        % Convert the angle to radians
        angle = deg2rad(angle);
    end

    % Calculate the rotation matrix
    R = [cos(angle), -sin(angle),  0;
         sin(angle),  cos(angle),  0;
                  0,           0,  1];
end
