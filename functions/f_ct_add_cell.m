function f_ct_add_cell(app)

cc = app.data.current_cell;

roi_r1 = reshape(cc.U*cc.S*cc.V', cc.dimsR);
idx1 = cc.mn;

app.data.cell_list = [app.data.cell_list; cc];

app.data.Y_n(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2),:) = app.data.Y_n(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2),:) - roi_r1;

if strcmpi(app.im_sourceDropDown.Value, 'corr')
    ncp = 1;
    Ys_zero = app.data.Y_n(idx1(1,1)-ncp:idx1(1,2)+ncp, idx1(2,1)-ncp:idx1(2,2)+ncp,:);
    
    Ys_zero_c = f_neighbor_corr(Ys_zero, ncp);

    app.data.im_source(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2)) = Ys_zero_c;
    
elseif strcmpi(app.im_sourceDropDown.Value, 'std')
    app.data.im_source(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2)) = std(app.data.Y_n(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2),:),0,3);
end


app.plots.im_data.CData = app.data.im_source;

app.data.Y_components(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2)) = app.data.Y_components(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2)) + reshape(cc.U, cc.dimsR(1:2));
app.plots.im_components.CData = app.data.Y_components;

end