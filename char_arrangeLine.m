function lineImg = char_arrangeLine(stats, order, gap)
%CHAR_ARRANGELINE Compose a one-line binary image from character components.
%   lineImg = CHAR_ARRANGELINE(stats, order, gap)
%   - stats: regionprops with 'Image' and 'BoundingBox'
%   - order: vector of indices into stats specifying the desired order
%   - gap:   number of background columns between characters
%
%   Returns a binary image lineImg with characters placed left-to-right.

    if nargin < 3, gap = 4; end
    n = numel(order);
    if n == 0, lineImg = []; return; end

    H = 0; Wsum = 0;
    glyphs = cell(1,n);
    for i = 1:n
        g = stats(order(i)).Image;     % logical
        g = logical(g);
        glyphs{i} = g;
        [h,w] = size(g);
        H = max(H, h);
        Wsum = Wsum + w;
    end

    canvasW = Wsum + gap*(n-1);
    lineImg = false(H, canvasW);

    x = 1;
    for i = 1:n
        g = glyphs{i};
        [h,w] = size(g);
        yoff = floor((H - h)/2) + 1;   % vertical centering
        lineImg(yoff:yoff+h-1, x:x+w-1) = g;
        x = x + w + gap;
    end
end
