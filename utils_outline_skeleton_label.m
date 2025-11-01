function [perim, skel, L, cc] = utils_outline_skeleton_label(BW)
%UTILS_OUTLINE_SKELETON_LABEL Outline, skeletonize, and label a binary mask.
%   [perim, skel, L, cc] = UTILS_OUTLINE_SKELETON_LABEL(BW)
%   perim: perimeter pixels (logical)
%   skel : one-pixel-thin skeleton (logical)
%   L    : label matrix
%   cc   : connected components struct (bwconncomp)

    perim = bwperim(BW, 8);
    skel  = bwmorph(BW, 'skel', Inf);
    cc    = bwconncomp(BW, 8);
    L     = labelmatrix(cc);
end
