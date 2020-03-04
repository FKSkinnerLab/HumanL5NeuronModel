function [ap] = sl_sync_params()
% ---- Directory information
ap.Dir = 'D:\Projects\Data\Human Recordings\Selected recordings for theta-gamma analysis\Set up 2\';
ap.ExportDir = [];
ap.fname = '11922007';
ap.comment = {};

% ---- Condition infomation
% For fname it is explicitly assumed that the files for the different
% conditons exist in the same directory

ap.cond.fname = {};     % Filenames for the various conditons
ap.cond.names = {};     % Names of the various conditions
ap.cond.times = [];     % Times of the various conditons
ap.chlabels = {};


% ---- Channel information
ap.ch = 1;              % Channel to analyze

% Important that this is an integer divider of the original sampling rate
ap.resample = false;
ap.srate = 2500;        % Sampling rate to decimate data to

% Factor by which to oversample the data - thus is ap.srate = 5000, the low
% pass filter will be set to 1000;
ap.over_sample = 5;     


% Data source
ap.load_mat = 1;

% Preprocessing
ap.prep_all = 1;                % Preprocess all the files in the spreadsheet, otherwise just those with GroupInc = 'yes';

% ---- Filtering
ap.notches = [60];        % Principal frequncies for notch filtering
ap.notch = 0;                   % Do notch (1) or not (0)
ap.nharm = 5;                   % Number of harmonics to use for notch filtering
ap.bstop = 2;                   % Notch width in Hz

ap.filter.ftype = 'firnotch';
ap.iirnotch.order = 10;
ap.iirnotch.ftype = 'butter';
ap.firnotch.order = 1000;

ap.notch_ch_list = [1 0];

% ---- Power spectrum parametrs
ap.ps.nslep = 2.5;                % Number of slepian tapers for computing power spectrum
ap.ps.yaxis = [];      % Range for power spectra
ap.ps.norm_yaxis = [1e-1 1e4];  % Range for normaalized yaxis
ap.ps.window = [];              % Number of points over which to compute PS
ap.ps.usemt = 1;                % USe multitaper - should leave at 1
ap.ps.group.normyaxis = [0.25 500];    % Y axis to plot normalized PS
ap.ps.group.yaxis = [1e-10 1]; 

% ---- Extracellular intracellular analyses
ap.icchan = 1;                  % Intracellular channel
ap.ecchan = 2;                  % Extracellular channel

% ---- Time frequency options
ap.wt.ostart = 1;
ap.wt.noctaves = 8;
ap.wt.nvoices = 4;
ap.wt.scale = 'log';
ap.wt.freqs = [1 1.5 2.4414 2.9033 3.4527 4.1059 4.8828 5.8067 6.9053 8.2119 9.7656 11.6134 13.8107...
    16.4238   19.5313   23.2267   27.6214   32.8475   39.0625   46.4534   55.2427   65.6950   78.1250   92.9068...
     110.4854  131.3901  156.2500 200];

ap.wt.wnumber = 5;
ap.wnumber = 5;

ap.wt.plot_resample = 100;

% ---- Frequncy bands
ap.fb.names = {'delta', 'theta', 'alpha', 'beta', 'low-gamma', 'high-gamma'};
ap.fb.ranges = [[1 3]' [4 8]' [9 14]' [15 30]', [30 60]' [60 180]'];

ap.fb.sm_span = 4000;        % Span over which to smooth data
ap.fb.sm_method = 'loess';  % Smothing method
ap.fb.corr_window = 1000;   % Window over which to compute frequency correlations
ap.fb.yaxis = [-3 5];       % For plotting


ap.fb.mi.limit = 4;         % The minmal ratio between high frequencies and low frequency to use
ap.fb.mi.span = 1000;       % In ms
ap.fb.mi.overlap = 0;       % Percentage overlap
ap.fb.mi.dop = 0;           %  Do statistical analyses
ap.fb.mi.nsurr = 200;       % Number of surrogates
ap.fb.mi.nbins = 6;         % Number of phase bins to do mi calculation
ap.fb.mi.yaxis = [0 1e-2];  % For plotting
ap.fb.mi.sm_span = 4;  % For plotting

