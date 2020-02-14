clear
close all

noisenames=cell(30,1);

for i=31:60
    noisenames{i}=sprintf('%d_2andahalfmsNoise', i);
end

for i=31:60
    makeNoise(100000,2.5, .04, 3, noisenames{i}, 0);
    disp(i)
end