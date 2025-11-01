function G = loadTextImage(filename)
%LOADTEXTIMAGE Read 64x64, 32-graylevel text image into uint8 matrix (0..31).
%   G = LOADTEXTIMAGE(filename) reads a text file whose pixels are encoded
%   with characters '0'..'9' and 'A'..'V' (32 levels total). It returns a
%   64-by-64 uint8 matrix with values in [0,31].
%
%   Example:
%       G = loadTextImage('chromo.txt');            % -> uint8 64x64 [0..31]
%       imagesc(G); axis image off; colormap(gray(32)); colorbar;

    fid = fopen(filename,'r');
    assert(fid~=-1, 'Cannot open file: %s', filename);

    % Read a char at a time, ignoring CR/LF, and pack into 64x64 matrix.
    lf = char(10); cr = char(13);
    A = fscanf(fid, [cr lf '%c'], [64,64]);
    fclose(fid);

    A = A.';                             % column-major -> row-major
    A = uint8(A);                        % ASCII codes

    % Map letters 'A'..'V' -> 10..31
    isLetter = (A >= uint8('A')) & (A <= uint8('V'));
    A(isLetter) = A(isLetter) - uint8(55);   % 'A'(65) - 55 = 10

    % Map digits '0'..'9' -> 0..9
    isDigit = (A >= uint8('0')) & (A <= uint8('9'));
    A(isDigit) = A(isDigit) - uint8(48);     % '0'(48) -> 0

    % Any other characters (spaces/newlines) become 0 (safe-guard)
    otherMask = ~(isLetter | isDigit);
    A(otherMask) = 0;

    G = uint8(A);                        % 0..31
end
