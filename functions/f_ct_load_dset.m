function f_ct_load_dset(app)

disp('Loading...');

dset_path = app.dsetpathEditField.Value;

app.data.Y = h5read(dset_path, '/mov');

Ys = single(app.data.Y);

[Y_n, bkg_spat, bkg_temp] = f_s4_remove_mov_bkg(Ys, 1);
clear Ys;
app.data.Y_n = Y_n;
% 
% figure; imagesc(reshape(bkg_spat, 256, 256))
% 
% tic
% [U,S,V] = svd(reshape(Y_n, 256*256, []), 'econ');
% toc
% 
% tic
% [U,S,V] = svds(double(reshape(app.data.Y, 256*256, [])), 6);
% toc
% 
% samp1 = randsample(256*256, 1000)
% 
% Y_n2d = reshape(Y_n, 256*256, []);
% 
% samp_temp = mean(Y_n2d(samp1,:));
% samp_temp = samp_temp/norm(samp_temp);
% 
% samp_spat = Y_n2d*samp_temp';
% samp_spat = samp_spat/norm(samp_spat);
% 
% samp_temp2 = samp_spat'*Y_n2d;
% samp_temp2 = samp_temp2/norm(samp_temp2);
% 
% samp_spat2 = Y_n2d*samp_temp2';
% samp_spat2 = samp_spat2/norm(samp_spat2);
% 
% 
% Y_n
% 
% 
% figure; imagesc(reshape(samp_spat2,256,256))

app.data.dims = size(app.data.Y_n);
app.data.Y_components = zeros(app.data.dims(1), app.data.dims(2));

app.data.cell_list = {};
app.data.A_cell = {};
app.data.trace_cell = {};
app.data.eigval_cell = {};

f_ct_update_im_source(app);

app.data.Y_components = zeros(app.data.dims(1), app.data.dims(2));
app.plots.im_components.CData = app.data.Y_components;

disp('Done loading.');

end