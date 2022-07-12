function f_ct_initialize(app)

%app.moviepathEditField.Value = 'F:\AC_data\caiman_data_dream3\movies\M124_im1_AC_tone_lick_reward1_4_11_22_mpl5_pl3.h5';
%app.moviepathEditField.Value = 'C:\Users\ys2605\Desktop\stuff\AC_data\caiman_data_dream\movies\M124_im1_AC_tone_lick_reward1_4_11_22_mpl5_pl1.h5';
app.moviepathEditField.Value = 'D:\data\caiman_data_missmatch\movies\M1_im1_A1_ammn1_10_2_18.h5';

app.savepathEditField.Value = 'D:\data\caiman_data_missmatch\test_M1_im1_A1_ammn1_10_2_18.mat';
app.plots.im_data = imagesc(app.UIAxes_data, 0);
axis(app.UIAxes_data , 'tight')
app.plots.im_data.ButtonDownFcn = @(~,~) f_ct_button_down(app);

app.plots.im_components = imagesc(app.UIAxes_components, 0);
axis(app.UIAxes_components , 'tight')

app.plots.plt_trace = plot(app.UIAxes_trace, 0);
axis(app.UIAxes_trace , 'tight')

end