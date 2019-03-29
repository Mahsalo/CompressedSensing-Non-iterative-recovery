# The Matlab implementations of the fast non-iterative recovery algorithm 

This repository consists of the MATLAB implementations of the fast non-iterative algorithm proposed in our paper. The main Matlab files that you need to run are "non_iter_git.m" and "non_iter_noisy_git.m". The rest of the files are the functions that are called inside these main files. Each file has its own instructions at the beggining. The Matlab file called "non_iter_noisy_git.m" is the implementation of the noisy case in the paper and to be complete you need to define functions which add small or big noises (in terms of magnitude). The noises should change only a few limited number of elements "E" and the magnitude is controlled by "alfa". The functions are called "add_big_noise(y1,E,alfa)" and "add_noise(y1,E)" in the main file.

If you use these codes in your research, please cite our paper in your research:

"A fast noniterative algorithm for compressive sensing using binary measurement matrices"
DOI: 10.1109/TSP.2018.2841881
authors: Mahsa Lotfi and Mathukumalli Vidyasagar
