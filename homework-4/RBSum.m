function S = RBSum(A, B)

Tn = [0 0 1 1
      1 1 0 0
      1 1 0 0
      0 0 1 1];

Tr = [0 0 0 0
      0 0 1 1
      0 0 1 1
      1 1 1 1];

n = max(size(A, 2), size(B, 2));
U = zeros(2, n);
L = zeros(2, n);

U(:, 1:size(A, 2)) = A;
L(:, 1:size(B, 2)) = B;

for k=1:2
    Un = zeros(1, n);
    Ur = U(1, :);

    Ln = zeros(1, n + 1);
    Lr = zeros(1, n);

    for i=1:n
        u = bi2de(U(:, i)') + 1;
        l = bi2de(L(:, i)') + 1;

        Lr(i) = Tn(l, u);
        Ln(i + 1) = Tr(l, u);
    end

    U = [Un; Ur];
    L = [Ln(1:n); Lr];
end

S = L;

end