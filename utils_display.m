function utils_display(I32, ttl)
%UTILS_DISPLAY Convenience display for 32-level images (0..31).
    if nargin < 2, ttl = ''; end
    imagesc(I32, [0 31]); axis image off;
    colormap(gray(32)); colorbar; title(ttl, 'Interpreter','none');
end
