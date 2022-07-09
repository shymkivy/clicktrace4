function f_ct_load_dset(app)

dset_path = app.dsetpathEditField.Value;

app.data.Y = h5read(dset_path, '/mov');

Ys = single(app.data.Y);

app.data.Y_n = f_s4_remove_mov_bkg(Ys, 1);

app.data.dims = size(Ys);
app.data.Y_components = zeros(app.data.dims(1), app.data.dims(2));

app.data.cell_list = {};

if strcmpi(app.im_sourceDropDown.Value, 'corr')
    num_corr_px = 1;
    Ys_zero = [ones(app.data.dims(1),num_corr_px,app.data.dims(3)), app.data.Y_n, ones(app.data.dims(1),num_corr_px,app.data.dims(3))];
    Ys_zero = [ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3)); Ys_zero; ones(num_corr_px, app.data.dims(2)+2*num_corr_px, app.data.dims(3))];
    app.data.im_source = f_neighbor_corr(Ys_zero, num_corr_px);

elseif strcmpi(app.im_sourceDropDown.Value, 'std')
    app.data.im_source = std(app.data.Y_n, 0, 3);
end



app.data.Y_components = zeros(app.data.dims(1), app.data.dims(2));

app.plots.im_data.CData = app.data.im_source;
app.plots.im_components.CData = app.data.Y_components;

end