#include "tracking.h"
#include <iostream>

using namespace std;

cv::Mat* correct(cv::Mat *measurement)
{
    cv::KalmanFilter::correct(*measurement)
}

cv::Mat* predict()
{
    cv::Mat *control = new cv::Mat();
    cv::KalmanFilter::predict(*control)
}
