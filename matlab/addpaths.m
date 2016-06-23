%% addpaths.m
% Script to add relevant paths to the present working directory
% Paths added in this script:
%    /usr/local/fmrib/fmt/
%    /usr/local/fsl/etc/matlab
%    ~steve/NETWORKS/FSLNets
%    ~steve/NETWORKS/FSLNetsPredict 
%    ~steve/matlab/glmnet
%    ~steve/matlab/FastICA_25
%
% See also steveOriginalReadme
fprintf('Loading relevant paths... ');

% fMRIB functios
addpath('/usr/local/fmrib/fmt/');
addpath('/opt/fmrib/fsl/etc/matlab/');
addpath('/home/fs0/steve/NETWORKS/FSLNets/');
addpath('/home/fs0/steve/NETWORKS/FSLNetsPredict/');
addpath('/home/fs0/steve/matlab/glmnet/');
addpath('/home/fs0/steve/matlab/FastICA_25/');

fprintf('OK!\n');
