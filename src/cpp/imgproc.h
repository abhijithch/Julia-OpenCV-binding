#ifndef IMGPROC_H
#define IMGPROC_H

#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"

extern "C" cv::Point* setPoint(int x, int y);
extern "C" void freePoint(cv::Point *);

// C++: void blur( const Mat& src, Mat& dst, Size ksize, Point anchor=Point(-1,-1), int borderType=BORDER DEFAULT );
extern "C" cv::Mat* blur(cv::Mat *img, int *size, cv::Point *anchor, int borderType);

// C++: void polylines(Mat& img, const Point** pts, const int* npts, int ncontours, bool isClosed, const Scalar& color, int thickness=1, int lineType=8, int shift=0 )
extern "C" void polylines(cv::Mat *img, cv::Point **pts, int npts, bool isClosed, int *color, int thickness, int lineType, int shift);

// C++: void line(Mat& img, Point pt1, Point pt2, const Scalar& color, int thickness=1, int lineType=8, int shift=0)
extern "C" void line(cv::Mat *img, cv::Point *p1, cv::Point *p2, int *color, int thickness,int lineType, int shift);

// C++: void rectangle(Mat& img, Point pt1, Point pt2, const Scalar& color, int thickness=1, int lineType=8, int shift=0)
extern "C" void rectangle(cv::Mat *img, cv::Point *p1, cv::Point *p2, int *color, int thickness,int lineType, int shift);

// C++: void circle(Mat& img, Point center, int radius, const Scalar& color, int thickness=1, int lineType=8, int shift=0)
extern "C" void circle(cv::Mat *img, cv::Point *p1, int radius, int *color, int thickness,int lineType, int shift);

// C++: void ellipse(Mat& img, Point center, Size axes, double angle, double startAngle, double endAngle, const Scalar& color, int thickness=1, int lineType=8, int shift=0)
extern "C" void ellipse(cv::Mat *img, cv::Point *p1, double angle, double startAngle, double endAngle, int *color, int thickness,int lineType, int shift);

// C++: void putText(Mat& img, const string& text, Point org, int fontFace, double fontScale, Scalar color, int thickness=1, int lineType=8, bool bottomLeftOrigin=false )
extern "C" void putText(cv::Mat *img, const char *text, cv::Point *org, int fontFace, double fontScale, int *color, int thickness, int lineType, int bottomLeftOrigin);

// C++: void calcHist(const Mat* images, int nimages, const int* channels, InputArray mask, OutputArray hist, int dims, const int* histSize, const float** ranges, bool uniform=true, bool accumulate=false )
extern "C" int* calcHist(const cv::Mat** images, int nimages, const int* channels, cv::Mat *mask, int dims, const int* histSize, const double* ranges, bool uniform, bool accumulate);

// C++: void split(const Mat& src, Mat* mvbegin)
extern "C" cv::Mat** split(const cv::Mat *src);

// C++: void cvtColor(InputArray src, OutputArray dst, int code, int dstCn=0)
extern "C" void cvtColor(cv::_InputArray *src, cv::_OutputArray *dst,
			 int code, int dstCn);

// C++: void cv::Sobel(InputArray src, OutputArray dst, int ddepth, int dx, int dy, int ksize = 3, double scale = 1, double delta = 0, int borderType = BORDER_DEFAULT)
extern "C" void Sobel(cv::_InputArray *src, cv::_OutputArray *dst, int ddepth, int dx, int dy, int ksize, double scale, double delta, int borderType);

// C++: void filter2D(InputArray src, OutputArray dst, int ddepth, InputArray kernel, Point anchor=Point(-1,-1), double delta=0, intborderType=BORDER_DEFAULT)
extern "C" void filter2D(cv::_InputArray *src, cv::_OutputArray *dst, int ddepth, cv::_InputArray *kernel, cv::Point *anchor, double delta, int borderType);
#endif
