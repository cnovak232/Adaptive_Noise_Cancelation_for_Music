function [xc] = perform_rls(x,r,lambda,p)
% RLS Adaptive Noise Cancelation Algorithm-
% Sources:
% https://ieeexplore.ieee.org/abstract/document/6016426

% Inputs
    % x - noisy signal
    % r - reference noise signal
    % lambda -
    % sigma =
    % p - filter order
% Output
    % xc - noise canceled signal

sigma = 1;
w = zeros(p,1);
r_buffer = zeros(p,1);
N = length(x);
xc = zeros(N,1);
Pn = sigma*eye(p);

for n = 1:N
    r_buffer(1) = r(n);
    
    y = w' * r_buffer;
    e = x(n) - y;
    xc(n) = e;

    %calculate weights
    gn = (Pn*r_buffer) / (lambda + (r_buffer'*Pn*r_buffer));
    Pn = (lambda^-1)*Pn - ((lambda^-1)*((gn*r_buffer')*Pn));

    w = w + (gn*e);
    
    r_buffer(end) = 0;
    r_buffer = circshift(r_buffer,1);
end