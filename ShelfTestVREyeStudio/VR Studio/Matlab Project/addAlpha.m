function [ hmAddAlpha ] = addAlpha( hmAdd, sizeX, sizeY, sliderTrans, sliderCut )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

hmAddAlpha = zeros(sizeX,sizeY);
maxhmAdd = max(hmAdd(:));
prag = maxhmAdd*sliderCut;
for i = 1:sizeX
    for j = 1:sizeY
        if ( hmAdd(i,j) > prag )
            hmAddAlpha(i,j) = (hmAdd(i,j)/maxhmAdd) * sliderTrans ;
        end
    end
end 
 
end