% Flags for doing the various analyses
ap.fb.do_corr = 0;          % Do the power correlation analyses?
ap.fb.do_mi = 1;            % Do MI analyses?


% ---- Special fields
ap.sf.names = {'Comment', 'ExportDir', 'Tags', 'GroupInc'};
ap.sf.vals = {};


%% Significance testing
ap.alpha = 0.01;
ap.fdr_stringent = 1;
%% Surrogate analysis
ap.nsurrch = 12;  % Number of surrogate channels
ap.nsurr = 200; % Number of surrogates to run
ap.surr = 0;
ap.scramble_phase = 0;
ap.surr2ndcond = 0;

% take abs of IC
ap.absic = 1;
ap.abs_all = 1;

ap.sync_freq_surr = 'time_shift';  % 'time_shift', or 'rand_pairs'
ap.nsurrch = 12; % Number of surrogate channels to generate 'rand_pairs'

%Mnorm parameters
ap.mnorm.highf = [125 165];
ap.mnorm.lowf = [6 8];

%Window for sync-power correlations
ap.window = 500;

% Window size for LOOM of calculating variances for continuous data, also
% used in the 2 channel sig testing utilizing K-S
ap.loom_compute = 0;
ap.loom_window = 5000;

% For n:m phase locking of two signals
ap.nmpl.lowf = [6 10];
ap.nmpl.highf = [125 165];
ap.nmpl.n = 1:10;
ap.nmpl.m = 1:0.5:30;


% Minmum frequency range over which to consider significance (Hz)
ap.minr = 40;



%% FPC - Instantaneous frequency and power relationship
ap.fpc.revrel = 0; % Shift the relationship to follow_amp and IEI
ap.fpc.amprange = [0 30];
ap.fpc.intrange = [0 20];


%% PLOTTING
ap.pl.show_axes = 1;
ap.pl.colorbar = 1;
ap.pl.ranges = 1;
ap.pl.zeroline = 1;
ap.yaxis = [0 0.6];
ap.plotsync = 0;
ap.pl.axis = 'linear';

ap.pl.textprop = {'FontName', 'FontSize', 'TickDir'};
ap.pl.textpropval = {'Times', 7, 'out'};

ap.pl.axprop = {'TickDir'};
ap.pl.axpropval = {'out'};

% High pass filtering for display
ap.disp_filter.on = 1;  % Turn on the filer
ap.disp_filter.Fc = 4;  % Hz
ap.disp_filter.order = 1000;  % Order of the filter

% for displaying raw data traces
ap.raw.yaxis_range = [];
ap.raw.xaxis_link = 0;



%% Low freq phase-high freq envelope histograms

ap.mi.nbins = 12;
ap.mi.dosym = 0;
ap.mi.pointstoplot = 2000;
ap.mi.caxis = [];
ap.mi.lfrange = 4:30;
ap.mi.hfrange = 30:5:200;
ap.mi.nsurr = 200;
ap.mi.alpha = 0.01;

%% 2 freq PPC
ap.tfppc.window = 1000;

%% Ripple detection
ap.rip.sd = 2;
ap.rip.mindist = 250;
ap.rip.hfreq = 'high-gamma';
ap.rip.lfreq = 'theta';
ap.rip.cond = 'K+C';
ap.rip.taxis = [163.5 166.5];
ap.rip.wnumber = 20;
ap.rip.bins = 30;
ap.rip.wt_amp = true;  % Use wavelet amplitude (which is the power of the ripple) or envelope = Height of the ripple
ap.rip.use_power = false;

%% EMD
ap.emd.qResol = 50;
ap.emd.qResid = 50;
ap.emd.qAlfa = 1;
ap.emd.Nstd = 0.2;
ap.emd.NE = 100;

% Spectrogram
ap.spec.ncycles = 3;

% '11922007'
%ap.spec.markers = [];
%ap.spec.markers =[337.6994  338.3055];
%ap.spec.markers = [336 340];
%ap.spec.trange = [325 345];
%ap.spec.trange = [337.6994  338.3055];
%ap.spec.trange = [338 339];
%ap.spec.dec = 1;

