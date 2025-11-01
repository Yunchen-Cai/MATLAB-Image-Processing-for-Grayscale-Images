% CHAR_PIPELINE  Process Image 2 (Characters) up to step 7.
% Steps:
%   1) display original
%   2) threshold -> binary
%   3) one-pixel thin
%   4) outlines
%   5) segment & label components
%   6) arrange characters in one line with the sequence: AB123C
%   7) rotate the result by 30 degrees about image center
%
% Save figures to ./outputs/

clear; clc; close all;
outdir = fullfile(pwd,'outputs');
if ~exist(outdir,'dir'), mkdir(outdir); end

% 1) Load & display
I32 = loadTextImage('charact1.txt');
figure; utils_display(I32, 'Image 2: Original (0..31)');
% exportgraphics(gcf, fullfile(outdir,'img2_original.png'), 'Resolution', 200);

% 2) Threshold
BW = utils_threshold(I32, 'otsu');
figure; imshow(BW); title('Image 2: Binary (Otsu)');
% exportgraphics(gcf, fullfile(outdir,'img2_binary.png'), 'Resolution', 200);

% 3) Skeleton
[perim, skel, L, cc] = utils_outline_skeleton_label(BW);
figure; imshow(skel); title('Image 2: Skeleton (one-pixel thin)');
% exportgraphics(gcf, fullfile(outdir,'img2_skeleton.png'), 'Resolution', 200);

% 4) Outlines
figure; imshow(perim); title('Image 2: Outline (perimeter)');
% exportgraphics(gcf, fullfile(outdir,'img2_outline.png'), 'Resolution', 200);

% 5) Segment & label
RGB = label2rgb(L, 'jet', 'k', 'shuffle');
figure; imshow(RGB); title(sprintf('Image 2: Labeled components (N=%d)', cc.NumObjects));
% exportgraphics(gcf, fullfile(outdir,'img2_labeled.png'), 'Resolution', 200);

% Show component indices over the binary image for manual mapping
stats = regionprops(cc, 'BoundingBox','Image','Centroid');
figure; imshow(BW); hold on;
for i = 1:numel(stats)
    bbox = stats(i).BoundingBox;
    rectangle('Position', bbox, 'EdgeColor','y', 'LineWidth',1);
    text(bbox(1), bbox(2)-3, sprintf('%d', i), 'Color','y', 'FontSize',10, ...
        'HorizontalAlignment','left', 'VerticalAlignment','bottom', 'FontWeight','bold');
end
title('Image 2: Component indices (use these indices for step 6 mapping)');
hold off;
% exportgraphics(gcf, fullfile(outdir,'img2_indices.png'), 'Resolution', 200);

% 6) Arrange in one line with sequence AB123C
% NOTE: Without a trained classifier (step 8+), we will map components to
% the required order manually by viewing 'img2_indices.png' and entering
% the indices for [A B 1 2 3 C] below. Replace the placeholders as needed.

order = [ 1 2 3 4 5 6 ]; % <-- EDIT THIS after inspecting img2_indices.png

lineImg = char_arrangeLine(stats, order, 4);
figure; imshow(lineImg); title('Image 2: Arranged line (AB123C order)');
% exportgraphics(gcf, fullfile(outdir,'img2_arranged_line.png'), 'Resolution', 200);

% 7) Rotate the output image from step 6 by 30 degrees about center
rotImg = imrotate(lineImg, 30, 'bilinear', 'loose');
figure; imshow(rotImg); title('Image 2: Arranged line rotated by 30^\circ');
% exportgraphics(gcf, fullfile(outdir,'img2_rotated_30deg.png'), 'Resolution', 200);

disp('Image 2 processing complete. Edit "order" in char_pipeline.m to match AB123C.');
