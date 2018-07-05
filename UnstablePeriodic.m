function UnstablePeriodic
    %clears any annoying figures
    clf
    options = odeset('RelTol',1e-5,'AbsTol',1e-8);
    %our parameters
    h = 2;
    r = 10;
    w = .01;
    A = 10.5;
    P = 5;
    %calculate the roots/initial conditions
    x0s = roots([-1 0 r h]);
    %save only real roots and transpose (needed later)
    x0s = x0s(imag(x0s)==0).';
    unstable = x0s(3)
    tvec = linspace(2*pi/w*P,0,1000);
    [t,x] = ode45(@(t,x) h+r*x-x.^3+A*sin(w*t),tvec,unstable);
    plot(t,x);
    