% Get the current workspace directory
workspaceDir = pwd;

% Construct the full path to the 'Scripts' folder
scriptsFolder = fullfile(workspaceDir, 'Scripts');

% Check if the 'Scripts' folder exists
if exist(scriptsFolder, 'dir') == 7
    % Add the 'Scripts' folder to the MATLAB search path
    addpath(genpath(scriptsFolder));
else
    fprintf('Error: Folder %s not found.\n', scriptsFolder);
end



