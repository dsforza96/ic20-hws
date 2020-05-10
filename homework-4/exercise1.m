clear all
close all
clc

n = 4;

M = binary2RNS(0, n);

X1 = randi(M);
X2 = randi(M);

[~, x1] = binary2RNS(X1, n);
[~, x2] = binary2RNS(X2, n);

S = zeros(1, 3);

for i=1:3
    A = radix102RB(x1(i));
    B = radix102RB(x2(i));

    S(i) = RB2radix10(RBSum(A, B));
end