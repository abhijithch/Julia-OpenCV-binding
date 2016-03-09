#ifndef CORE_H
#define CORE_H

#include "opencv2/core/core.hpp"

extern "C" void minMaxLoc(cv::_InputArray *src, double *minVal, double *maxVal, cv::Point *minLoc, cv::Point *maxLoc, cv::_InputArray *mask);

#endif

