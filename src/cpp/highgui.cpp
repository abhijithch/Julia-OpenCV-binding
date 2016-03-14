#include "highgui.h"
#include <iostream>

using namespace std;

cv::Mat* imread(char *filename)
{
  cv::Mat img = cv::imread(filename);
  cv::Mat *image = new cv::Mat();
  img.copyTo(*image);

  return image;
}

void imshow(char *winName, cv::Mat* mat)
{
  if (!mat->empty())
    {
      cv::imshow(winName, *mat);
    }
  else
    {
      cout << "Empty image" << endl;
    }
}

void waitKey(int delay)
{
  cv::waitKey(delay);
}

void namedWindow(char *winname, int flags)
{
  cv::namedWindow(winname);
}

void imclose(char *winName)
{
  cv::destroyWindow(winName);
}

