#ifndef TRACKING_H
#define TRACKING_H

#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/tracking/tracking.hpp"

//extern "C" void KalmanFilter();

extern "C" cv::Mat* correct(cv::Mat *measurement);

extern "C" cv::Mat* predict();
