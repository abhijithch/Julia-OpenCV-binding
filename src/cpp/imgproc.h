#ifndef IMGPROC_H
#define IMGPROC_H

#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"

extern "C" cv::Point* setPoint(int x, int y);
extern "C" void freePoint(cv::Point *);
extern "C" cv::Mat* blur(cv::Mat *img, int *size, cv::Point *anchor,
			 int borderType);
extern "C" void polylines(cv::Mat *img, cv::Point **pts, int npts,
			  bool isClosed, int *color, int thickness,
			  int lineType, int shift);
extern "C" void line(cv::Mat *img, cv::Point *p1, cv::Point *p2,
		     int *color, int thickness,int lineType, int shift);
extern "C" void rectangle(cv::Mat *img, cv::Point *p1, cv::Point *p2,
			  int *color, int thickness,int lineType, int shift);
extern "C" void rectangleWithRect(cv::Mat *img, cv::Rect *r, int *color,
				  int thickness, int lineType, int shift);
extern "C" void circle(cv::Mat *img, cv::Point *p1, int radius, int *color,
		       int thickness,int lineType, int shift);
extern "C" void ellipse(cv::Mat *img, cv::Point *p1, double angle,
			double startAngle, double endAngle, int *color,
			int thickness,int lineType, int shift);
extern "C" void putText(cv::Mat *img, const char *text, cv::Point *org,
			int fontFace, double fontScale, int *color,
			int thickness, int lineType, int bottomLeftOrigin);
extern "C" int* calcHist(const cv::Mat** images, int nimages,
			 const int* channels, cv::Mat *mask, int dims,
			 const int* histSize, const double* ranges,
			 bool uniform, bool accumulate);
extern "C" cv::Mat** split(const cv::Mat *src);
extern "C" void cvtColor(cv::_InputArray *src, cv::_OutputArray *dst,
			 int code, int dstCn);
extern "C" void Sobel(cv::_InputArray *src, cv::_OutputArray *dst, int ddepth,
		      int dx, int dy, int ksize, double scale, double delta,
		      int borderType);
extern "C" void filter2D(cv::_InputArray *src, cv::_OutputArray *dst,
			 int ddepth, cv::_InputArray *kernel, cv::Point *anchor,
			 double delta, int borderType);
extern "C" void resize(cv::_InputArray *src, cv::_OutputArray *dst, int *dsize,
		       double fx, double fy, int interpolation);
extern "C" double threshold(cv::_InputArray *src, cv::_OutputArray *dst,
			    double thresh, double maxval, int type);
extern "C" void HoughLines(cv::_InputArray *image, cv::_OutputArray *lines,
			   double rho, double theta, int threshold,
			   double srn, double stn);
extern "C" void equalizeHist(cv::_InputArray *src, cv::_OutputArray *dst);
extern "C" void Canny(cv::_InputArray *image, cv::_OutputArray *edges,
		      double thresh1, double thresh2, int apertureSize,
		      int L2gradient);
extern "C" void GaussianBlur(cv::_InputArray *src, cv::_OutputArray *dst,
			     int *ksize, double sigmaX, double sigmaY,
			     int borderType);
extern "C" void HoughLinesP(cv::_InputArray *image, cv::_OutputArray *lines,
			    double rho, double theta, int threshold,
			    double minLineLength, double maxLineGap);
extern "C" float *HoughLinesPVec4f(cv::_InputArray *arr, double rho,
				   double theta, int threshold,
				   double minLineLength, double maxLineGap,
				   int *len);
extern "C" cv::Size* createSize();
extern "C" cv::Size* createSizeWithIntArgs(int w, int h);
extern "C" cv::Size* createSizeWithDoubleArgs(double w, double h);
extern "C" void freeSize(cv::Size* s);
#endif
