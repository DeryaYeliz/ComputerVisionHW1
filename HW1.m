%Written by Derya Yeliz ULUTAS
%24.04.2020

%step1
rgbImage = imread('SunnyLake.bmp');
imshow(rgbImage)

%step2
greyScaleImg =  mean(rgbImage,3);
imshow(uint8(greyScaleImg));
 
%step3
figure,h = histogram(greyScaleImg)

%step4
BI50 = imbinarize(greyScaleImg,50); %T=50
BI65 = imbinarize(greyScaleImg,65); %T=65
BI100 = imbinarize(greyScaleImg,100); %T=100
BI180 = imbinarize(greyScaleImg,180); %T=180
BI200 = imbinarize(greyScaleImg,200); %T=200

%step5
figure,montage({BI50,BI65,BI100,BI180,BI200},'Size', [1 5]);


%step6
[I_R, I_G, I_B] = imsplit(rgbImage);

I_R_1 = imnoise(I_R,'gaussian',0,(1/256)^2);%var:1, std:1
I_G_1 = imnoise(I_G,'gaussian',0,(1/256)^2);%var:1, std:1
I_B_1 = imnoise(I_B,'gaussian',0,(1/256)^2);%var:1, std:1

I_R_5 = imnoise(I_R,'gaussian',0,(5/256)^2);%var:1, std:5
I_G_5 = imnoise(I_G,'gaussian',0,(5/256)^2);%var:1, std:5
I_B_5 = imnoise(I_B,'gaussian',0,(5/256)^2);%var:1, std:5

I_R_10 = imnoise(I_R,'gaussian',0,(10/256)^2);%var:1, std:10
I_G_10 = imnoise(I_G,'gaussian',0,(10/256)^2);%var:1, std:10
I_B_10 = imnoise(I_B,'gaussian',0,(10/256)^2);%var:1, std:10

I_R_20 = imnoise(I_R,'gaussian',0,(20/256)^2);%var:1, std:20
I_G_20 = imnoise(I_G,'gaussian',0,(20/256)^2);%var:1, std:20
I_B_20 = imnoise(I_B,'gaussian',0,(20/256)^2);%var:1, std:20


figure,montage({I_R_1,I_G_1,I_B_1},'Size', [1 3]);
figure,montage({I_R_5,I_G_5,I_B_5},'Size', [1 3]);
figure,montage({I_R_10,I_G_10,I_B_10},'Size', [1 3]);
figure,montage({I_R_20,I_G_20,I_B_20},'Size', [1 3]);


%step7
RGB_combined_gaussian_1 = cat(3,I_R_1,I_G_1,I_B_1);
greyScaleGaussian_1 = mean(RGB_combined_gaussian_1,3);

RGB_combined_gaussian_5 = cat(3,I_R_5,I_G_5,I_B_5);
greyScaleGaussian_5 = mean(RGB_combined_gaussian_5,3);

RGB_combined_gaussian_10 = cat(3,I_R_10,I_G_10,I_B_10);
greyScaleGaussian_10 = mean(RGB_combined_gaussian_10,3);

RGB_combined_gaussian_20 = cat(3,I_R_20,I_G_20,I_B_20);
greyScaleGaussian_20 = mean(RGB_combined_gaussian_20,3);

figure,montage({uint8(RGB_combined_gaussian_1),uint8(RGB_combined_gaussian_5),uint8(RGB_combined_gaussian_10),uint8(RGB_combined_gaussian_20)},'Size', [1 4]);
figure,montage({uint8(greyScaleGaussian_1),uint8(greyScaleGaussian_5),uint8(greyScaleGaussian_10),uint8(greyScaleGaussian_20)},'Size', [2 2]);



%step8
%lowpass Gaussian Filter
greyScaleGaussianFiltered_1 = imgaussfilt(greyScaleGaussian_1,1);
greyScaleGaussianFiltered_5 = imgaussfilt(greyScaleGaussian_5,1);
greyScaleGaussianFiltered_10 = imgaussfilt(greyScaleGaussian_10,1);
greyScaleGaussianFiltered_20 = imgaussfilt(greyScaleGaussian_20,1);
figure,montage({uint8(greyScaleGaussianFiltered_1),uint8(greyScaleGaussianFiltered_5),uint8(greyScaleGaussianFiltered_10),uint8(greyScaleGaussianFiltered_20)},'Size', [2 2]);

%step9 
%highpass filter
h = fspecial('laplacian',1);
greyScaleLaplacianFiltered_1 = imfilter(greyScaleGaussian_1,h);
greyScaleLaplacianFiltered_5 = imfilter(greyScaleGaussian_5,h);
greyScaleLaplacianFiltered_10 = imfilter(greyScaleGaussian_10,h);
greyScaleLaplacianFiltered_20 = imfilter(greyScaleGaussian_20,h);
figure,montage({uint8(greyScaleLaplacianFiltered_1),uint8(greyScaleLaplacianFiltered_5),uint8(greyScaleLaplacianFiltered_10),uint8(greyScaleLaplacianFiltered_20)},'Size', [2 2]);

%step 10
rgbImage_paperSaltNoised = imread('SP_Noisy_SunnyLake.png');
[rgbImage_paperSaltNoised_R,rgbImage_paperSaltNoised_G,rgbImage_paperSaltNoised_B] = imsplit(rgbImage_paperSaltNoised);
cleanedImg_R = medfilt2(rgbImage_paperSaltNoised_R);
cleanedImg_G = medfilt2(rgbImage_paperSaltNoised_G);
cleanedImg_B = medfilt2(rgbImage_paperSaltNoised_B);
cleanedImg_RGB = cat(3,cleanedImg_R,cleanedImg_G,cleanedImg_B);
figure,montage({rgbImage_paperSaltNoised,cleanedImg_RGB},'Size', [1 2]);

