function [ output ] = normalize_texture( texture_feature )
%NORM_TEXT Summary of this function goes here
%   Detailed explanation goes here
output=texture_feature;

% Range = [-1 1] 
output(:,:,2)=(output(:,:,2)+1)/2;

%Range = [0 (size(GLCM,1)-1)^2] 
output(:,:,1)=output(:,:,1)/49;

output=output*255;

end

