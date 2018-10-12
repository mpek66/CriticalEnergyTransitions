function Coupled
    clf;
    %params
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
    x1 = 0;
    x2 = .33;
    x3 = .67;
    x4 = 1;
    fig = figure('Name', 'EBM Bifurcation', 'NumberTitle', 'off');
    num = 150; %subintervals in f
    P = 16; %number of periods
    fi = 14.5; %initial f value
    ff = 15.5; %final f value
    %below we vary f and plot bifurcation diagram
    fvals = linspace(fi,ff,num);
    g1 = linspace(0,0,num);
    g2 = linspace(0,0,num);
    g3 = linspace(0,0,num);
    g4 = linspace(0,0,num);
    start1 = 30;
    start2 = 10;
    start3 = -10;
    start4 = -30;
    ix = 1;
    for F = fvals
        G = @(t, E) [getAlbedo(E(1), x1)*getSeasonal(x1, t)-(A+B*E(1))+(1-x1*x1)*(mean(E)-E(1))+Fb+F;
                        getAlbedo(E(2), x2)*getSeasonal(x2, t)-(A+B*E(2))+(1-x2*x2)*(mean(E)-E(2))+Fb+F;
                            getAlbedo(E(3), x3)*getSeasonal(x3, t)-(A+B*E(3))+(1-x3*x3)*(mean(E)-E(3))+Fb+F;
                                getAlbedo(E(4), x4)*getSeasonal(x4, t)-(A+B*E(4))+(1-x4*x4)*(mean(E)-E(4))+Fb+F];
        [t E] = ode45(G, [0 P*2*pi/w], [start1,start2,start3,start4]);
        start = floor(length(E)*(P-2)/P);
        avg1 = (min(E(start:end,1))+max(E(start:end,1)))/2;
        avg2 = (min(E(start:end,2))+max(E(start:end,2)))/2;
        avg3 = (min(E(start:end,3))+max(E(start:end,3)))/2;
        avg4 = (min(E(start:end,4))+max(E(start:end,4)))/2;
        start1 = E(end,1);
        start2 = E(end,2);
        start3 = E(end,3);
        start4 = E(end,4);
        g1(ix) = avg1;
        g2(ix) = avg2;
        g3(ix) = avg3;
        g4(ix) = avg4;
        ix = ix + 1
    end
    plot(fvals, g1); hold on;
    plot(fvals, g2); hold on;
    plot(fvals, g3); hold on;
    plot(fvals, g4); hold on;
    %Now back the other way
    fvals = linspace(ff,fi,num);
    g1 = linspace(0,0,num);
    g2 = linspace(0,0,num);
    g3 = linspace(0,0,num);
    g4 = linspace(0,0,num);
    avg1 = 30;
    avg2 = 10;
    avg3 = -10;
    avg4 = -30;
    ix = 1;
    for F = fvals
        G = @(t, E) [getAlbedo(E(1), x1)*getSeasonal(x1, t)-(A+B*E(1))+(1-x1*x1)*(mean(E)-E(1))+Fb+F;
                        getAlbedo(E(2), x2)*getSeasonal(x2, t)-(A+B*E(2))+(1-x2*x2)*(mean(E)-E(2))+Fb+F;
                            getAlbedo(E(3), x3)*getSeasonal(x3, t)-(A+B*E(3))+(1-x3*x3)*(mean(E)-E(3))+Fb+F;
                                getAlbedo(E(4), x4)*getSeasonal(x4, t)-(A+B*E(4))+(1-x4*x4)*(mean(E)-E(4))+Fb+F];
        [t E] = ode45(G, [0 P*2*pi/w], [start1,start2,start3,start4]);
        start = floor(length(E)*(P-2)/P);
        avg1 = (min(E(start:end,1))+max(E(start:end,1)))/2;
        avg2 = (min(E(start:end,2))+max(E(start:end,2)))/2;
        avg3 = (min(E(start:end,3))+max(E(start:end,3)))/2;
        avg4 = (min(E(start:end,4))+max(E(start:end,4)))/2;
        start1 = E(end,1);
        start2 = E(end,2);
        start3 = E(end,3);
        start4 = E(end,4);
        g1(ix) = avg1;
        g2(ix) = avg2;
        g3(ix) = avg3;
        g4(ix) = avg4;
        ix = ix + 1
    end
    plot(fvals, g1); hold on;
    plot(fvals, g2); hold on;
    plot(fvals, g3); hold on;
    plot(fvals, g4); hold on;
    xlabel("F");
    ylabel("E_{avg}");
end

function albedo=getAlbedo(E, x)
    a0 = 0.7;
    a2 = 0.1;
    ai = 0.4;
    if E > 0
        albedo=a0-a2*(x*x);
    else
        albedo = ai;
    end
end

function season=getSeasonal(x, t)
    S0 = 420;
    S1 = 338;
    S2 = 240;
    w = 1;
    season = S0-S1*x*cos(w*t)-S2*x*x;
end