// objdetect.cpp

#include "objdetect.h"

cv::CascadeClassifier* createCascadeClassifier()
{
    return new cv::CascadeClassifier();
}

cv::CascadeClassifier* createCascadeClassifierWithString(char *path)
{
    return new cv::CascadeClassifier(path);
}

void freeCascadeClassifier(cv::CascadeClassifier* cc)
{
    delete cc;
}

void loadCCFromFile(cv::CascadeClassifier* cc, char* path)
{
    cc->load(path);
}

cv::HOGDescriptor* createHOGDescriptor()
{
    return new cv::HOGDescriptor();
}

void freeHOGDescriptor(cv::HOGDescriptor *hgd)
{
    delete hgd;
}

void setSVMDetector(cv::HOGDescriptor *hg, cv::_InputArray *svmdetector)
{
    hg->setSVMDetector(*svmdetector);
}

void setSVMDetectorWithFloatArray(cv::HOGDescriptor *hg, float *array, int len)
{
    std::vector<float> vec;
    vec.assign(array, array + len);
    hg->setSVMDetector(cv::InputArray(vec));
}

cv::Rect **detectMultiScaleHOG(cv::HOGDescriptor* hog, cv::_InputArray *img, 
			       double **fWeights, double hitThreshold, cv::Size* wins,
			       cv::Size* pads, double scale, double finalThreshold,
			       int useMeanshiftGrouping, int *nrecs, int *nfw)
{
    std::vector<cv::Rect> foundLocations;
    std::vector<double> foundWeights;

    hog->detectMultiScale(*img, foundLocations, foundWeights, hitThreshold, *wins, 
			  *pads, scale, finalThreshold, useMeanshiftGrouping!=0);

    *nrecs = foundLocations.size();
    if (*nrecs == 0) {
	*fWeights = NULL;
	*nfw = 0;
	return NULL;
    }
    cv::Rect **ret = (cv::Rect **)malloc(sizeof(cv::Rect *) * (*nrecs));
    for (int i = 0; i < *nrecs; i++) {
	ret[i] = new cv::Rect(foundLocations.at(i));
    }

    *nfw = foundWeights.size();
    *fWeights = (double *)malloc(sizeof(double) * (*nfw));
    for (int i = 0; i < *nfw; i++) {
	(*fWeights)[i] = foundWeights.at(i);
    }
    return ret;
}

float *getPeopleDetector(std::vector<float> outer, int *nout)
{
    *nout = outer.size();
    float *out = (float *)malloc(sizeof(float) * (*nout));
    for (int i = 0; i < *nout; i++) {
	out[i] = outer.at(i);
    }
    return out;
}

float *getDefaultPeopleDetector(cv::HOGDescriptor *hog, int *nout)
{
    std::vector<float> outer;
    outer = hog->getDefaultPeopleDetector();
    return getPeopleDetector(outer, nout);
}

float *getDaimlerPeopleDetector(cv::HOGDescriptor* hog, int *nout)
{
    std::vector<float> outer;
    outer = hog->getDaimlerPeopleDetector();
    return getPeopleDetector(outer, nout);
}

cv::Rect **detectMultiScaleCC1(cv::CascadeClassifier *cc, cv::_InputArray *image,
			       int **numDetections, double scaleFactor,
			       int minNeighbors, int flags,
			       cv::Size *minSize, cv::Size *maxSize, int *nrecs, int *ndetects)
{
    std::vector<cv::Rect> objects;
    std::vector<int> numDetectionsVec;
    cc->detectMultiScale(*image, objects, numDetectionsVec, scaleFactor, minNeighbors,
			 flags, *minSize, *maxSize);

    *nrecs = objects.size();
    cv::Rect **ret = (cv::Rect **)malloc(sizeof(cv::Rect *) * (*nrecs));
    for (int i = 0; i < *nrecs; i++) {
	ret[i] = new cv::Rect(objects.at(i));
    }

    *ndetects = numDetectionsVec.size();
    *numDetections = (int *)malloc(sizeof(int) * (*ndetects));
    for (int i = 0; i < *ndetects; i++) {
	*numDetections[i] = numDetectionsVec.at(i);
    }
    return ret;
}

cv::Rect **detectMultiScaleCC2(cv::CascadeClassifier *cc, cv::_InputArray *image,
			       int **rejectLevels, double **levelWeights,
			       double scaleFactor, int minNeighbors, int flags,
			       cv::Size *minSize, cv::Size *maxSize, int outputRejectLevels,
			       int *nrecs, int *nrl, int *nlw)
{
    std::vector<cv::Rect> objects;
    std::vector<int> rejectLevelsVec;
    std::vector<double> levelWeightsVec;
    cc->detectMultiScale(*image, objects, rejectLevelsVec, levelWeightsVec,
			 scaleFactor, minNeighbors, flags, *minSize, *maxSize,
			 outputRejectLevels != 0);

    *nrecs = objects.size();
    cv::Rect **ret = (cv::Rect **)malloc(sizeof(cv::Rect *) * (*nrecs));
    for (int i = 0; i < *nrecs; i++) {
	ret[i] = new cv::Rect(objects.at(i));
    }

    *nrl = rejectLevelsVec.size();
    *rejectLevels = (int *)malloc(sizeof(int) * (*nrl));
    for (int i = 0; i < *nrl; i++) {
	*rejectLevels[i] = rejectLevelsVec.at(i);
    }

    *nlw = levelWeightsVec.size();
    *levelWeights = (double *)malloc(sizeof(double) * (*nlw));
    for (int i = 0; i < *nlw; i++) {
	*levelWeights[i] = levelWeightsVec.at(i);
    }

    return ret;
}
