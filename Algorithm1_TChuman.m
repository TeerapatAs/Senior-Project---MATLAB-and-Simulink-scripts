% Algorithm 1 by T.chuman

% Chosen Controller
syms p1 p2 p3 p4 s;
Gc = p1*(1 + 1/p2*s + p3*s/(1+p4*s));

% Epsilon bounding
eps_z = 200e-3; % 200 mH
eps_u1 = 0.1; % p.u.
eps_u2 = 0.05; %p.u.

% Testing Finding Impulse response
b = [4];
a = [1 2 10];
dt = 1e-3; %step size
tf = 15; % final time

[y,t] = impulse_bycode(b,a,0,dt,tf);
plot(t,y)

% By replacing our uncertainty with external output (d) We get...

% Define Ha_b that simplify our problems. While Ha_b represents transfer
% function from b to a
I_ = eye(length(u));
Hf_z = Gf_z + (Gv_z*K*(I_ - Gv_u*K)^-1)*(Gf_u);


