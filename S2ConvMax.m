function [convolution_fun, max_rotation] = S2ConvMax(points1, points2, bandwidth)

%S2CONVMAX calculates the Convolution of two sets of Points in 3d-Space and estimates its maximum using the MTEX Toolbox for Matlab.
%   The Convolution is calculated by Multiplication in the frequency space
%   of the two sets of points.

n = length(points1);
k = length(points2);

%S2-Fourier-Transforms
points_quad_fun = S2FunHarmonic.quadrature(points1,ones(n,1),'bandwidth',bandwidth);
rotated_points_quad_fun = S2FunHarmonic.quadrature(points2,ones(k,1),'bandwidth',bandwidth);

%Convolution
convolution_fun = conv(rotated_points_quad_fun,points_quad_fun);

%Find Maximum
[Max, max_rotation] = max(convolution_fun,'resolution',5*degree,'accuracy',0.01*degree);

end

