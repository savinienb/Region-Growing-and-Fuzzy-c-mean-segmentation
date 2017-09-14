function v = computeFeatureVector(A, featureOpts)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

offsets = [0 1; -1 1;-1 0;-1 -1];
offsets = [offsets*1; offsets*2; offsets*3; offsets*4; offsets*5];

v = [];
for d = 1:size(A,3)
    glcm = graycomatrix(A(:,:,d), 'NumLevels', 8, 'Offset', offsets);
    v  = [v struct2array(graycoprops(glcm))];
end


