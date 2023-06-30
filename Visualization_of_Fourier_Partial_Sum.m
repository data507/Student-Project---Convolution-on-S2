%% Example - Visualization of the Fourier Partial Sum on S2 for 10 Points
% We create a surface plot of the normalized fourier partial sum of Points as radius in spherical coordinates.

%% Example 1 - Fourier partial sum for 10 points

% points used in the Project
points_x = [-0.971594398072260;0.377429994463235;0.619610899948796;0.051904209431040;-0.236625520009863;-0.891895200167799;0.013994646857936;0.367963673254491;0.688474944348420;-0.123808304876014];
points_y = [-0.181294822763658;-0.686722156913689;-0.760984849684771;-0.207398847809825;0.521156863555915;0.276178378517657;-0.999641682964152;0.303867857404521;0.567681332850307;0.985838370556806];
points_z = [0.152106912642709;0.621256210015878;-0.192313263231869;0.976878534399490;-0.820002370026223;-0.358117934704477;0.022817877638356;-0.878787266863516;0.451375847091688;0.113111497123984];
points = vector3d([points_x, points_y, points_z]');

bandwidth = [4 8 16 32];

faces = 200;
[X, Y, Z] = sphere(faces);

X_v = reshape(X,[],1);
Y_v = reshape(Y,[],1);
Z_v = reshape(Z,[],1);

grid_points = vector3d([X_v, Y_v, Z_v].');

figure(1)
for i = 1:4
    f_partial_sum = S2FunHarmonic.quadrature(points,ones(10,1),'bandwidth',bandwidth(i));

    f = eval(f_partial_sum,grid_points);
    f_radius = reshape(f,faces+1,faces+1) ./ max(abs(f)) + 1;
    
    X_new = f_radius .*X;
    Y_new = f_radius .*Y;
    Z_new = f_radius .*Z;

    %Creating the surface plot
    subplot(2,2,i)
    surf(X_new,Y_new,Z_new, EdgeAlpha=0.14)
    title("$B="+string(bandwidth(i))+"$", 'Interpreter','latex');
    view(-20,20)
end

%% Example 2 - Fourier partial sum for 2 points with smaller disctance

% points used in the Project
points_x = [0.732332855575427;0.700264482043644];
points_y = [-0.459590980483685;-0.615647623142187];
points_z = [-0.502458674223847;-0.361396816958206];
points = vector3d([points_x, points_y, points_z]');

bandwidth = [4 8 16 32];

faces = 200;
[X, Y, Z] = sphere(faces);

X_v = reshape(X,[],1);
Y_v = reshape(Y,[],1);
Z_v = reshape(Z,[],1);

grid_points = vector3d([X_v, Y_v, Z_v].');

figure(2)
for i = 1:4
    f_partial_sum = S2FunHarmonic.quadrature(points,ones(2,1),'bandwidth',bandwidth(i));

    f = eval(f_partial_sum,grid_points);
    f_radius = reshape(f,faces+1,faces+1) ./ max(abs(f)) + 1;
    
    X_new = f_radius .*X;
    Y_new = f_radius .*Y;
    Z_new = f_radius .*Z;

    %Creating the surface plot
    subplot(2,2,i)
    surf(X_new,Y_new,Z_new, EdgeAlpha=0.14)
    title("$B="+string(bandwidth(i))+"$", 'Interpreter','latex');
    view(-20,20)
end

