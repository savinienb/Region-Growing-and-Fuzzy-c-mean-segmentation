function [ label_image] = fmc_region( image,number_of_regions,overlapping )

im=zeros(size(image,3),numel(image(:,:,1)));

%prepare the data
for i=1:size(image,3)
    im(i,:) = double(reshape(image(:,:,i),1,[]));
end
im=im';

[center,member]=fcm(im,number_of_regions,overlapping);


label_image=ones(size(image(:,:,1)));

%for each point find the nearest cluster
for i=1:number_of_regions
    maxmember = max(member);
    index=find(member(i,:)== maxmember);
    
    label_image(index)=uint8(i);
end


end

