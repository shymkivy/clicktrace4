function f_ct_update_bkg(app)


Ys = single(app.data.Y);

if app.removemeanmeanCheckBox.Value
    [Yn, bkg_spat, bkg_temp] = f_s4_remove_mov_bkg(Ys, 2);
    app.data.mean_bkg_spat = bkg_spat;
    app.data.mean_bkg_temp = bkg_temp;
else
    Yn = Ys;
    app.data.mean_bkg_spat = [];
    app.data.mean_bkg_temp = [];
end
clear Ys;

if app.bkgcompSpinner.Value
    
    Yn2d = reshape(Yn, app.data.dims(1)*app.data.dims(2), app.data.dims(3));
    
    samp1 = randsample(app.data.dims(1)*app.data.dims(2),10000);
    Yn_samp = mean(Yn2d(samp1,:));
    
    exp1 = 1/10;
    num_it = 50;
    for n_it = num_it
        Yncc = Yn2d*Yn_samp';
        Yn_spat = sign(Yncc) .* abs(Yncc).^exp1;
        Yn_spat = Yn_spat / norm(Yn_spat);
        
        Yncc = Yn_spat'*Yn2d;
        Yn_temp = sign(Yncc) .* abs(Yncc).^exp1;
        Yn_temp = Yn_temp ./ norm(Yn_temp);
    end
    Yn_temp = Yn_spat'*Yn2d;
    
    Yn = single(Yn - reshape(Yn_spat*Yn_temp, app.data.dims));
    
    %figure; imagesc(reshape(-Yn_spat, 256, 256))
    %figure; plot(-Yn_temp)
    
%     disp('computing SVD...');
%     k = round(app.bkgcompSpinner.Value);
%     [U,S,V] = svds(double(reshape(Yn, 256*256, [])), k);
%     app.data.svd_comp.U = U;
%     app.data.svd_comp.S = S;
%     app.data.svd_comp.V = V;
%     
%     Yn = single(Yn - reshape(U*S*V', app.data.dims));
%     
%     disp('Done computing SVD');
end
app.data.Yn = Yn;

f_ct_update_im_source(app);

% 
% figure; imagesc(reshape(bkg_spat, 256, 256))
% figure; plot(bkg_temp)
% 
% figure; plot(squeeze(mean(mean(Ys,1),2)))
% 
% 
% figure; plot(V(:,4))
% 
% figure; imagesc(reshape(U(:,4), 256, 256))
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
% 
% 
% Yin = Ys - reshape(U(:,1:2)*S(1:2,1:2)*V(:,1:2)', app.data.dims);
% 
% num_corr_px = 1;
% Ys_zero = [ones(app.data.dims(1),num_corr_px,app.data.dims(3)), Yin, ones(app.data.dims(1),num_corr_px,app.data.dims(3))];
% Ys_zero = [ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3)); Ys_zero; ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3))];
% im_source = f_neighbor_corr(Ys_zero, num_corr_px);
% 
% figure; imagesc(im_source)

end