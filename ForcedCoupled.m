function Coupled
    clf;
    %params
    h=1;
    r=1;
    w=1;
    A=1;
    C=1;
    %"latitudes"
    x1 = -1;
    x2 = 4;
    x3 = 2;
    x4 = 2;
    %system
    fig = figure('Name', 'Cusp Normal Coupled', 'NumberTitle', 'off');
    G = @(t, X) [h+r*X(1)-X(1)*X(1)*X(1)+A*sin(w*t)+C*(mean(X)-X(1));
                    h+r*X(2)-X(2)*X(2)*X(2)+A*sin(w*t)+C*(mean(X)-X(2));
                        h+r*X(3)-X(3)*X(3)*X(3)+A*sin(w*t)+C*(mean(X)-X(3));
                            h+r*X(4)-X(4)*X(4)*X(4)+A*sin(w*t)+C*(mean(X)-X(4))];
    [t X] = ode45(G, [0 6*pi], [x1, x2, x3, x4]);
    plot(t, X(:,1), 'y', t, X(:,2), 'g', t, X(:,3), 'y', t, X(:,4), 'r'); hold on;
    xlabel("t");
    ylabel("x");
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