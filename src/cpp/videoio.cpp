#include "videoio.h"
#include <iostream>

using namespace std;

VideoCapture *createVideoCapture()
{
    return new VideoCapture();
}

VideoCapture *createVideoCaptureWithDevice(int device)
{
    return new VideoCapture(device);
}

VideoCapture *createVideoCaptureWithFile(char *file)
{
    return new VideoCapture(string(file));
}

void freeVideoCapture(VideoCapture *v)
{
    delete v;
}

#define GET_C_BOOL(x) ((x) ? 1 : 0)

int videoCaptureOpenWithFile(VideoCapture *v, char *file)
{
    return GET_C_BOOL(v->open(string(file)));
}

int videoCaptureOpenWithDevice(VideoCapture *v, int device)
{
    return GET_C_BOOL(v->open(device));
}

int videoCaptureIsOpened(VideoCapture *v)
{
    return GET_C_BOOL(v->isOpened());
}

void videoCaptureRelease(VideoCapture *v)
{
    v->release();
}

int videoCaptureGrab(VideoCapture *v)
{
    return GET_C_BOOL(v->grab());
}

int videoCaptureRetrieve(VideoCapture *v, _OutputArray *arr, int flag)
{
    return GET_C_BOOL(v->retrieve(*arr, flag));
}

int videoCaptureRead(VideoCapture *v, _OutputArray *arr)
{
    return GET_C_BOOL(v->read(*arr));
}

int videoCaptureSet(VideoCapture *v, int propId, double value)
{
    return GET_C_BOOL(v->set(propId, value));
}

double videoCaptureGet(VideoCapture *v, int propId)
{
    return v->get(propId);
}

void videoCaptureShiftOperatorWithMat(VideoCapture *v, Mat *img)
{
    (*v) >> (*img);
}