% '11922007'
ap.spec.markers = [];
ap.spec.trange = [];
ap.spec.dec = 1;
ap.spec.zcaxis = [0 8];

% Glissandi
% '11n17031', '11n17016', '11n17014', '11922007'

%------ SYNC ------------------%
ap.sync.ncycle = 10;
ap.sync.dec = 100;
ap.sync.markers = [];
ap.sync.trange = [];

%-----------I/O--------------------%
ap.io.minpeakheight = 0;
ap.io.yaxis = [-210 120];
ap.io.ch_to_analyze = 1;
ap.io.minspikes = 3;
ap.io.maxT = 765; % in ms
ap.io.spikewindowtime = 5;
ap.io.firstspikestodisp = 3;
ap.io.spike_threshold = 5000; % factor increase in rate of rise that signals start of spike

ap.io.sstate_dur = 200;
ap.io.features = {'maxRise', 'maxFall', 'ahp', 'w', 'amp', 'peak'};
ap.io.alpha = 0.05;
ap.io.normalize = 0; % Normalization of the features: 1- within epoch, 2- within celll
ap.io.min_isi = 3;

ap.io.nudge = 10; % Nudge the start of the pulse due to measurement jitter
ap.io.fit_dur = 50;

% LV
ap.io.lv_minisi = 2;
ap.io.lv_min_n_toplot = 5;

ap.io.Ih_delta = 20;
ap.io.Ih_threshold_peak = 1;
ap.io_Ih_threshold_n = 3;
ap.io_Ih_minpointstofit = 3;
ap.io.Ih_pulsestop = 1;
%ap.io.features_axes = []

% % Lihua Protocol
% ap.io.pulsestart = 65;
% ap.io.pulsedur = 500;
% ap.io.pampstart = -150;
% ap.io.pampstep = 10;

%Homeira
ap.io.pulsestart = 160;
ap.io.pulsedur = 600;
ap.io.pampstart = -400;
ap.io.pampstep = 50;

% % %Lihua
% ap.io.pulsestart = 65;
% ap.io.pulsedur = 500;
% ap.io.pampstart = -100;
% ap.io.pampstep = 25;

% % %2/3
% ap.io.pulsestart = 97;
% ap.io.pulsedur = 500;
% ap.io.pampstart = -200;
% ap.io.pampstep = 50;

% Plotting
ap.io.isi_axis = [0 15 0 100];
ap.io.lv_axis = [0 11 0 0.6];
ap.io.Ih_yaxis = [-130 -50 0 10];

% Time resolved PAC
ap.trpac.ncycles = 10; % Number of cycles of low freq to average over
ap.trpac.nsurr = 1000;
ap.trpac.ftol = 1; % Number of Hz around the mean freq to use for obtain LF power
ap.trpac.alpha = 0.05;
ap.trpac.stringent = true;
ap.trpac.ylim = [0 1.05];
ap.trpac.hfrange = [60 300];
ap.trpac.lfrange = [4 11];
ap.trpac.ps_lfrange = 30;
ap.trpac.window = 1;
ap.trpac.permstats_nsurr = 1000;
ap.trpac.fz_norm = 0;
ap.trpac.zscore = 0;
ap.trpac.wt_lfrange = 4:30;
ap.trpac.wt_bw = 5;
ap.trpac.pdmi_bins = 12;
ap.trpac.pdmi_nsurr = 0;

%---------------  PDPC ------------------------------%
ap.pdpc.freqs = [1:30];
ap.pdpc.wn = 5;
ap.pdpc.nbins = 24;

%% PPC: Phase power correaltion
ap.ppc.nbins = 24;
ap.ppc.fremove = 0;
ap.ppc.threshold = 0;
ap.ppc.binrange = [-pi/3 pi/3];
ap.wind_length = 100; % in ms
ap.plags = -100:100; % in ms
ap.ppc.window = 1000;
% Do the PPC calculation using the envelope range specified in 'ap.frange' with
% the LFP in the same channel over the range specified in 'ap.freqs'
ap.ppc.envlfp = 0;  

