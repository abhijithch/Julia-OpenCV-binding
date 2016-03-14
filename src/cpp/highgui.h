#ifndef HIGHGUI_H
#define HIGHGUI_H

#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"

extern "C" cv::Mat* imread(char *filename);
extern "C" void imshow(char *winName, cv::Mat *mat);
extern "C" void waitKey(int delay);
extern "C" void namedWindow(char *winname, int flags);
extern "C" void imclose(char *winName);

#endif
