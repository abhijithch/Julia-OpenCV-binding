#include "tracking.h"
#include <iostream>

using namespace std;

cv::KalmanFilter* createKalmanFilterWithArgs(int dynamParams, int measureParams, int controlParam, int type)
{
  return new cv::KalmanFilter(dynamParams, measureParams, controlParam, type);
}

cv::KalmanFilter* createKalmanFilter()
{
  return new cv::KalmanFilter();
}


void freeKalmanFilter(cv::KalmanFilter *kf)
{
  delete kf;
}

cv::Mat* correct(cv::KalmanFilter *kf, const cv::Mat *measurement)
{
  return new cv::Mat(kf->correct(*measurement));
}

cv::Mat* predict(cv::KalmanFilter *kf, const cv::Mat *control)
{
  return new cv::Mat(kf->predict(*control));
}
