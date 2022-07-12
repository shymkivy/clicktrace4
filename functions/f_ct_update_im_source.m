function f_ct_update_im_source(app)

if strcmpi(app.im_sourceDropDown.Value, 'corr')
    disp('Computing corr im....');
    
    num_corr_px = 1;
    Ys_zero = [ones(app.data.dims(1),num_corr_px,app.data.dims(3)), app.data.Yn, ones(app.data.dims(1),num_corr_px,app.data.dims(3))];
    Ys_zero = [ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3)); Ys_zero; ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3))];
    app.data.im_source = f_neighbor_corr(Ys_zero, num_corr_px);
    disp('Done');
elseif strcmpi(app.im_sourceDropDown.Value, 'std')
    app.data.im_source = std(app.data.Yn, 0, 3);
end

app.plots.im_data.CData = app.data.im_source;

end