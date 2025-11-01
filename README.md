MATLAB Image Processing for Grayscale Images: Chromosome and Character Analysis
This repository contains MATLAB code and documentation for processing 64x64 grayscale images (32 levels, encoded as 0-9 and A-V). The project demonstrates common computer vision techniques including image loading, grayscale visualization, binarization (thresholding), skeleton extraction, contour detection, connected component labeling, character arrangement, and rotation. It is based on an experiment to master image preprocessing and morphological analysis in machine vision.
The project processes two images:

Image 1 (chromo): Chromosome image for segmentation and analysis.
Image 2 (charact1): Character image for segmentation, labeling, and manipulation.

Results include visualizations and optimized outputs, with a focus on handling uneven backgrounds and improving segmentation accuracy using morphological corrections.

📦 Project Overview
The goal is to implement a pipeline for grayscale image processing using MATLAB:

Read and display 32-level grayscale images from text files.
Apply Otsu thresholding for binarization, with optimizations for uneven lighting.
Extract skeletons (one-pixel thin) and outlines.
Label connected components.
Arrange and rotate characters (for Image 2).

Key challenges addressed:

Uneven background in chromosome image leading to mis-segmentation (resolved via median filtering, morphological opening, and contrast adjustment).
Character segmentation and manual ordering for arrangement.

This serves as a foundation for further machine learning-based pattern recognition.

🗂️ Project Structure
The repository is organized as follows:

outputs/: Core code and output files.

char_arrangeLine.m: Function to arrange characters into a line.
char_pipeline.m: Pipeline script for processing Image 2 (characters).
charact1.txt: Input text file for Image 2.
chromo.txt: Input text file for Image 1.
chromo_pipeline.m: Pipeline script for processing Image 1 (chromosomes).
loadTextImage.m: Utility to load grayscale images from text files.
Prj_Computer - Examples.pdf: Example PDF document (possibly reference or output).
Prj_Computer - MES405_2025.pdf: Project report PDF (full documentation).
run_me5405.m: Main script to run the entire experiment.
utils/: Utility functions (e.g., util_display.m, util_outline_skeleton_label.m, util_threshold.m).


LICENSE: MIT License (or your choice; add one if missing).
README.md: This file.

Generated images (e.g., binary, skeleton, labeled) are referenced in the report but can be reproduced by running the code.

🚀 Setup and Usage
Prerequisites

MATLAB (tested on R2023a or later).
Image Processing Toolbox (required for functions like graythresh, imbinarize, bwmorph, bwperim, bwconncomp).

No additional installations needed, as all code uses built-in MATLAB functions.
Installation

Clone the repository:
textgit clone https://github.com/Yunchen-Cai/MATLAB-Image-Processing-Grayscale.git  # Replace with your repo URL
cd MATLAB-Image-Processing-Grayscale

Open MATLAB and navigate to the repository folder.

Running the Code

Main Script: Run run_me5405.m to execute the full pipeline for both images.

This will load inputs, perform processing, and display/save results (e.g., img1_original.png, img2_binary.png).


Individual Pipelines:

For chromosomes: Run chromo_pipeline.m.
For characters: Run char_pipeline.m.


Custom Usage:

Load a text file: img = loadTextImage('chromo.txt');
Binarize: Use util_threshold.m with Otsu and optimizations.
Extract skeleton: bwmorph(BW, 'skel', Inf);
Arrange characters: Call char_arrangeLine(img, indices); (manual indices from labeling).



Outputs will be displayed in MATLAB figures and can be saved using imwrite.
Example Output

Original grayscale images.
Binary images (with and without optimizations).
Skeletons, outlines, and labeled components.
Arranged and rotated character lines (e.g., "AB123C" rotated by 30°).

Refer to "Prj_Computer - MES405_2025.pdf" for detailed results and discussions.

📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙏 Acknowledgments

Based on experiment requirements for Mechanical Engineering image processing.
Special thanks to MATLAB for the Image Processing Toolbox.

For questions or contributions, open an issue on GitHub.
