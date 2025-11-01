% chromo_optimized_pipeline.m - Optimized processing for chromosomes
% Steps: optimized threshold -> save separate optimized binary -> skeleton -> outline -> label
% Save figures to ./outputs/
clear; clc; close all;
outdir = fullfile(pwd, 'outputs');
if ~exist(outdir, 'dir'), mkdir(outdir); end

% 1. 加载并归一化
I32 = loadTextImage('chromo.txt');
g = double(I32) / 31;

% 2. 预平滑（小内核，保留细节，Ch6）
g_smooth = medfilt2(g, [2 2]);  % 优化: 2x2 而非3x3，避免模糊脚

% 3. 反相
g_inv = 1 - g_smooth;

% 4. 背景估计（小半径，避免抹细节，Ch7）
se_large = strel('disk', 10);  % 优化: 10而非12，保留小对象
bg_inv = imopen(g_inv, se_large);

% 5. 校正 + gentler增强（Ch1，避免过曝）
g_inv_corr = g_inv - bg_inv;
g_inv_corr = imadjust(mat2gray(g_inv_corr), stretchlim(g_inv_corr, [0.01 0.99]));  % 优化: 1%-99% clip，保留细灰度

% 6. Otsu on corrected (Ch8)
level_corr = graythresh(g_inv_corr);
BW_corr = g_inv_corr > level_corr;

% 7. 后处理：无/小闭运算（避免肥大），低面积（保留脚，Ch3/Ch8）
se_small = strel('disk', 0);  % 优化: 0 (no closing) 或1 minimal
BW_corr = imclose(BW_corr, se_small);
BW_corr = bwareaopen(BW_corr, 20);  % 优化: 20而非40，保持小脚

% 加瘦化（thinning）减肥大 (Ch3 binary processing)
BW_corr = bwmorph(BW_corr, 'thin', 0.5);  % 你的自定义0.5迭代，避免过瘦

% 8. 显示并保存单独的Further Optimized图片（你的要求）
figure; imshow(BW_corr); title('Further Optimized Binary Image');
exportgraphics(gcf, fullfile(outdir, 'bw_further_optimized.png'), 'Resolution', 200);

% 9. 用BW_corr继续pipeline: skeleton, outline, label (假设utils_outline_skeleton_label可用)
[perim, skel, L, cc] = utils_outline_skeleton_label(BW_corr);  % 用优化BW作为输入

figure; imshow(skel); title('Image 1: Skeleton (one-pixel thin)');
exportgraphics(gcf, fullfile(outdir, 'img1_skeleton.png'), 'Resolution', 200);

figure; imshow(perim); title('Image 1: Outline (perimeter)');
exportgraphics(gcf, fullfile(outdir, 'img1_outline.png'), 'Resolution', 200);

RGB = label2rgb(L, 'jet', 'k', 'shuffle');
figure; imshow(RGB); title(sprintf('Image 1: Labeled objects (N=%d)', cc.NumObjects));
exportgraphics(gcf, fullfile(outdir, 'img1_labeled.png'), 'Resolution', 200);

disp('Optimized processing complete. Outputs saved in ./outputs');