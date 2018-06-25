%iris
time_iris_l2norm = [5.63 5.29 5.68];
time_iris_l1norm = [25.43 23.79 25.26];
time_iris_linfnorm = [31.72 27.73 30.13];
time_iris_linfnorm_parallel = [1.22 1.18 1.21];
data_iris = [time_iris_l1norm;time_iris_l2norm;time_iris_linfnorm;time_iris_linfnorm_parallel];
time_iris_mean = mean(data_iris,2);
time_iris_var = var(data_iris');
time_iris_mean
time_iris_var

%moons
time_moons_l2norm = [4.09 4.34 4.36];
time_moons_l1norm = [32.26 34.09 33.4];
time_moons_linfnorm = [30.45 28.83 29.23];
time_moons_linfnorm_parallel = [2.27 2.49 2.31];
data_moons = [time_moons_l1norm;time_moons_l2norm;time_moons_linfnorm;time_moons_linfnorm_parallel];
time_moons_mean = mean(data_moons,2);
time_moons_var = var(data_moons');
time_moons_mean
time_moons_var


%segment
time_segment_l2norm = [58.15 53.25 51.48];
time_segment_l1norm = [107.43 103.58 107.14];
time_segment_linfnorm = [151.27 139.69 150.53];
time_segment_linfnorm_parallel = [6.62 6.53 6.16];
data_segment = [time_segment_l1norm;time_segment_l2norm;time_segment_linfnorm;time_segment_linfnorm_parallel];
time_segment_mean = mean(data_segment,2);
time_segment_var = var(data_segment');
time_segment_mean
time_segment_var


%svmguide
time_svmguide_l2norm = [322.09 315.06];
time_svmguide_l1norm = [736.2 727.45];
time_svmguide_linfnorm = [1211 1207.7];
time_svmguide_linfnorm_parallel = [20.46 20.17];
data_svmguide = [time_svmguide_l1norm;time_svmguide_l2norm;time_svmguide_linfnorm;time_svmguide_linfnorm_parallel];
time_svmguide_mean = mean(data_svmguide,2);
time_svmguide_var = var(data_svmguide');
time_svmguide_mean
time_svmguide_var

