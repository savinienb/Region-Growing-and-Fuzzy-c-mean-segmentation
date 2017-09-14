function [ texture_feature ] = get_texture_feature( im,distance )
%REGION_GROWING_TEXTURED Summary of this function goes here
%   Detailed explanation goes here

if size(im,3)==3
    im_bw=rgb2gray(im);
else
    im_bw=im;
end

texture_feature=zeros(size(im,1),size(im,2),4);

for r=1:size(im,1)
    for c=1:size(im,2)
        
        row_to_iterate=max((r-distance),1):min((r+distance),size(im,1));
        column_to_iterate=max((c-distance),1):min((c+distance),size(im,2));
        offsets = [0 distance; -distance distance;-distance 0;-distance -distance];
        glcm=graycomatrix(im_bw(row_to_iterate,column_to_iterate),'Offset',offsets);
        glcm_mean=mean(glcm,3);
        
        coprops=struct2array(graycoprops(uint8(glcm_mean)));
        
        coprops(isnan(coprops))=1;
        texture_feature(r,c,:)=coprops;
        
        
    end
end

% % 
% %add a the texture to the colored image
% dimension=(size(im,3)+size(texture_feature,3));
% extended_im=zeros(size(im,1),size(im,2),(size(im,3)+size(texture_feature,3)));
% extended_im(:,:,1:size(im,3))=im(:,:,:);
% extended_im(:,:,size(im,3)+1:dimension)=texture_feature(:,:,:);

end

