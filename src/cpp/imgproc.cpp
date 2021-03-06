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

void freePoint(cv::Point *ptr)
{
    delete ptr;
}

cv::Mat** split(const cv::Mat *src)
{
    cv::Mat** imageArray = new cv::Mat*[src->channels()];
    cv::Mat* imageArrayTemp = new cv::Mat[src->channels()];
    cv::split(*src, imageArrayTemp);

    for (int i = 0; i < src->channels(); i++)
    {
        imageArray[i] = new cv::Mat;
        imageArrayTemp[i].copyTo(*(imageArray[i]));
    }
    delete [] imageArrayTemp;
    return imageArray;
}

cv::Mat* blur(cv::Mat *img, int *size, cv::Point *anchor, int borderType)
{
    cv::Mat *result = new cv::Mat();
    cv::blur(*img, *result, cv::Size(5, 5), *anchor, borderType);

    return result;
}

void rectangle(cv::Mat *img, cv::Point *p1, cv::Point *p2, int *color,
	       int thickness, int lineType, int shift)
{
    cv::rectangle(*img, *p1, *p2, cv::Scalar(color[0], color[1], color[2]),
		  thickness, lineType, shift);
}

void rectangleWithRect(cv::Mat *img, cv::Rect *r, int *color,
		       int thickness, int lineType, int shift)
{
    cv::rectangle(*img, *r, cv::Scalar(color[0], color[1], color[2]),
		  thickness, lineType, shift);
}

void circle(cv::Mat *img, cv::Point *p1, int radius, int *color, int thickness,
	    int lineType, int shift)
{
    cv::circle(*img, *p1, radius,  cv::Scalar(color[0], color[1], color[2]));
}

void ellipse(cv::Mat *img, cv::Point *p1, double angle, double startAngle,
	     double endAngle, int *color, int thickness, int lineType, int shift)
{
    cv::ellipse(*img, *p1, cv::Size(5, 5), angle, startAngle, endAngle,
		cv::Scalar(color[0], color[1], color[2]));
}

void line(cv::Mat *img, cv::Point *p1, cv::Point *p2, int *color, int thickness,
	  int lineType, int shift)
{
    cv::line(*img, *p1, *p2,  cv::Scalar(color[0], color[1], color[2]));
}

void putText(cv::Mat *img, const char *text, cv::Point *org, int fontFace,
	     double fontScale, int *color, int thickness, int lineType,
	     int bottomLeftOrigin)
{
    // Reconvert int to bool
    bool bLO = false;
    if (bottomLeftOrigin == 1)
        bLO = true;
    cv::putText(*img, cv::String(text), *org, fontFace, fontScale,
		cv::Scalar(color[0], color[1], color[2]), thickness,
		lineType, bLO);
}

void polylines(cv::Mat *img, cv::Point **pts, int npts, bool isClosed,
	       int *color, int thickness, int lineType, int shift)
{
    using namespace cv;
    std::vector<Point> contour;
    for (int i = 0; i < npts; i++)
        contour.push_back(*pts[i]);

    // create a pointer to the data as an array of points (via a conversion to 
    // a Mat() object)
    const cv::Point *ptsx = (const cv::Point*) Mat(contour).data;

    cv::polylines(*img, &ptsx, &npts, 1, isClosed,
		  Scalar(color[0], color[1], color[2]),
		  thickness, lineType, shift);
}

int* calcHist(const cv::Mat** images, int nimages, const int* channels,
	      cv::Mat *mask, int dims, const int* histSize,
	      const double* ranges, bool uniform, bool accumulate)
{
    cv::Mat *hist = new cv::Mat();

    float* histRanges = new float[nimages];

    // multiple to 2 is because every image range has two value
    for (int i = 0; i < nimages * 2; i++)
        histRanges[i] = (float)ranges[i];

    const float* const_histRanges = histRanges;

     // Compute the histograms:
    cv::calcHist(*images, nimages, channels, *mask, *hist, 1, histSize,
		 &const_histRanges, uniform, accumulate);  

    // Copy the histogram to an int array
    // TODO: use int as arrary's type is just for test, it will correct later

    int *histArray = new int[*histSize];
    float* data = hist->ptr<float>(0);
    for ( int i = 0; i < *histSize; i++)
        histArray[i] = *data++;
  
     return histArray;
}

