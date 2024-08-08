holo = imread('holo_00001.png');
M = 50;
deltax = 0.000345;
w = 532*10^-8;
z = 0.7;
deltaf = 1/M/deltax;
r = 1:M;
c = 1:M;
[C, R] = meshgrid(c, r);
A0 = fftshift(ifft2(fftshift(holo)));
p = exp(-2i*pi*z.*((1/w)^2-((R-M/2- 1).*deltaf).^2-...
((C-M/2-1).*deltaf).^2).^0.5);
Az = A0.*p;
EO = fftshift(fft2(fftshift(Az)));

AV = 4*(min(min(abs(EO)))+max(max(abs(EO))));
IH = (EO+AV).*conj(EO+AV);
figure; imshow(I);
title("Original object")
axis off
figure; imshow(mat2gray(IH));
title("Hologram")
axis off
SP=abs(fftshift(ifft2(fftshift(IH))));
figure; imshow(500.*mat2gray(SP));
title("Hologram spectrum")
axis off

A1 = fftshift(ifft2(fftshift(IH)));
Az1 = A1.*conj(p);
EI = fftshift(fft2(fftshift(Az1)));
EI = mat2gray(EI.*conj(EI));
figure; imshow(EI);
title("Reconstructed image")
axis off