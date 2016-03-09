#include "highgui.h"
#include <iostream>

using namespace std;

// C++: void cv::namedWindow(const String & winname,int flags = WINDOW_AUTOSIZE)

void namedWindow(char *winname, int flags)
{
  cv::namedWindow(winname);
}
