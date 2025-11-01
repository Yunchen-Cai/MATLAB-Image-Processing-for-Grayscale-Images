% RUN_ME5405  Convenience launcher for both images (steps requested).
% Make sure charact1.txt and chromo.txt are in the same folder.
%
% Usage:
%   1) Place this folder anywhere (e.g., Documents/MATLAB/me5405_matlab_starter)
%   2) Copy the provided text files into the same folder:
%        - charact1.txt
%        - chromo.txt
%   3) In MATLAB, cd into this folder and run:
%        >> run_me5405
%   4) Then open 'char_pipeline.m' to set the "order" vector (step 6).

disp('=== ME5405 Starter ===');
disp('Running chromo_pipeline (Image 1)...');
chromo_pipeline;

disp('Running char_pipeline (Image 2 up to step 7)...');
char_pipeline;

disp('All done. Check the "outputs" folder for saved figures.');
