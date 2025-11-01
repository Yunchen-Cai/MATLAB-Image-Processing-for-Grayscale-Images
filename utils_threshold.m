function BW = utils_threshold(I32, method)
%UTILS_THRESHOLD Threshold a 32-level image into a binary mask.
%   BW = UTILS_THRESHOLD(I32, method) converts uint8 [0..31] to double [0..1],
%   then uses Otsu by default or 'manual', 'adaptive' methods.
%
%   Methods:
%     'otsu'    -> imbinarize with global Otsu
%     'manual'  -> use a fixed level in [0,31] (edit t32 below)
%     'adaptive'-> adaptthresh (Image Processing Toolbox)
%
%   The function auto-inverts so that foreground (objects) are 1, background 0.

    if nargin < 2, method = 'otsu'; end
    g = double(I32)/31;  % normalize

    switch lower(method)
        case 'otsu'
            level = graythresh(g);
            BW = imbinarize(g, level);
        case 'manual'
            t32 = 20;                % <-- adjust if needed (0..31)
            BW = g > (t32/31);
        case 'adaptive'
            T = adaptthresh(g, 0.45); % sensitivity can be tuned
            BW = imbinarize(g, T);
        otherwise
            error('Unknown method: %s', method);
    end

    % Auto-invert if >50% pixels are foreground (likely inverted)
    if nnz(BW) > numel(BW)/2
        BW = ~BW;
    end

    % Clean small specks and fill small holes
    BW = bwareaopen(BW, 10);
    BW = imfill(BW, 'holes');
end
