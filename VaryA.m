function Cusp_Floquet
    %clears any annoying figures
    clf
    %our parameters
    h = 2;
    m = 5;
    w = .01;
    A = 1;
    P = 3; %number of cycles
    %calculate the roots of the function
    r = roots([-1 0 m h]);
    %save only real roots and transpose (needed later)
    r = r(imag(r)==0).';
    fig = figure('Name', 'Plot for w=0', 'NumberTitle', 'off');
    
    %iterate through each root
    for root = r
        %our perturbations
        p = linspace(-1,1,10);
        results =[];
        for perturb = p
            %our time to iterate over, we want to do ten cycles
            tvec = linspace(0,2*P*pi/w,1000);
            %numerically integrate
            [t,x] = ode45(@(t,x) h+m*x-x.^3+A*sin(w*t),tvec,root+perturb);
            results = [results, abs((x(end)-root)/perturb)];
            plot(t,x, 'LineWidth', 1.3); hold on;
        end
        root;
        nthroot(mean(results),P);
    end
    if h == 0 || m == 0
        JumpOnly = abs(sqrt(4*m^3/27))
    else if h < 0
        JumpOne = abs(-sqrt(4*m^3/27)-h)
        JumpTwo = abs(sqrt(4*m^3/27)-h)
    else
        JumpOne = abs(sqrt(4*m^3/27)-h)
        JumpTwo = abs(-sqrt(4*m^3/27)-h)
    end
    xlabel('h');
    ylabel('lambda');
    saveas(fig, 'VaryA1Star.png');
end