function BifurcationA
    %clears any annoying figures
    clf
    options = odeset('RelTol',1e-5,'AbsTol',1e-8);
    %our parameters
    h = 2;
    r = 10;
    w = .01;
    P = 1;
    %calculate the roots/initial conditions
    x0s = roots([-1 0 r h]);
    %save only real roots and transpose (needed later)
    x0s = x0s(imag(x0s)==0).';
    %what value of A do all fixed points converge?
    jumpone = min([abs(-sqrt(4*r^3/27)-h),abs(sqrt(4*r^3/27)-h)]);
    jumptwo = max([abs(-sqrt(4*r^3/27)-h),abs(sqrt(4*r^3/27)-h)]);
    
    Avals = linspace(0,25,100);
    for A = Avals
        for x0 = x0s
            %estimate stability
            tvec = [0,2*pi/w*P];
            floquet = 0;
            perturbations = [-0.05, 0.05];
            for perturb = perturbations
                [t,x] = ode45(@(t,x) h+r*x-x.^3+A*sin(w*t),tvec,x0+perturb);
                estimate = abs((x(end)-x0)/perturb);
                floquet = estimate + floquet;
            end
            floquet = floquet/length(perturbations);
            %now find min and max
            if floquet <= 1 | A < jumptwo
                extrema = getExtrema(x0,A,floquet,r,h,w,P);
                minval = extrema(1);
                maxval = extrema(2);
            end
            %graph min and max, color based on stability
            minspecs = "bs";
            maxspecs = "bd";
            if floquet > 1 & A < jumptwo
                minspecs = "rs";
                maxspecs = "rd";
                if maxval < max(x0s)
                    plot(A, maxval, maxspecs); hold on;
                end
                if minval > min(x0s)
                    plot(A, minval, minspecs); hold on;
                end
            elseif floquet <= 1
                plot(A, maxval, maxspecs); hold on;
                plot(A, minval, minspecs); hold on;
            end
        end
    end
    "done"
end

%finds the extrema given conditions and stability
function extrema=getExtrema(x0,A,f,r,h,w,P)
    tvec = [0,2*pi/w*P];
    if f > 1
        tvec = [2*pi/w*P,0];
    end
    [t,x] = ode45(@(t,x) h+r*x-x.^3+A*sin(w*t),tvec,x0);
    extrema = [min(x), max(x)];
end
    
    