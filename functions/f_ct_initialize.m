function f_ct_initialize(app)

app.dsetpathEditField.Value = 'F:\AC_data\caiman_data_dream3\movies\M124_im1_AC_tone_lick_reward1_4_11_22_mpl5_pl3.h5';

app.plots.im_data = imagesc(app.UIAxes_data, 0);
axis(app.UIAxes_data , 'tight')
app.plots.im_data.ButtonDownFcn = @(~,~) f_ct_button_down(app);

app.plots.im_components = imagesc(app.UIAxes_components, 0);
axis(app.UIAxes_components , 'tight')

app.plots.plt_trace = plot(app.UIAxes_trace, 0);
axis(app.UIAxes_trace , 'tight')

end