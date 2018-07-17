% This script plots solution trajectories

clear,clc

% Parameters
r=10;
w=2*pi;
h=10;

% Plot solution trajectories %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = -5:0.1:5;
tend = 10;

% Run for several initial conditions for a long time
figure, hold on

xprev = -2; unstable = 0;
for m = 1:length(x0)
    [t,x] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, tend],x0(m));

    plot(t,x) 
    
    if (abs(xprev - x(end)) > 1) && (unstable==0)
        x0_unstable = (x0(m) + x0(m-1))/2;
        
        [t,x] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[tend, 0],x0_unstable);
        
        plot(t,x)
        
        x0_unstable = x(end);
        unstable = 1;
    end
    
    xprev = x(end);
end

% Re-run ode45 for first and last x0 to get the initial conditions for the
% steady-states
[~,xfirst] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, tend],x0(1));
[~,xlast] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, tend],x0(end));
% [~,xunstable] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, tend],x0(end));

% Create and plot all periodic solutions
[t1,x1] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, 1],xfirst(end));
[t2,x2] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, 1],xlast(end));
[t3,x3] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[1, 0],x0_unstable);

figure, hold on
plot(t1,x1)
plot(t2,x2)
plot(t3,x3)