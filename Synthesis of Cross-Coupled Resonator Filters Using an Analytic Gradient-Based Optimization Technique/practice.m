wp = -4 : 0.001 : 4;
w0 = 1;
dw = 1;

n = 4;
U = eye(n);

Y = zeros(size(wp));
Z = zeros(size(wp));

M = [
    0,      0.8577, 0,      -0.2174;
    0,      0,      0.7856, 0;
    0,      0,      0,      0.8577;
    0,      0,      0,      0
    ];

M = M + M';
R1 = 1.0442;
R2 = 1.0442;
R = zeros(4, 4);
R(1, 1) = R1;
R(n, n) = R2;

for i = 1:numel(wp)
    wp_i = wp(i);
    A = (wp_i*U) - (j*R) + M;
    A_inv = inv(A);
    S21 = -2*(j)*sqrt(R1*R2)*A_inv(n, 1);
    S11 = 1+2*(j)*R1*A_inv(1,1);
    Y(1, i) = -20 * log10(S21);
    Z(1, i) = -20 * log10(S11);
end

hold on
xlabel("normalized frequency");
ylabel("Insertion and Return loss (dB)");

plot(wp, Y);
plot(wp, Z);
legend('S21', 'S11');