%% ZAP function
ap.zap.tfactor = 2;
ap.zap.i_amp = 1;
ap.zap.threshold = 0;
ap.zap.frange = [0 20];
ap.zap.interp_w = 1:0.05:20;
ap.zap.use_spiking = false;
ap.zap.tstart = 0.5;
ap.zap.tend = 20;
ap.zap.ylim = [0.5 1.1];
ap.zap.min_trials = 5;

%% Seizure stuff
ap.sz.high_pass = 0;  % High pass in Hz
ap.sz.high_pass_order = 10000;
ap.sz.line_length_win = 1000;
ap.sz_freq_plot = [1 500];
ap.sz_alpha = 0.05;
ap.sz_pspec_win = 0.5; % Number of seconds to use for power spec estimation
ap.sz_decim = 50;
ap.sz_plot_in_points = 0;

% Event detection stuff
ap.ev_prefix = 0;    % seconds
ap.ev_suffix = 0.2;   % seconds
ap.ev_smooth = 101;

ap.ev_minpeakdist = 0.001;  %Seconds
ap.ev_thresh = 0.001; 
ap.ev_plength = 200;
ap.ev_inc = 1;
ap.ev_nstd = 3;

ap.ev_baseline = 0.2;   % Baseline  calculation
ap.ev_dur = 1;          % Fixed duration for event area calculation
%ap.ev_yaxis = [-1.5 0.5]; % For plotting in mV 
ap.ev_yaxis = []; % For plotting in mV 

%% Response variability

ap.rv.window = 1;           % Time window for binning spikes
ap.rv.prefix = 0.0467;      % length of time in seconds before the noise starts
ap.rv.length = 2.5;         % legnth of noise sequence in seconds
ap.rv.currentLengh = 0.3;   % Length of time over which to compute DC current level
ap.rv.threshold = -10;       % Threshold for finding spikes
% ap.rv.threshold = -15;       % Threshold for finding spikes
ap.rv.spikeWidth = 2;       % width of the spike
ap.rv.delta = 3;            % delta as per Galan for performing spike train correlations
ap.rv.minSpikeRate = 1;     % Minumum spike rate in Hz.  If lower than this abort analyses
ap.rv.STAwindow = 30;       % Time window to keep for STA
ap.rv.frange = [1:0.2:30 30:200];        % Range of frequencies to compute frequency dependent gain
ap.rv.frange_gpu = [1:0.2:30 30:200];
ap.rv.computeGain = true;  % Toggle to computaiton to save time
ap.rv.f = [0 1 1 1 1 0];    % Filter to convolve traces to remove spurious peaks
ap.rv.dimRed = 'pca';      % Dimentioanlity reduction technique 'pca' or 'tsne'

ap.rv.tsne.Perplexity = 100;         % tsne perplexity
ap.rv.tsne.Distance = 'seuclidean' ;    % tsne Distance
ap.rv.tsne.Exaggeration = 1 ;     % tsne Distance
ap.rv.tsne.NumPCAComponents = 0 ;     % PCA before tSNE




ap.rv.fdg.xlim = [1 1000];    % ylim for plotting results of frequency depedent gain
ap.rv.fdg.gylim = [0 1.5];  % YLIM FOR gain plotting
ap.rv.fdg.pylim = [-5 1];   % ylim for phase plotting
ap.rv.cType = 'spear';        % Type of spike train correlation to compute (dot = Galan, 'spear' = Spearmann)



%% Pairwise correlations

ap.pwc.alpha = 0.05;            % Alpha value for corrections
ap.pwc.Iterations = 10000;      % Number of iterations for corrections
ap.pwc.nCells = 10;             % Maximum number of cells to compute probability distributions over (ie if 100 cells, then create maxCells words)
ap.pwc.maxCombinations = 10;    % If there are more cells than maxCells then maxCombinations of 
ap.pwc.doCombinations = true;   % If there are more cells than maxCells then maxCombinations of 










