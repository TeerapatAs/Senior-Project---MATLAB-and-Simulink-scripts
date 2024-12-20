%p = [1.76e-3;0.138;11.40;72.60]; PID
%p1 = p(1); p2 = p(2); p3 = p(3); p4 = p(4);
%% 
p = [1.84;13.1];
p1 = p(1); p2 = p(2);
Kp = 120.00; % Kp = 120.00 Hz/pu
Tp = 20.00; %Tp = 20.00 s
Kr = 0.50; %High pressure turbine fraction, Kr = 0.50
Tr = 10.00; %Reheat time constant, Tr = 10.00 s
Tg = 0.08;
Tt = 0.30;
R = 2.40; %Self regulation of the governor, R = 2.40 Hz/pu
%% 
%{
% Input 1----------------
% Triangle wave have period of 20 second. Slope = 1.5e-2
y = [0];
t = [0];


% Step 1: Triangle: slope 1.5e-3 Start 0:120------------------
% Triangle Slope up Start 0:20--------
for t1 = 1e-2:1e-2:20
    t = [t ; t1];
    y1 = 1.5e-3*t1;
    y = [y ;y1];
end
y_end1 = y(end); %y after loop t1 end
t_end1 = t(end);
% Triangle: Slope Down Start 20:60--------
for t2 = 1e-2:1e-2:40
    t = [t ; t_end1 + t2];
    y2 = -1.5e-3*t2 + y_end1;
    y = [y ;y2];
end
y_end2 = y(end); %y after loop t2 end
t_end2 = t(end);
% Triangle: Slope Up Start 60:100--------
for t3 = 1e-2:1e-2:40
    t = [t ; t_end2 + t3];
    y3 = 1.5e-3*t3 + y_end2;
    y = [y ;y3];
end
y_end3 = y(end); %y after loop t3 end
t_end3= t(end);
% Triangle: Slope Down Start 100:120--------
for t4 = 1e-2:1e-2:20
    t = [t ; t_end3 + t4];
    y3 = -1.5e-3*t4 + y_end3;
    y = [y ;y3];
end
%y_end = y(end); %y after loop t3 end
t_end= t(end);

% Step 2: Sine:slope 1.2e-3 ,Start 120:180--------------
A = 0.04; %Amplitude
w = 0.03; %freq (rad/s)
for t1 = 1e-2:1e-2:60
    t = [t ; t_end+t1];
    y1 = A*sin(w*t1);
    y = [y ;y1];
end
y_end1 = y(end); %y after loop t1 end
t_end1 = t(end);

% Step 2: Ramp up: slope = (1.57e-3)/2 ,Start 180:195--------------
slope = (1.57e-3)/2;
for t2 = 1e-2:1e-2:15
    t = [t ; t_end1+t2];
    y1 = y_end1 + slope*t2;
    if y1 >= 0.05
        y1 = 0.05
    end
    y = [y ;y1];
end
t_end = t(end);
% Bound to 0.05 until 300 s
for t1 = 1e-2:1e-2:300-t_end
    t = [t ; t_end+t1];
    y1 = 0.05;
    y = [y ;y1];
end
y_end = y(end);
t_end = t(end);
% Ramp down : slope = -(1.57e-3)/2 , Start 300:430
slope = -(1.57e-3)/2;
for t1 = 1e-2:1e-2:430-t_end
    t = [t ; t_end+t1];
    y1 = y_end + slope*t1;
    if y1 <= -0.05
        y1 = -0.05
    end
    y = [y ;y1];
end
t_end = t(end);
% Bound to 0.05 until 500 s
for t1 = 1e-2:1e-2:(500-t_end)
    t = [t ; t_end+t1];
    y1 = -0.05;
    y = [y ;y1];
end
y_end = y(end);
t_end = t(end);
% Ramp back to 0 :slope = (1.5e-3), Start 500:550
slope = (1.5e-3);
for t1 = 1e-2:1e-2:35
    y1 = y_end + slope*t1;
    if y1 >= 0
        break
    end
    t = [t ; t_end+t1];
    y = [y ;y1];
end
y_end = y(end);
t_end = t(end);

% Step 3: Sawtooth: slope 1.538e-3 Start 533.33:637.33------------------
slope = 1.538e-3;
a = 1; % a = 1-> slope up, a = -1 -> slope down;
t0 = t_end;
y0 = y_end;
for t1 = 1e-2:1e-2:(637.33-t_end)
    y1 = y0 + a*slope*1e-2;
    if y1 >= 0.02
        a = -a;
        y1 = y0 + a*slope*1e-2;
    elseif y1 <= 0.00
        a = -a;
        y1 = y0 + a*slope*1e-2;
    end  
    t = [t ; t_end+t1];
    y = [y; y1];
    y0 = y1; %<-- update
end

% Step 4: Ramp up: slope 1.2e-3 Start 637.33:800------------------
t_end = t(end);
slope = 1.2e-3;
for t1 = 1e-2:1e-2:(800-t_end)
    y1 = y0 + a*slope*1e-2;
    if y1 >= 0.05
        y1 = 0.05;
    end
    t = [t ; t_end+t1];
    y = [y; y1];
    y0 = y1; %<-- update
end

% Test: Plot and Send data------------------
plot(t,y);
xlim([0 800])
ylim([-0.06 0.06])

y_t = [t y];
%}
%% Plot Max slope = 1.405e-3

% variables
slope1 = 1.404e-3;
slope2 = 1.4e-3;
slope3 = 1.2e-3;
slope4 = 1.2e-3;
slope5 = 1.3e-3; % Ramp down to zero...
slope6 = 1.4e-3; % Ramp up to 0.05
bound1 = 0.02;
bound2 = 0.05;
bound3 = 0.04;
bound4 = 0.03;

