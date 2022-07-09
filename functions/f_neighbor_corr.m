function corr_out = f_neighbor_corr(input, num_corr_px)

% normalize
Yszn = input./vecnorm(input,2,3);

[d1, d2, ~] = size(input);

corr_out = zeros(d1-2*num_corr_px, d2-2*num_corr_px);

idx1 = -num_corr_px:num_corr_px;
m0 = reshape(repmat(idx1, num_corr_px*2+1,1),[],1);
n0 = reshape(repmat(idx1, 1, num_corr_px*2+1),[],1);
mn = [m0, n0];
mn(logical(prod(mn == 0,2)),:) = [];

for row1 = 1:size(mn,1)
    m1 = mn(row1,1);
    n1 = mn(row1,2);
    temp_corr = sum(Yszn((1+num_corr_px+m1):(end-num_corr_px+m1),(1+num_corr_px+n1):(end-num_corr_px+n1),:).*Yszn((1+num_corr_px):(end-num_corr_px),(1+num_corr_px):(end-num_corr_px),:),3);
    corr_out = corr_out + temp_corr;
    %fprintf('m=%d; n=%d\n', m1, n1);
end

% Ysc = sum(Yszn(2:end-1,2:end-1,:).*Yszn(1:end-2,2:end-1,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(3:end,2:end-1,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(2:end-1,1:end-2,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(2:end-1,3:end,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(1:end-2,1:end-2,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(1:end-2,3:end,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(3:end,1:end-2,:)+...
%       Yszn(2:end-1,2:end-1,:).*Yszn(3:end,3:end,:),3);

end