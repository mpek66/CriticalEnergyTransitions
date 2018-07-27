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
    F = 0;
    x1 = 0;
    x2 = .33;
    x3 = .67;
    x4 = 1;
    G = @(t, E) [getAlbedo(E(1), x1)*getSeasonal(x1, t)-(A+B*E(1))+C*(mean(E)-E(1))+Fb+F;
                    getAlbedo(E(2), x2)*getSeasonal(x2, t)-(A+B*E(2))+C*(mean(E)-E(2))+Fb+F;
                        getAlbedo(E(3), x3)*getSeasonal(x3, t)-(A+B*E(3))+C*(mean(E)-E(3))+Fb+F;
                            getAlbedo(E(4), x4)*getSeasonal(x4, t)-(A+B*E(4))+C*(mean(E)-E(4))+Fb+F];
    [t E] = ode45(G, [0 6*pi], [1, 1, 1, 1]);
    plot(t, E(:,1), 'r', t, E(:,2), 'g', t, E(:,3), 'b', t, E(:,4), 'y'); hold on;
    x=1;
    t = linspace(0, 6*pi, 100);
    E = linspace(0,1,100);
    for ix=linspace(2,length(t),length(t)-1)
        ix
        E(ix) = (getAlbedo(E(ix-1),x)*(S0-S2*x*x)+Fb+F-A)/B+(a0-a2*x*x)*(S1*x)*(w*sin(w*t(ix)+pi)+B*cos(w*t(ix)+pi))/(w*w+B*B);
    end
    plot(t,E); hold on;
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