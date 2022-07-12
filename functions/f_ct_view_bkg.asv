function f_ct_view_bkg(app)



Ys = single(app.data.Y);


[Y_n, bkg_spat, bkg_temp] = f_s4_remove_mov_bkg(Ys, 2);



figure; imagesc(reshape(bkg_spat, 256, 256))
figure; plot(bkg_temp)

figure; plot(squeeze(mean(mean(Ys,1),2)))


figure; plot(V(:,4))

figure; imagesc(reshape(U(:,4), 256, 256))

tic
[U,S,V] = svds(double(reshape(app.data.Y, 256*256, [])), 6);
toc

samp1 = randsample(256*256, 1000)

Y_n2d = reshape(Y_n, 256*256, []);

samp_temp = mean(Y_n2d(samp1,:));
samp_temp = samp_temp/norm(samp_temp);

samp_spat = Y_n2d*samp_temp';
samp_spat = samp_spat/norm(samp_spat);

samp_temp2 = samp_spat'*Y_n2d;
samp_temp2 = samp_temp2/norm(samp_temp2);

samp_spat2 = Y_n2d*samp_temp2';
samp_spat2 = samp_spat2/norm(samp_spat2);


Y_n


figure; imagesc(reshape(samp_spat2,256,256))


Yin = Ys - reshape(U(:,1:2)*S(1:2,1:2)*V(:,1:2)', app.data.dims);

num_corr_px = 1;
Ys_zero = [ones(app.data.dims(1),num_corr_px,app.data.dims(3)), Yin, ones(app.data.dims(1),num_corr_px,app.data.dims(3))];
Ys_zero = [ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3)); Ys_zero; ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3))];
im_source = f_neighbor_corr(Ys_zero, num_corr_px);

figure; imagesc(im_source)
% 
% Mdl = rica(reshape(Yin, 256*256,[]),10);

1

end