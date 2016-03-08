#ifndef VIDEOIO_H
#define VIDEOIO_H

#include "opencv2/videoio.hpp"

using namespace cv;

extern "C" VideoCapture *createVideoCapture();
extern "C" VideoCapture *createVideoCaptureWithDevice(int);
extern "C" VideoCapture *createVideoCaptureWithFile(char *);
extern "C" void freeVideoCapture(VideoCapture *);

extern "C" int videoCaptureOpenWithFile(VideoCapture *, char *);
extern "C" int videoCaptureOpenWithDevice(VideoCapture *, int);
extern "C" int videoCaptureIsOpened(VideoCapture *);
extern "C" void videoCaptureRelease(VideoCapture *);
extern "C" int videoCaptureGrab(VideoCapture *);
extern "C" int videoCaptureRetrieve(VideoCapture *, _OutputArray *, int);
extern "C" int videoCaptureRead(VideoCapture *, _OutputArray *);
extern "C" int videoCaptureSet(VideoCapture *, int, double);
extern "C" double videoCaptureGet(VideoCapture *, int);
extern "C" void videoCaptureShiftOperatorWithMat(VideoCapture *, Mat *);

#endif // VIDEOIO_H