%initial y,t
y =[0];
t =[0];

%time step
ts = 1e-2;

i = 0; % for First period triangle
while i <6 %First Period Triangle
    t = [t; t(end)+ts];
    y_ = y(end) + slope1*ts;
    if y_ >= bound1 || y_ <= -bound1
        i = i+1;
        slope1 = -slope1;
        y_ = y(end) + slope1*ts;
    end
    y = [y; y_];
end

% Ramp up to y = 0
while y(end) < 0
    t = [t; t(end)+ts];
    y_ = y(end) + slope1*ts;
    y = [y; y_];
end

% Ramp up to Sat y=0.05 with slope 2
while y <= bound2
    y_ = y(end) + slope2*ts;
    if y_ >= 0.05
        break
    end
    t = [t; t(end)+ts];
    y = [y; y_];
end

% Maintain Sat level at for about 60s
t_end = t(end)+60;
while t(end) <= t_end
    t = [t; t(end)+ts];
    y_ = y(end);
    y = [y; y_];
end

% Ramp down to Sat y = -0.05
while y(end) >= -bound2
    y_ = y(end) + -slope2*ts;
    if y_ <= -0.05
        break
    end
    t = [t; t(end)+ts];
    y = [y; y_];
end

% Maintain Sat level at for about 70s
t_end = t(end)+70;
while t(end) <= t_end
    t = [t; t(end)+ts];
    y_ = y(end);
    y = [y; y_];
end
% Ramp back to 0
while y(end) <= 0
    t = [t; t(end)+ts];
    y_ = y(end) + slope2*ts;
    y = [y; y_];
end
% Second Triangle period---------------
j = 0;
while j<3 
    t = [t; t(end)+ts];
    y_ = y(end) + slope3*ts;
    if y_ >= bound3 || y_ <= -bound3
        j = j+1;
        slope3 = -slope3;
        y_ = y(end) + slope3*ts;
    end
    y = [y; y_];
end

% Ramp down to zero with slope 3
while y(end) > 0
    t = [t; t(end)+ts];
    y_ = y(end) + slope3*ts;
    y = [y; y_];
end
% End Second Triangle period---------------

% Third: Triangle period---------------
k = 0;
while k <= 4
    t = [t; t(end)+ts];
    y_ = y(end) + slope4*ts;
    if y_ > bound4 || y_ < -bound4
        k = k+1;
        slope4 = -slope4;
        y_ = y(end) + slope4*ts;
    end
    y = [y; y_];
end

% Ramp down to bound5 = -0.05
while y(end) > -0.05
    y_ = y(end) - slope5*ts;
    if y_ < -0.05
        break
    end
    t = [t; t(end)+ts];
    y = [y; y_];
end

% Bound for 1050s
y_end = y(end);
while t(end) < 1050
    t = [t; t(end)+ts];
    y = [y; y_end];
end

% Ramp up to 0.05
while y(end) <= 0.05
   y_ = y(end)+slope6*ts;
   if y_ >= 0.05
       break
   end
   t = [t; t(end)+ts];
   y = [y; y_];
end

% Sat at 0.05 to 1200
y_end = y(end);
while t(end) < 1200
    t = [t;t(end)+ts];
    y = [y; y_end];
end

plot(t,y);
y_t = [t y];

%% 
%% 

%clear figure --  % if not use
clf
d_Pg = out.d_Pg; d_Pg_y = d_Pg(:,2) ; d_Pg_t = d_Pg(:,1);
d_w = out.d_w; d_w_y = d_w(:,2) ; d_w_t = d_w(:,1);

% Plot frequency deviatiation
subplot(2,1,1);
plot(d_w_t,d_w_y*1e3);
yline(200,'--');
yline(-200,'--');
xlim([0 1200]);
ylim([-250 250]);
ytxt1 = "$\Delta f \,$ (mHz)";
ylabel(ytxt1,Interpreter="latex",FontSize=18);

% Plot gen rate
subplot(2,1,2);
plot(d_Pg_t,d_Pg_y);
yline(1.667e-3,'--');
yline(-1.667e-3,'--');
xlim([0 1200]);
ylim([-2e-3 2e-3]);
ytxt2 = "$\Delta \dot{p_{g}}$ (pu)";
ylabel(ytxt2,Interpreter="latex",FontSize=18);
xlabel('$Time (s)$',Interpreter="latex",FontSize=18);

%% 

clf
f = out.f; f_y = f(:,2) ; f_t = f(:,1);
f_dot = out.fdot; fdot_y = f_dot(:,2); fdot_t = f_dot(:,1);

% Plot input
subplot(2,1,1);
plot(f_t,f_y);
yline(0.05,'--');
yline(-0.05,'--');
xlim([0 1200]);
ylim([-0.06 0.06]);

syms f pu
ytext1 = "$\tilde{p_L}\,(pu)$";
ylabel(ytext1,Interpreter="latex",FontSize=18);
xlabel('');

% Plot slope input
subplot(2,1,2);
plot(fdot_t,fdot_y);
xlim([0 1200]);
ylim([-1.7e-3 1.7e-3]);
yline(-1.405e-3,'--');
yline(1.405e-3,'--');

ytext2 = "$\tilde{\dot{p_L}} \,(pu/s)$";
ylabel(ytext2,Interpreter="latex",FontSize=18);
xlabel('$Time (s)$',Interpreter="latex",FontSize=18);






