function [G, phi_corrected, freq] = freqDepGain(V,I,fs,ap)


% Find the spikes and generate r (instantenous spike rate)
nPoints = length(V);
r = zeros(nPoints,1);
[~, locs] = findpeaks(V);
spInd = locs(find(V(locs) > ap.rv.threshold));
r(spInd) = fs;


% plot(V);
% hold on; plot(spInd, V(spInd), '.r', 'MarkerSize', 20); hold off;


% compute the correlations as per eqs 10 & 11
[csr, tau] = xcorr(r, I); %get the lags as well if needed later. 
css = xcorr(I);


freq = ap.rv.frange;

N = length(csr); % length of the CSR function.

%calculate the dft for each specific frequency
for i = 1:length(freq) % loop through each target frequency
    %w = gausswin(N, freq(i));
    w = wind(freq(i),tau/fs);

    windowed_css = css.*w;% select a certain window by multiplying a gaussian window by the data window.
    windowed_csr = csr.*w;% select a certain window by multiplying a gaussian window by the data window.
    freqInd = round(freq(i)/fs*N)+1; %frequency index is the input to the goertzel function.
    CSS(i) = goertzel(windowed_css, freqInd)*2/N;%get the css dft for this specific frequency
    CSR(i) = goertzel(windowed_csr, freqInd)*2/N;%get the csr dft for this specific frequency
end

%at the end of the function, CSR and CSS contain the DFT complex coefficient for each of the
%frequencies defined in the variable freq

G = abs(CSR)./abs(CSS);
phi = atan(imag(CSR)./real(CSR));

% Find max of cross correlation function
[~,ind] = max(csr);
tdelay = (ind-nPoints)/fs;
phi_corrected = phi-freq*tdelay;
%[phi_corrected] = tunwrap(phi_corrected, pi/2);

function [w] = wind(f,tau)

w = exp((-f^2*tau.^2)/2);
w = w';
