#include "core.h"
#include "iostream"

using namespace std;

void minMaxLoc(cv::_InputArray *src, double *minVal, double *maxVal,
	       cv::Point *minLoc, cv::Point *maxLoc, cv::_InputArray *mask)
{
  cv::minMaxLoc(*src, minVal, maxVal, minLoc, maxLoc, *mask);
}
