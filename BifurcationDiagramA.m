% This script plots solution trajectories

clear,clc

% Parameters
r=10;
w=2*pi;
% h=10;

% hvec = -25:0.1:25;
h=10;
Avec = 0.1:0.1:10;

options = odeset('RelTol',1e-5,'AbsTol',1e-8);

A_bif_diag = [];
bif_diag = [];
for n = 1:length(Avec)
    A = Avec(n);
    disp(A)
    % Find periodic solution trajectories %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x0 = -5:0.1:5;
    tend = 10;

    % Run for several initial conditions for a long time
%     [~,x] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[0, tend],x0(1));
%     xprev = x(end); 
%     unstable = 0;
%     figure, hold on
    for m = 1:length(x0)
        [t,x] = ode45(@(t,x) h+r*x-x^3+A*sin(w*t),[0, tend],x0(m));
%         plot(t,x) 
    
%         if (abs(xprev - x(end)) > 0.1) && (unstable==0)
%             x0_unstable = (x0(m) + x0(m-1))/2;
%             [t,x] = ode45(@(t,x) h+r*x-x^3+sin(w*t),[tend, 0],x0_unstable);
% %             plot(t,x)
% 
%             x0_unstable = x(end);
%             unstable = 1;
%         end
%         xprev = x(end);
    end

    % Re-run ode45 for first and last x0 to get the initial conditions for the
    % steady-states
    [~,xfirst] = ode45(@(t,x) h+r*x-x^3+A*sin(w*t),[0, tend],x0(1),options);
    [~,xlast] = ode45(@(t,x) h+r*x-x^3+A*sin(w*t),[0, tend],x0(end),options);
    
    % Create one period of the periodic solutions
    [t1,x1] = ode45(@(t,x) h+r*x-x^3+A*sin(w*t),[0, 1],xfirst(end),options);
    [t2,x2] = ode45(@(t,x) h+r*x-x^3+A*sin(w*t),[0, 1],xlast(end),options);
%     [~,xunstable] =  ode45(@(t,x) h+r*x-x^3+sin(w*t),[1, 0],x0_unstable);
    
    % Test plot
%     figure, hold on
%     plot(t1,x1)
%     plot(t2,x2)
%     clf
    
    % Find minima of the periodic solutions
    min1 = min(x1); 
    min2 = min(x2);
%     minun = min(xunstable);
    
    % Add minima to bifurcation diagram
    if min1==min2
        A_bif_diag = [A_bif_diag, A];
        bif_diag = [bif_diag, min1];
    else
        A_bif_diag = [A_bif_diag, A, A];
        bif_diag = [bif_diag, min1, min2];
    end
end

figure
scatter(A_bif_diag,bif_diag)

pause(0.01)


