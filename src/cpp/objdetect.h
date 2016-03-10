// objdetect.h

#include <opencv2/objdetect/objdetect.hpp>

extern "C" cv::CascadeClassifier* createCascadeClassifier();
extern "C" cv::CascadeClassifier* createCascadeClassifierWithString(char* path);
extern "C" void freeCascadeClassifer(cv::CascadeClassifier* cc);
extern "C" void loadCCFromFile(cv::CascadeClassifier* cc, char* path);
extern "C" cv::HOGDescriptor* createHOGDescriptor();
extern "C" void freeHOGDescriptor(cv::HOGDescriptor *);
extern "C" void setSVMDetector(cv::HOGDescriptor *hg, cv::_InputArray *_svmdetector);

// C++: detectMultiScale(InputArray img, std::vector< Rect > & foundLocations, std::vector< double > & foundWeights, double hitThreshold = 0, Size winStride = Size(), Size padding = Size(), double scale = 1.05, double finalThreshold = 2.0, bool useMeanshiftGrouping = false)
extern "C" cv::Rect **detectMultiScaleHOG(cv::HOGDescriptor* hog, cv::_InputArray *img,
					  double **fWeights, double hitThreshold,
					  cv::Size *wins, cv::Size* pads, double scale,
					  double finalThreshold, int useMeanshiftGrouping,
					  int *nrecs, int *nfw);

extern "C" void getDefaultPeopleDetector(cv::HOGDescriptor* hog, float* out, int* n_out);
extern "C" void getDaimlerPeopleDetector(cv::HOGDescriptor* hog, float* out, int* n_out);


//     CV_WRAP_AS(detectMultiScale2) void detectMultiScale( InputArray image,
//                           CV_OUT std::vector<Rect>& objects,
//                           CV_OUT std::vector<int>& numDetections,
//                           double scaleFactor=1.1,
//                           int minNeighbors=3, int flags=0,
//                           Size minSize=Size(),
//                           Size maxSize=Size() );

extern "C" cv::Rect **detectMultiScaleCC1(cv::CascadeClassifier *cc, cv::_InputArray *image,
					  int **numDetections, double scaleFactor,
					  int minNeighbors, int flags,
					  cv::Size *minSize, cv::Size *maxSize, int *nrecs,
					  int *ndetects);

//     CV_WRAP_AS(detectMultiScale3) void detectMultiScale( InputArray image,
//                                   CV_OUT std::vector<Rect>& objects,
//                                   CV_OUT std::vector<int>& rejectLevels,
//                                   CV_OUT std::vector<double>& levelWeights,
//                                   double scaleFactor = 1.1,
//                                   int minNeighbors = 3, int flags = 0,
//                                   Size minSize = Size(),
//                                   Size maxSize = Size(),
//                                   bool outputRejectLevels = false );

extern "C" cv::Rect **detectMultiScaleCC2(cv::CascadeClassifier *cc, cv::_InputArray *image,
					  int **rejectLevels, double **levelWeights,
					  double scaleFactor, int minNeighbors, int flags,
					  cv::Size *minSize, cv::Size *maxSize,
					  int outputRejectLevels,
					  int *nrecs, int *nrl, int *nlw);
