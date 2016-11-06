#  Project 5: Camera Calibration and Fundamental Matrix Estimation with RANSAC (assignment source: James Hays)

## Overview
This was one of my course assignments at Information Technology University (ITU), Lahore. In this assignment, I implemented 1) camera projection matrix, which maps 3D world coordinates to image coordinates 2) fundamental matrix, which relates points in one scene to epipolar lines in another. To estimate the projection matrix (camera calibration), the input is corresponding 3d and 2d points. To estimate the fundamental matrix the input is corresponding 2d points across two images, which are computer using VLFeat’s implementation of SIFT.

## Results
### Part 1: Calculate the projection matrix given corresponding 2D and 3D points
Left image: visualization of actual 2D points and the projected 2D points calculated from the projection matrix.
Right image: estimated location of the camera center.

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/eval_P_Matrix.jpg" width="45%"/>
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/eval_camera_center.jpg" width="45%"/>
</p>

### Part 2: Calculate the fundamental matrix given corresponding point pairs
 Visualization the epipolar lines given the fundamental matrix, left right images and left right data points.

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/eval_part2a.jpg" width="45%"/>
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/eval_part2b.jpg" width="45%"/>
</p>

### Part 3: Calculate the fundamental matrix using RANSAC
Visualization the epipolar lines on the images and corresponding matches.

#### Mount Rushmore
<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Mount_Rushmore_Inliers.jpg" width="90%"/>
</p>

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Mount_Rushmore_1.jpg" width="45%"/>
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Mount_Rushmore_2.jpg" width="45%"/>
</p>

#### Notre Dame
<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Notre_Dame_Inliers.jpg" width="90%"/>
</p>

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Notre_Dame_1.jpg" width="45%"/>
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Notre_Dame_2.jpg" width="45%"/>
</p>

#### Episcopal Gaudi
<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Episcopal-Gaudi-Inliers.jpg" width="90%"/>
</p>

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Episcopal-Gaudi_epipolar_lines_1.jpg" width="45%"/>
<img src="https://github.com/alihassan1/mini_projects/blob/master/ransac_fundamental_matrix/results/Episcopal-Gaudi_epipolar_lines_2.jpg" width="45%"/>
</p>
