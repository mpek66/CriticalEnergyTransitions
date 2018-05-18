r = linspace(0,100,1000);
h1 = -2/3*r.*sqrt(r./3);
h2 = 2/3*r.*sqrt(r./3);
fig = figure('Name', 'Plot for w=0', 'NumberTitle', 'off');
plot(r, h1,'-o',r,h2,'-o');
hold on                             % Plot additional information
hold off                            % Stop adding plotted data
xlabel('r');
ylabel('h');
saveas(fig, 'Basic_Bifurcation.png');