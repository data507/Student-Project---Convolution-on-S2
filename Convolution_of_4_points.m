%% Example - Convolution of 4 Points
% In this example we choose 2 points from a set of 4 points and visualize
% the convolution of these 2 sets.

%% Example 1 - All 4 points have a different disctance to each other

n = 4;
k = 2;
bandwidth = 16;

% points used in the project
v1 = [-0.923879532511287, 0.382683432365090, 0];
v2 = [-0.923879532511287, -0.382683432365090, 0];
v3 = [0,	-0.972369920397677, 0.233445363855905];
v4 = [-0.0507985973848470, -0.807420584138902, 0.587785252292473];
points = vector3d([v1; v2; v3; v4].');

% visualizing the points
figure(1)
subplot(1,2,1)
[X, Y, Z] = sphere(100);
scatter3(points.x, points.y, points.z, MarkerFaceColor="blue", MarkerEdgeColor='white')
hold on
surf(X,Y,Z, 'EdgeColor','none', FaceAlpha=0.2, FaceColor='black')
view(-60,20)
hold off

% Convolution
rotated_points = (rotation.byEuler(200 * degree,50 * degree,75 * degree) * points(1:k));
[Convolution_fun, found_rot] = S2ConvMax(points,rotated_points,bandwidth);

grid = equispacedSO3Grid(Convolution_fun.CS, Convolution_fun.SS,'resolution', 1.5*degree);
phi1 = reshape(grid.phi1, [],1) ./ degree;
Phi = reshape(grid.Phi, [],1) ./ degree;
phi2 = reshape(grid.phi2, [],1) ./ degree;

f = eval(Convolution_fun,grid);
f = reshape(f, [],1);
f_max = max(f);

% forget small values
index = f > 0.6 .* f_max;
f = f(index);
phi1 = phi1(index);
Phi = Phi(index);
phi2 = phi2(index);

% change transparency of points for higher values
steps = [0.6 0.7 0.8 0.9 0.95 1];
alpha = [0.03 0.06 0.1 0.5 1];

% creating the plot
subplot(1,2,2)
for i = 1:(length(steps)-1)
    index_i = f > steps(i) * f_max & f < steps(i+1) * f_max;
    phi1_i = phi1(index_i);
    Phi_i = Phi(index_i);
    phi2_i = phi2(index_i);
    f_i = f(index_i);
    
    scatter3(phi1_i,Phi_i,phi2_i,50,f_i, 'filled', 'MarkerFaceAlpha', alpha(i));
    hold on
end

cb = colorbar;
xlim([0 360]);
ylim([0 180]);
zlim([0 360]);
xlabel('$\alpha$ in $^{\circ}$', 'interpreter','latex')
ylabel("$\beta$ in $^{\circ}$", 'interpreter','latex')
zlabel("$\gamma$ in $^{\circ}$", 'interpreter','latex')
ylabel(cb,"$(U \ast V)(\alpha, \beta, \gamma)$", 'interpreter', 'latex','FontSize',16,'Rotation',270);
hold off

%% Example 2 - 2 points from the 4-point-set are a rotated copy of the 2 other points

n = 4;
k = 2;
bandwidth = 16;

% points used in the project
v1 = [-0.923879532511287, 0.382683432365090, 0];
v2 = [-0.923879532511287, -0.382683432365090, 0];
v3 = [0, -0.972369920397677, 0.233445363855905];
v4 = [0, -0.522498564715949, 0.852640164354092];
points = vector3d([v1; v2; v3; v4].');

% visualizing the points
figure(2)
subplot(1,2,1)
[X, Y, Z] = sphere(100);
scatter3(points.x, points.y, points.z, MarkerFaceColor="blue", MarkerEdgeColor='white')
hold on
surf(X,Y,Z, 'EdgeColor','none', FaceAlpha=0.2, FaceColor='black')
view(-60,20)
hold off

% Convolution
rotated_points = (rotation.byEuler(200 * degree,50 * degree,75 * degree) * points(1:k));
[Convolution_fun, found_rot] = S2ConvMax(points,rotated_points,bandwidth);

grid = equispacedSO3Grid(Convolution_fun.CS, Convolution_fun.SS,'resolution', 1.5*degree);
phi1 = reshape(grid.phi1, [],1) ./ degree;
Phi = reshape(grid.Phi, [],1) ./ degree;
phi2 = reshape(grid.phi2, [],1) ./ degree;

f = eval(Convolution_fun,grid);
f = reshape(f, [],1);
f_max = max(f);

% forget small values
index = f > 0.6 .* f_max;
f = f(index);
phi1 = phi1(index);
Phi = Phi(index);
phi2 = phi2(index);

% change transparency of points for higher values
steps = [0.6 0.7 0.8 0.9 0.95 1];
alpha = [0.03 0.06 0.1 0.5 1];

% creating the plot
subplot(1,2,2)
for i = 1:(length(steps)-1)
    index_i = f > steps(i) * f_max & f < steps(i+1) * f_max;
    phi1_i = phi1(index_i);
    Phi_i = Phi(index_i);
    phi2_i = phi2(index_i);
    f_i = f(index_i);
    
    scatter3(phi1_i,Phi_i,phi2_i,50,f_i, 'filled', 'MarkerFaceAlpha', alpha(i));
    hold on
end

cb = colorbar;
xlim([0 360]);
ylim([0 180]);
zlim([0 360]);
xlabel('$\alpha$ in $^{\circ}$', 'interpreter','latex')
ylabel("$\beta$ in $^{\circ}$", 'interpreter','latex')
zlabel("$\gamma$ in $^{\circ}$", 'interpreter','latex')
ylabel(cb,"$(U \ast V)(\alpha, \beta, \gamma)$", 'interpreter', 'latex','FontSize',16,'Rotation',270);
hold off