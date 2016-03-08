#ifndef TRACKING_H
#define TRACKING_H

#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/video/tracking.hpp"

//extern "C" void KalmanFilter();

extern "C" cv::KalmanFilter* createKalmanFilterWithArgs(int dynamParams, int measureParams, int controlParam, int type);

extern "C" cv::KalmanFilter* createKalmanFilter();

extern "C" void freeKalmanFilter(cv::KalmanFilter *);

extern "C" cv::Mat* correct(cv::KalmanFilter *kf, const cv::Mat *measurement);

extern "C" cv::Mat* predict(cv::KalmanFilter *kf, const cv::Mat *control);

#endif
