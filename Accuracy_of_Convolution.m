%% Accuracy of the Convolution
% We want to analyze the accuracy of Convolution with respect to the number
% of rotated points k and the bandwidth B.

%% Accuracy with regards to k

n = 10;
k = 5;
bandwidth_max = 100;

% points used in the project
points_x = [-0.809342161729005;0.674604963567440;-0.111040357094512;-0.047831899341176;-0.384262260665655;0.158419961974875;-0.320225801744453;0.226249937023855;0.711556320644972;0.699576053460573];
points_y = [0.561318124867229;0.649808209869050;0.954154366890451;0.969455779976909;0.681969956694103;0.224609936465464;0.452559838542921;0.216943479621988;-0.634082706514542;0.470808771779056];
points_z = [0.172879229357836;0.350224832810231;-0.277955901610678;0.240556854142171;0.622301770200570;-0.961485045171717;-0.832252983434200;0.949603334369781;0.302699064830707;-0.537524367671296];
points = vector3d([points_x, points_y, points_z]');

% choose fist k points and rotate with ratation used in project
rot = rotation.byEuler(5.843617597038678,1.774155137363048,0.297832169760391);
rotated_points = (rot * points(1:k));

angle_b = ones(bandwidth_max,1);

for b=1:bandwidth_max
    [Convolution_fun, found_rot] = S2ConvMax(points,rotated_points,b);
    angle_b(b) = angle(rot\found_rot) ./degree;
    disp(b)
end

% creating the plot
figure(1)
semilogy(1:bandwidth_max, angle_b)
xlabel("Bandwidth $B$", 'interpreter', 'latex')
ylabel("Angle of $g^{-1}\cdot \bar{g}$", 'interpreter', 'latex')

%% Accuracy with regards to B

n = 10;
B = [4 8 16 32 64];


% points used in the project
points_x = [-0.809342161729005;0.674604963567440;-0.111040357094512;-0.047831899341176;-0.384262260665655;0.158419961974875;-0.320225801744453;0.226249937023855;0.711556320644972;0.699576053460573];
points_y = [0.561318124867229;0.649808209869050;0.954154366890451;0.969455779976909;0.681969956694103;0.224609936465464;0.452559838542921;0.216943479621988;-0.634082706514542;0.470808771779056];
points_z = [0.172879229357836;0.350224832810231;-0.277955901610678;0.240556854142171;0.622301770200570;-0.961485045171717;-0.832252983434200;0.949603334369781;0.302699064830707;-0.537524367671296];
points = vector3d([points_x, points_y, points_z]');

% rotate with ratation used in project
rot = rotation.byEuler(5.843617597038678,1.774155137363048,0.297832169760391);
rotated_points = (rot * points);


angle_k = ones(n-2,length(B));

figure(2)
for b = 1:length(B)
    for k=3:n   
        [Convolution_fun, found_rot] = S2ConvMax(points,rotated_points(1:k),B(b));
        angle_k(k-2,b) = angle(rot\found_rot) ./degree;
    end
    % creating the plot
    semilogy(3:n, angle_k(:,b), 'DisplayName', "$B = " + string(B(b)) + "$")
    hold on
    xlim([3 10])
    xlabel("Number of rotated points $k$", 'interpreter', 'latex')
    ylabel("Angle of $g^{-1}\cdot \bar{g}$", 'interpreter', 'latex')
    legend('Location','eastoutside', 'Interpreter','latex')
end
hold off