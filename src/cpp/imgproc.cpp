#include "imgproc.h"
#include <iostream>
#include <stdio.h>
// Note: I put some function that not belong the imgproc module.
// This is just because I wrap those function in same time.
// TODO: Reconstruct the file, correct the module function

using namespace std;

cv::Point* setPoint(int x, int y)
{
    cv::Point *pt = new cv::Point(x, y);
    return pt;
}
/*
cv::Mat** split(const cv::Mat *src)
{
  
    cv::Mat** imageArray = new cv::Mat*[src->channels()];
    //cv::Mat imageArrayTemp[src->channels()];
    cv::Mat** imageArrayTemp = new cv::Mat*[src->channels()];
    cv::split(*src, imageArrayTemp);
  
    for (int i = 0; i < src->channels(); i++)
      {
        imageArray[i] = new cv::Mat;
        imageArrayTemp[i].copyTo(*(imageArray[i]));
      }
  
    return imageArray;
    }*/

cv::Mat* blur(cv::Mat *img, int *size, cv::Point *anchor, int borderType)
{
    cv::Mat *result = new cv::Mat();
    cv::blur(*img, *result, cv::Size(5, 5), *anchor, borderType);

    return result;
}

void rectangle(cv::Mat *img, cv::Point *p1, cv::Point *p2, int *color, int thickness, int lineType, int shift)
{
    using namespace cv;
    cv::rectangle(*img, *p1, *p2,  cv::Scalar(color[0], color[1], color[2]));
}

void circle(cv::Mat *img, cv::Point *p1, int radius, int *color, int thickness, int lineType, int shift)
{
    cv::circle(*img, *p1, radius,  cv::Scalar(color[0], color[1], color[2]));
}

void ellipse(cv::Mat *img, cv::Point *p1, double angle, double startAngle, double endAngle, int *color, int thickness, int lineType, int shift)
{
    cv::ellipse(*img, *p1, cv::Size(5, 5), angle, startAngle, endAngle, cv::Scalar(color[0], color[1], color[2]));
}

void line(cv::Mat *img, cv::Point *p1, cv::Point *p2, int *color, int thickness, int lineType, int shift)
{
    cv::line(*img, *p1, *p2,  cv::Scalar(color[0], color[1], color[2]));
}

// C++: void putText(Mat& img, const string& text, Point org, int fontFace, double fontScale, Scalar color, int thickness=1, intlineType=8, bool bottomLeftOrigin=false )
void putText(cv::Mat *img, const char *text, cv::Point *org, int fontFace, double fontScale, int *color, int thickness, int lineType, int bottomLeftOrigin)
{
    // Reconvert int to bool
    bool bLO = false;
    if (bottomLeftOrigin == 1)
        bLO = true;
    cv::putText(*img, cv::String(text), *org, fontFace, fontScale, cv::Scalar(color[0], color[1], color[2]), thickness, lineType, bLO);
}

void polylines(cv::Mat *img, cv::Point **pts, int npts, bool isClosed, int *color, int thickness, int lineType, int shift)
{
    using namespace cv;
    vector<Point> contour;
    for (int i = 0; i < npts; i++)
        contour.push_back(*pts[i]);

    // create a pointer to the data as an array of points (via a conversion to 
    // a Mat() object)
    const cv::Point *ptsx = (const cv::Point*) Mat(contour).data;

    cv::polylines(*img, &ptsx, &npts, 1, isClosed, Scalar(color[0],  color[1], color[2]), thickness, lineType, shift);
}

int* calcHist(const cv::Mat** images, int nimages, const int* channels, cv::Mat *mask, int dims, const int* histSize, const double* ranges, bool uniform, bool accumulate)
{
    cv::Mat *hist = new cv::Mat();

    float* histRanges = new float[nimages];

    // multiple to 2 is because every image range has two value
    for (int i = 0; i < nimages * 2; i++)
        histRanges[i] = (float)ranges[i];

    const float* const_histRanges = histRanges;

    using namespace cv;
  
     // Compute the histograms:
    calcHist( *images, nimages, channels, *mask, *hist, 1, histSize, &const_histRanges, uniform, accumulate);  

    // Copy the histogram to an int array
    // TODO: use int as arrary's type is just for test, it will correct later

    int *histArray = new int[*histSize];
    float* data = hist->ptr<float>(0);
    for ( int i = 0; i < *histSize; i++)
        histArray[i] = *data++;
  
     return histArray;
}
