function SingleLatitude
    clf;
    a0 = 0.7;
    a2 = 0.1;
    ai = 0.4;
    S0 = 420;
    S1 = 338;
    S2 = 240;
    w = 1;
    A = 193;
    B = 2.1;
    C = 0.6;
    Fb = 4;
    F = 0;
    fig = figure('Name', 'Individual Latitude Solutions Without Heat Transport', 'NumberTitle', 'off');
    for x=[.33,.67,1]
        t = linspace(0, 6*pi, 100);
        E = linspace(0,1,100);
        for ix=linspace(2,length(t),length(t)-1)
            E(ix) = (getAlbedo(E(ix-1),x)*(S0-S2*x*x)+Fb+F-A)/B+(a0-a2*x*x)*(S1*x)*(w*sin(w*t(ix)+pi)+B*cos(w*t(ix)+pi))/(w*w+B*B);
        end
        colors=['g','b','y'];
        plot(t,E,colors(round(x*3))); hold on;
    end
    xlabel("t");
    ylabel("E");
end

function albedo=getAlbedo(E,x)
    a0 = 0.7;
    a2 = 0.1;
    ai = 0.4;
    if E > 0
        albedo=a0-a2*(x*x);
    else
        albedo = ai;
    end
end