function [ label_img ] = growcutsegmentation( img, thresh, connectivity)
%GROWCUTSEGMENTATION Summary of this function goes here
%   Detailed explanation goes here

img=double(img);
label_img = zeros(size(img,1),size(img,2));
label_stats = [];

%Squaring the threshold will avoid computing sqrt in euclidean distance
thresh = thresh ^ 2;

%While there are still zeros in label_img
current_label = 0;
while( ~all(label_img(:)) )
    current_label = current_label + 1;
    
    %Find first sequential unlabeled px. in label_img
    [r, c] = find(label_img == 0, 1, 'first');
    
    %Assign it the next label
    label_img(r, c) = current_label;
    
    %Initialize statistics of the new region
    label_stats(current_label,1,:) = img(r,c,:); %Sum of intensities
    label_stats(current_label,2,:) = 1; %Number of added pixels
    label_stats(current_label,3,:) = img(r,c,:); %Actual mean of region
    
    %Initialize the queues
    next_queue = zeros(ceil(numel(img) / 4), 1);
    num_next_node = 3;
    next_queue(num_next_node : num_next_node + 1) = [r,c];
    
    while(num_next_node > 1)
        %Exchange queues
        current_queue = next_queue;
        num_current_nodes = num_next_node;
        
        %Reset next level queue
        num_next_node = 1;
        
        for n = 1:2:num_current_nodes
            %Explore valid neighbours
            pixel_r = current_queue(n);
            pixel_c = current_queue(n+1);
            
            for r = max(1, pixel_r-1) : min(pixel_r+1, size(label_img,1))
                for c = max(1, pixel_c-1) : min(pixel_c+1, size(label_img,2))
                    if connectivity == 4 && abs(pixel_c-c)+abs(pixel_r-r)>1
                        continue;
                    end
                    
                    %If pixel already labeled, skip it
                    if label_img(r,c) ~= 0
                        continue;
                    end
                    
                    %Compute distance of color to average region color
                    euclidean_distance = sum( ...
                        (label_stats(current_label,3, :) - img(r,c,:)).^2);
                    
                    if  euclidean_distance > thresh
                        continue;
                    end
                    
                    %Assign its new label
                    label_img(r,c) = current_label;
                    
                    %Recompute the statistics of the region after addition
                    label_stats(current_label,1,:) = label_stats(current_label,1,:) + img(r,c,:);
                    label_stats(current_label,2,:) = label_stats(current_label,2,:) + 1;
                    label_stats(current_label,3,:) = label_stats(current_label,1,:) ./ label_stats(current_label,2,:);
                    
                    %Add it to next_queue for future exploration of neighbours
                    next_queue(num_next_node : num_next_node + 1) = [r,c];
                    num_next_node = num_next_node + 2;
                end
            end
        end
    end
end
end

