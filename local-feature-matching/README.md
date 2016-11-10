#  Project 2: Local Feature Matching (James Hays) 

## Overview
This was one of my course projects at Information Technology University (ITU), Lahore. The goal of this project was to create a local feature matching algorithm using techniques described in Szeliski chapter 4.1 [2]. In this project, I implemented a simplified version of SIFT [3] pipeline. Local features are used in numerous computer vision applications; such as, image registration (panorama stitching), object detection, object / plane / camera position tracking, to name a few. The general pipeline consists of three main steps. 1) Interest Point Detection - in this step we try to find local features that are discriminative and repeatable 2) Feature Extraction - in this step we statistically describe those detected key-points, e.g. make histogram of edge orientations. 3) Matching - nearest neighbor search is performed to match descriptors from two or more images. Matched key-points are generally called ‘correspondences’ in the literature. These three steps are common in almost all algorithms involving local features.

## Interest Point Detection (Harris Corners Detector)
To find interest points, I implemented the Harris Corner Detector as described in Szeliski 4.1.1 [2]. Following are the visualizations of intermediate results.
<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/local-feature-matching/results/harris.png" width="90%"/>
</p>

## Feature Extraction (simplified SIFT)
For this part, I implemented a SIFT like feature descriptor as described in Szeliski 4.1.2 [2]. It creates a histogram of gradient orientations in 8 directions. I tested my pipeline on a 16x16 patch, which is then decided into a 4x4 grid, each element of the grid contains sum of the magnitude of gradient orientations in 8 directions, which makes it a 128 dimensional feature descriptor i.e. 4x4x8 = 128. 

## Matching
In this step, I took top two nearest neighbors and applied the ratio test on them as described in Szeliski 4.1.3 [2]. If they are within the threshold (0.8), then its a match (correspondence). Following are the results. 

## Results

### Mount Rushmore
On this example, I achieved 91% detection accuracy. There were 169 total good matches, and 16 total bad matches.
<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/local-feature-matching/results/Mount_Rushmore_eval.jpg" width="90%"/>
</p>

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/local-feature-matching/results/Mount_Rushmore_vis_arrows.jpg" width="90%"/>
</p>

### Notre Dame
On this example, I achieved 83% detection accuracy. There were 139 total good matches, and 27 total bad matches.
<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/local-feature-matching/results/Notre_Dame_eval.jpg" width="90%"/>
</p>

<p align="center">
<img src="https://github.com/alihassan1/mini_projects/blob/master/local-feature-matching/results/Notre_Dame_vis_arrows.jpg" width="90%"/>
</p>

## References
[1] Project 2: Local Feature Matching (James Hays) (http://www.cc.gatech.edu/~hays/compvision/proj2/).
[2] Szeliski. Computer Vision: Algorithms and Applications. (http://szeliski.org/Book/drafts/SzeliskiBook_20100903_draft.pdf).
[3] David G. Lowe. Distinctive Image Features from Scale-Invariant Keypoints (www.cs.ubc.ca/~lowe/papers/ijcv04.pdf).
