function [T,y,y_filt] = makeNoise(fs, nsec, sigma, tau, fname, pad)

% Generates a custom Axon wavefile containing gaussian white noise with
% noise variance of sigma, mean of 0, and filtered with an 'alpha' kernal

%   INPUT:
%   fs              sampling rate in samples/second - thus for example
%                   input 10000 for 10kHz - you will need to make sure then
%                   the samnpling rate in Axon is 10kHz as well, or else
%                   the filter and the time series will not be correct
%   nsec            length of the white noise sequence in seconds
%   sigma           Noise variance (aka 'amplitude' like the
%                   gain), so it will help reduce the gain you need to set
%                   in Axon.  Default is 1.
%   tau             Time constant to convolve time series with (From Galan
%                   et al 2008, and Padmanabhan 2010 they use 3ms.  If you
%                   set this to 0, then just the white noise will saved and
%                   the filtered time series.
%   fname           File name to save the white noise ABF file to- For example
%                   you can use 'White_noise.ABF'. To leave empty put [],
%                   and this will not save the ABF file.
%   pad             time in seconds to add to the start of the waveform
%                   since clampex truncates the start of the waveform file
%                   default is 0.5s
%   OUTPUT
%   T               Time in seconds
%   y               The white noise series
%                   If a filename is specificied it saves to the specificed
%                   file
%   y_filt          The filtered time series
%

%       Taufik A Valiante (2017)

if nargin < 3; tau = 0; end
if nargin < 4; sigma = 1; end
if nargin < 5; fname = []; end
if nargin < 6; pad = 0.5; end

pad_points = fs*pad;
npoints = pad_points + fs*nsec;  % Determine how many points to make the time series
y = randn(1,npoints)*sigma;
y(1:pad_points) = 0; % set the pad window to zero
y(end) = 0;  % In case the amplifier holds the cell at last value in time series
T = (1:npoints)/fs;

t = T*1000; % convert T into ms

if tau
    % Filter the time series with an alpha function
    a = (t./tau).*exp(-(t-tau)./tau);
    y_filt = conv(y,a);
    y_filt = y_filt(1:npoints);
    y_filt = y_filt/std(y_filt)*sigma; % rescale the filtered time series to give it the appropriate variance
    y_filt(end) = 0; % set the last value to zero
    
    clf; f = figure(1);
    f.Name = sprintf('Raw and Filtered waveforms with tau = %d (ms)', tau);
    subplot(2,1,1);
    plot(T, y, T, y_filt);
    title({'Time series'});
    legend({'White noise', 'Filtered'});
    xlabel('Time (s)');
    ylabel('Units');
    
    subplot(2,1,2);
    %     [ps_y, w, ~] = powerspec(y,npoints/10, fs);
    %     [ps_y_filt, ~, ~] = powerspec(y_filt,npoints/10, fs);
    %     loglog(w,ps_y, w, ps_y_filt);
    %     xlabel('Freq (Hz)');
    %     ylabel('Power');
    %     title('Power spectra');
    %     legend({'White noise', 'Filtered'});
else
    y_filt = [];
end

fnameold=fname;
if ~isempty(fname)
    str1=sprintf('%s_%d_%d.csv', fnameold, sigma, tau);
    fname = sprintf('%s_%d_%d.dat', fnameold, sigma, tau);
    fid = fopen(fname,'wt');
    %     fprintf(fid,'ATF \t 1.0\n');
    %     fprintf(fid,'1 \t 3\n');
    %     fprintf(fid,'"Comments: fs=%d"\n',fs);
    %     fprintf(fid,'"time (s)"   "amplitude (pA)"   "comment ()"\n');
    for i = 1:length(y)
        %         fprintf(fid,'%f \t %8.6f \t ""\n',T(i),y_filt(i));
        fprintf(fid, '%f \t', y_filt(i));
    end
end
fclose(fid);

csvwrite(str1, y_filt)

current=cd;
cd('/Users/scottrich/OneDrive - UHN/3) NEURON stuff/Human Cell');

if ~isempty(fname)
    str1=sprintf('%s_%d_%d.csv', fnameold, sigma, tau);
    fname = sprintf('%s_%d_%d.dat', fnameold, sigma, tau);
    fid = fopen(fname,'wt');
    %     fprintf(fid,'ATF \t 1.0\n');
    %     fprintf(fid,'1 \t 3\n');
    %     fprintf(fid,'"Comments: fs=%d"\n',fs);
    %     fprintf(fid,'"time (s)"   "amplitude (pA)"   "comment ()"\n');
    for i = 1:length(y)
        %         fprintf(fid,'%f \t %8.6f \t ""\n',T(i),y_filt(i));
        fprintf(fid, '%f \t', y_filt(i));
    end
end

fclose(fid);

csvwrite(str1, y_filt)

cd(current)



end