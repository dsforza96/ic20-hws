clear all
close all
clc

% Importing functions from the previous exercise
addpath('../exercise-3')

sizes = [50, 100, 150, 200, 250];
m = 10;  % Number of matrices on which to average results

eps = 0.01;
etimes = zeros(2, length(sizes));

% Creating a parallel pool
tic
cluster = parcluster();
pool = parpool(cluster.NumWorkers);
overhead = toc;

for i=1:length(sizes)
    n = sizes(i);
    b = ones(n, 1);

    for j=1:m
        A = generateDiagonallyDominant(n, 0.2);
        A_comp = toCompact(A);

        tic
        jacobi(A_comp, b, eps);
        etimes(1, i) = etimes(1, i) + toc;

        tic
        parallelJacobi(A_comp, b, eps);
        etimes(2, i) = etimes(2, i) + toc;
    end
end

etimes = etimes ./ m;
delete(pool);

%%

fprintf("Overhead introduced by parallelization: %f sec\n", overhead)

figure
plot(sizes, etimes .* 1000)  % Converting to milliseconds

xlabel 'Dimension (# rows)'
ylabel 'Time (ms)'
legend('Serial', 'Parallel')