void cvtColor(cv::_InputArray *src, cv::_OutputArray *dst, int code, int dstCn)
{
    cv::cvtColor(*src, *dst, code, dstCn);
}

void Sobel(cv::_InputArray *src, cv::_OutputArray *dst, int ddepth, int dx,
	   int dy, int ksize, double scale, double delta, int borderType)
{
    cv::Sobel(*src, *dst, ddepth, dx, dy, ksize, scale, delta, borderType);
}

void filter2D(cv::_InputArray *src, cv::_OutputArray *dst, int ddepth,
	      cv::_InputArray *kernel, cv::Point *anchor, double delta,
	      int borderType)
{
    cv::filter2D(*src, *dst, ddepth, *kernel, *anchor, delta, borderType);
}

void resize(cv::_InputArray *src, cv::_OutputArray *dst, int *dsize, double fx,
	    double fy, int interpolation)
{
    cv::resize(*src, *dst, cv::Size(dsize[0],dsize[1]), fx, fy, interpolation);
}

double threshold(cv::_InputArray *src, cv::_OutputArray *dst, double thresh,
		 double maxval, int type)
{
    return cv::threshold(*src, *dst, thresh, maxval, type);
}

void HoughLines(cv::_InputArray *image, cv::_OutputArray *lines, double rho,
		double theta, int threshold, double srn, double stn)
{
    cv::HoughLines(*image, *lines, rho, theta, threshold, srn, stn);
}

void equalizeHist(cv::_InputArray *src, cv::_OutputArray *dst)
{
    cv::equalizeHist(*src, *dst);
}

void Canny(cv::_InputArray *image, cv::_OutputArray *edges, double thresh1,
	   double thresh2, int apertureSize, int L2gradient)
{
    bool thing = (bool)(L2gradient);
    cv::Canny(*image, *edges, thresh1, thresh2, apertureSize, thing);
}

void GaussianBlur(cv::_InputArray *src, cv::_OutputArray *dst, int *ksize,
		  double sigmaX, double sigmaY, int borderType)
{
    cv::GaussianBlur(*src, *dst, cv::Size(ksize[0],ksize[1]),
		     sigmaX, sigmaY, borderType);
}

void HoughLinesP(cv::_InputArray *image, cv::_OutputArray *lines,
		 double rho, double theta, int threshold, double minLineLength,
		 double maxLineGap)
{
    cv::HoughLinesP(*image, *lines, rho, theta,
		    threshold, minLineLength, maxLineGap);
}

float *HoughLinesPVec4f(cv::_InputArray *arr, double rho, double theta,
			int threshold, double minLineLength, double maxLineGap,
			int *len)
{
    std::vector<cv::Vec4f> lines;
    cv::HoughLinesP(*arr, lines, rho, theta, threshold,
		    minLineLength, maxLineGap);
    *len = lines.size();
    const int veclen = 4;
    float *ret = (float *)malloc(sizeof(float) * veclen * (*len));
    int count = 0;
    for (int i = 0; i < *len; i++) {
	for (int j = 0; j < veclen; j ++) {
	    ret[count] = lines[i][j];
	    count++;
	}
    }
    return ret;
}

cv::Size* createSize()
{
    return new cv::Size();
}

cv::Size* createSizeWithIntArgs(int w, int h)
{
    return new cv::Size(w,h);
}

cv::Size* createSizeWithDoubleArgs(double w, double h)
{
    return new cv::Size(w,h);
}

void freeSize(cv::Size* s)
{
    delete s;
}
