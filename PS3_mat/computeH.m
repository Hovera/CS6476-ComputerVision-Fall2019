function H = computeH(t1, t2)

n_pair = numel(t1) / 2;
L = zeros(2 * n_pair, 9);
t1 = [t1; ones(1, n_pair)];
t2 = [t2; ones(1, n_pair)];

% Construct L using formula provided
for i = 1:n_pair
    L(i*2-1:2*i, :) = [t1(:, i)', zeros(1, 3), -1 * t2(1, i) * t1(:, i)';...
        zeros(1, 3), t1(:, i)', -1 * t2(2, i) * t1(:, i)'];
end

% Calculate eigenvectors V and eigenvalues D
[V, D] = eig(L'*L);

% Find the smallest eigenvalue in D
[~, minLoc] = min(diag(D));

% Find the eigenvector corresponding to smallest eigenvalue and construct H
H = reshape(V(:, minLoc),3, 3)';

% x = norm(H, 'fro');
% disp(x) % checked to be 1 exactly

end

