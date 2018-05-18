function FloquetVaryH
    clf
    h=0;
    w=100;
    n = 1000; %number of trials
    x1 = linspace(0,100,n);
    x2 = linspace(0,100,n);
    x3 = linspace(0,100,n);
    rvals = linspace(-1,10,n);
    ix = 1;
    for r = rvals  
        %getFMS of r, h, w
        v = getFMS(r,h,w);
        x1(ix) = v(1);
        x2(ix) = NaN;
        x3(ix) = NaN;
        if length(v) >= 3
            x3(ix) = v(3);
        end
        if length(v) >= 2
            x2(ix) = v(2);
        end
        ix = ix + 1;
    end
    fig = figure('Name', 'Plot for w=0', 'NumberTitle', 'off');
    plot(rvals,x1); hold on;
    plot(rvals,x2); hold on;
    plot(rvals,x3); hold on;
    xlabel('r');
    ylabel('lambda');
    %saveas(fig, 'R_bifurcation.png');
end

function FMs = getFMS(m,h,w)
%calculate the roots of the function
    r = roots([-1 0 m h]);
    %save only real roots and transpose (needed later)
    r = r(imag(r)==0).';
    %initialize return value
    FMs = [];
    %iterate through each root
    for root = r
        %our perturbations
        p = linspace(-1,1,10);
        results =[];
        for perturb = p
            tvec = linspace(0,2*pi/w,100);
            %numerically integrate
            [t,x] = ode45(@(t,x) h+m*x-x.^3+sin(w*t),tvec,root+perturb);
            results = [results, abs((x(end)-root)/perturb)];
        end
        FMs = [FMs, mean(results)];
    end
end