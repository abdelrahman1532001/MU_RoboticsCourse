% Define the joint angles
theta = [0, 0, 0, 0, 0, 0]; % Replace theta1 to theta6 with your specific joint angles

% Call the ABB_FK function
[PX, PY, PZ, RZ, RY, RX] = ABB_FK(theta);

% Display the results
disp('Position:');
disp(['PX: ' num2str(PX)]);
disp(['PY: ' num2str(PY)]);
disp(['PZ: ' num2str(PZ)]);
disp('Euler Angles (ZYX):');
disp(['RZ: ' num2str(RZ)]);
disp(['RY: ' num2str(RY)]);
disp(['RX: ' num2str(RX)]);
