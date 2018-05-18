%the basic idea of this script is to test a bunch of points in the rhA
%space and plot stability for varying x values of the periodic trajectories
%so more trends of bifurcations can be analyzed with respect to x

function FloquetVaryX
    %our parameters
    n = 500; %number of slices for each plane
    w = 100;
    A = 1;
    %set up our graphing
    x = [];
    y = [];
    rvals = linspace(-1,1,n);
    for r = rvals
       hvals = linspace(-10,10,1);
       for h = hvals
           fms = getFMS(r,h,w,A);
           for f = fms
               x = [x, f(1)];
               y = [y, f(2)];
           end
       end
       scatter(x,y, 9, 'filled'); hold on;
       x = [];
       y = [];
    end
end

%same as always, gets the floquet multipliers for a system with given
%parameters
function FMs = getFMS(m,h,w,A)
%calculate the roots of the function
    r = roots([-1 0 m h]);
    %save only real roots and transpose (needed later)
    r = r(imag(r)==0).';
    %initialize return value
    xs = [];
    mus = [];
    %iterate through each root
    for root = r
        %our perturbations
        p = linspace(-.005,.005,2);
        results =[];
        for perturb = p
            tvec = linspace(0,2*pi/w,2);
            opts = odeset('RelTol',1e-4,'AbsTol',1e-5);
            %numerically integrate
            [t,x] = ode45(@(t,x) h+m*x-x.^3+A*sin(w*t),tvec,root+perturb, opts);
            results = [results, abs((x(end)-root)/perturb)];
        end
        mus = [mus, mean(results)];
        xs = [xs, root];
    end
    FMs = [xs; mus];
end