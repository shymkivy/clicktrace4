function f_ct_button_down(app)
roi_half_size = 7;

% get coordinates of mouse click and type of click
info = get(app.plots.im_data);
coord = round(info.Parent.CurrentPoint(1,1:2));
%indx_current =  sub2ind(app.data.dims(1:2)', coord(2), coord(1));

mr = round(coord(2));
nr = round(coord(1)); 
% idx1[m1, m2, n1, n2]
idx1 = [(mr-roi_half_size), (mr+roi_half_size); (nr-roi_half_size), (nr+roi_half_size)];

% get mean trace and roi
roi1 = app.data.Y(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2),:);
trace1 = squeeze(mean(mean(roi1,1),2));
trace1 = trace1 - mean(trace1);

roi1n = app.data.Yn(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2),:);
[dr1, dr2, Tr] = size(roi1n);
roi1n2d = reshape(roi1n, dr1*dr2, Tr);

% get svd version
%U*S*V'
[U,S,V] = svd(roi1n2d,'econ');

if mean(U(:,1)) < 0
    U1 = -U(:,1);
    V1 = -V(:,1);
else
    U1 = U(:,1);
    V1 = V(:,1);
end
%data_1d = U(:,1)*S(1,1)*V(:,1)';
%spat1 = reshape(U(:,1)*S(1,1)*mean(V(:,1)),dr1, dr2);
spat1 = reshape(U1,dr1, dr2);
%trace1n = mean(U(:,1))*S(1,1)*V(:,1);
trace1n = V1*S(1,1);
% if mean(spat1(:)) < 0
%     spat1 = -spat1;
% end

fprintf('Mean trace = %.5f; mean spac = %.5f; eig = %.5f\n', mean(V(:,1)), mean(U(:,1)), S(1,1))

% if mean(mean(spat1(:,[1, round(2*roi_half_size+1)]))) < 0
%     spat1 = spat1 * -1;
% end

if ~isfield(app.plots, 'fig_roi') || ~isgraphics(app.plots.fig_roi)
    app.plots.fig_roi = figure;
    app.plots.fig_roi_im = imagesc(0);
    axis(app.plots.fig_roi_im.Parent, 'equal');
    axis(app.plots.fig_roi_im.Parent, 'tight');
end
app.plots.fig_roi_im.CData = spat1;

app.plots.plt_trace.YData = trace1n;

pos1 = [idx1(2,1), idx1(1,1), roi_half_size*2, roi_half_size*2];
if ~isfield(app.plots, 'rect1')
    app.plots.rect1 = rectangle(app.UIAxes_data, 'Position', pos1);
else
    app.plots.rect1.Position = pos1;
    %delete(app.plots.rect1)
end

A_slice = zeros(app.data.dims(1), app.data.dims(2));
A_slice(idx1(1,1):idx1(1,2), idx1(2,1):idx1(2,2)) = spat1;

app.data.current_cell.A_slice = A_slice;
app.data.current_cell.mn = idx1;
app.data.current_cell.roin = roi1n;
app.data.current_cell.U = U1;
app.data.current_cell.S = S(1,1);
app.data.current_cell.V = V1;
app.data.current_cell.dimsR = [dr1, dr2, Tr];

end
