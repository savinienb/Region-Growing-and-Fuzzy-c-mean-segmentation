clear all
close all

% im = imread('color.tif');
% im = imread('gantrycrane.png');
% im = imread('woman.tif');
im = imread('coins.png');

tic
labels_image1 = growcutsegmentation(im, 65, 8);
toc

imshow(label2rgb(labels_image1, 'hsv', 'c', 'shuffle'));
