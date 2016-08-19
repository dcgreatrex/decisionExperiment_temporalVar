function trialTexture(Pointers, colour)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try     
    rect = [Pointers.coordinates(1) - 10, ... % draw a rectangle with stated diameter, mid point is centered at 1/4 height.
           (Pointers.coordinates(2) - 10), ...
            Pointers.coordinates(1) + 10, ...
            Pointers.coordinates(2) + 10];

    % draw semi circle and fill with colour
    Screen('FillOval', Pointers.w, colour, [rect]);
    referent = 1;

catch ME
    rethrow(ME);
end
%------------------------------------------