%% Gaussian Noise Attack
function GaussNoiseImageAttacked = noiseGauss(watermarked_image,var)
GaussNoiseImageAttacked = imnoise(watermarked_image, 'gaussian', 0.00005,var);
end