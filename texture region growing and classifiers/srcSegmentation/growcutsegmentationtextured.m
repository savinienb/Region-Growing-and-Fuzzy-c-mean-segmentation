function [ labels_image ] = growcutsegmentationtextured( im,thresh,connectivity )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%extract the textures informations
texture_im = get_texture_feature(im,2);
texture_im = normalize_texture(texture_im);

%add them to the colors images
im_textured = double(cat(3, im, texture_im(:,:,:)));

%Apply a median filter in the colors channel to minimize the
%"contamination" of colors by textures
for ch = 1:size(im_textured,3)
    im_textured(:,:,ch)=medfilt2(im_textured(:,:,ch), [21 21], 'symmetric');
end

labels_image =  growcutsegmentation(im_textured, thresh, connectivity);

end

