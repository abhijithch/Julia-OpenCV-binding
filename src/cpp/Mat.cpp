#include "Mat.h"
#include "iostream"

using namespace std;
// Mat function
//=============

// C++: Mat::Mat();
// Done
cv::Mat* createMat1()
{
    return new cv::Mat();
}

// C++: Mat::Mat(int rows, int cols, int type);
// Done
cv::Mat* createMat2(int rows, int cols, int type)
{
    return new cv::Mat(rows, cols, type);
}

void freeMat(cv::Mat *m)
{
    delete m;
}

/*
// C++: Mat::Mat(Size size, int type);
cv::Mat* createMat3(cv::Size size, int type)
{
}
*/

// C++: Mat::Mat(int rows, int cols, int type, Scalar s);
// cv::Mat* createMat4(int rows, int cols, int type, cv::Scalar s)
// {
// }

/*
// C++: Mat::Mat(Size size, int type, Scalar s);
cv::Mat* createMat5(cv::Size size, int type, cv::Scalar s)
{
}

// C++: Mat::Mat(Mat m, Range rowRange, Range colRange = Range::all(););
cv::Mat* createMat6(cv::Mat *m, cv::Range rowRange, cv::Range colRange)
{
}

// Mat::Mat(m, rowRange);
cv::Mat* createMat7(cv::Mat m, cv::Range cv::rowRange)
{
}

// C++: Mat::Mat(Mat m, Rect roi);
cv::Mat* createMat8(cv::Mat m, Rect roi)
{
}
*/

// C++: Mat Mat::adjustROI(int dtop, int dbottom, int dleft, int dright);
cv::Mat* adjustROI(cv::Mat *mat, int dtop, int dbottom, int dleft, int dright)
{
    return new cv::Mat(mat->adjustROI(dtop, dbottom, dleft, dright));
}

// C++: void Mat::assignTo(Mat m, int type = -1);
void assignTo(cv::Mat *dst, cv::Mat *src, int type)
{
    src->assignTo(*dst, type);
}
    
// C++: int Mat::channels();
int channels(cv::Mat* mat)
{
    return mat->channels();
}

int at(cv::Mat *mat, int channel, int i, int j)
{
    cv::Vec3b data = mat->at<cv::Vec3b>(i, j);
    // julia count from one, C++ count from zero
    return data[channel - 1];
}

// C++: Mat Mat::clone();
cv::Mat* cloneInWrap(cv::Mat *mat)
{
    return new cv::Mat(mat->clone());
}

// C++: Mat Mat::col(int x);
// Could not solve it...
// cv::Mat* col(cv::Mat *mat, int x)
// {
//     //return &(mat->col(x));
// }

// C++: Mat Mat::colRange(int startcol, int endcol);
// cv::Mat* colRange1(int startcol, int endcol)
// {
// }
/*
// C++: Mat Mat::colRange(Range r);
cv::Mat* colRange2(cv::Range r)
{
}
*/

// C++: int Mat::dims();
int dims(cv::Mat *mat)
{
    return mat->dims;
}

// C++: int Mat::cols();
int cols(cv::Mat *mat)
{
    return mat->cols;
}

// C++: void Mat::convertTo(Mat& m, int rtype, double alpha = 1, double beta
// = 0);
void convertTo(cv::Mat *dst, cv::Mat *src, int rtype, double alpha, double beta)
{
    src->convertTo(*dst, rtype, alpha, beta);
}

// C++: void Mat::copyTo(Mat& m);
void copyTo(cv::Mat *dst, cv::Mat *src)
{
    src->copyTo(*dst);
}

// C++: void Mat::copyTo(Mat& m, Mat mask);
void copyTo2(cv::Mat *dst, cv::Mat *src, cv::Mat *mask)
{
    src->copyTo(*dst, *mask);
}

// C++: void Mat::create(Size size, int type);
void create2(cv::Size size, int type)
{
}

// C++: Mat Mat::cross(Mat m);
//TODO
cv::Mat* cross(cv::Mat *mat1, cv::Mat *mat2)
{
    cv::Mat *result = new cv::Mat();
    //*result = mat1->cross(*mat2);
    return result;
}

// C++: int Mat::depth();
// Done
int depth(cv::Mat* mat)
{
    return mat->depth();
}

/*
// C++: Mat Mat::diag(int d = 0);
cv::Mat* diag1(int d);
    
*/

// C++: static Mat Mat::diag(Mat d);
/*
    public static Mat diag(Mat d);
Mat retVal = new Mat(n_diag(d.nativeObj););
*/

// C++: double Mat::dot(Mat m);
// Done
double dot(cv::Mat *mat1, cv::Mat *mat2)
{
    return mat1->dot(*mat2);
}

// C++: size_t Mat::elemSize();
// Done
long elemSize(cv::Mat *mat)
{
    // TODO: does long is nessesary?
    return (long)(mat->elemSize());
}

// C++: size_t Mat::elemSize1();
long elemSize1(cv::Mat *mat)
{
    // TODO: does long is nessesary?
    return (long)(mat->elemSize1());
}

// C++: bool Mat::empty();
// Done
bool empty(cv::Mat *mat)
{
    return mat->empty();
}

// C++: static Mat Mat::eye(int rows, int cols, int type);
// TODO: need to verify. Matexpr
cv::Mat* eye(int rows, int cols, int type)
{
    cv::Mat *eyeMat = new cv::Mat();
    *eyeMat = cv::Mat::eye(rows, cols, type);
    return eyeMat;
}

cv::Mat* ones(int rows, int cols, int type)
{
    cv::Mat *onesMat = new cv::Mat();
    *onesMat = cv::Mat::ones(rows, cols, type);
    return onesMat;
}

/*
// C++: static Mat Mat::eye(Size size, int type);
*/

// C++: Mat Mat::inv(int method = DECOMP_LU);
cv::Mat* inv(cv::Mat *mat, int method)
{
    cv::Mat *inversedMat = new cv::Mat();
    // TODO, need more test!
    //*inversedMat = mat->inv(method);
    return inversedMat;
}

// C++: bool Mat::isContinuous();
bool isContinuous(cv::Mat *mat)
{
    return mat->isContinuous();
}

// C++: bool Mat::isSubmatrix();
// bool isSubmatrix()
// {
// }

// C++: void Mat::locateROI(Size wholeSize, Point ofs);
// void locateROI(cv::Size wholeSize, cv::Point ofs)
// {
// }

/*
// C++: Mat Mat::mul(Mat m, double scale = 1);
cv::Mat* mul1(cv::Mat m, double scale)
{
}

*/

/*
// C++: static Mat Mat::ones(int rows, int cols, int type);
cv::Mat* ones(int rows, int cols, int type)
{
}

// C++: static Mat Mat::ones(Size size, int type);
cv::Mat*  ones(Size size, int type)
{
}
*/

// C++: void Mat::push_back(Mat m);
// void push_back(cv::Mat m)
// {
// }

// C++: void Mat::release();
// void release()
// {
// }

// C++: Mat Mat::reshape(int cn, int rows = 0);
// cv::Mat* reshape1(int cn, int rows)
// {
// }
    
// C++: Mat Mat::row(int y);
// cv::Mat* row(int y)
// {
// }

// C++: Mat Mat::rowRange(int startrow, int endrow);
// cv::Mat* rowRange1(int startrow, int endrow)
// {
// }

/*
// C++: Mat Mat::rowRange(Range r);
cv::Mat* rowRange2(Range r)
{
}
*/

// C++: int Mat::rows();
int rows(cv::Mat *mat)
{
    return mat->rows;
}

/*
// C++: Mat Mat::operator =(Scalar s);
cv::Mat* setTo1(cv::Scalar s)
{
}

// C++: Mat Mat::setTo(Scalar value, Mat mask = Mat(););
cv::Mat* setTo2(cv::Scalar value, cv::Mat mask)
{
}

// C++: Mat Mat::setTo(Mat value, Mat mask = Mat(););
cv::Mat* setTo3(cv::Mat value, cv::Mat mask)
{
}
*/

// C++: Size Mat::size();
// cv::Size size(cv::Mat *mat)
// {
// }

// C++: size_t Mat::step1(int i = 0);
long step1(cv::Mat *mat, int i)
{
    return mat->step1();
}
    
// javadoc: Mat::step1();
// long step12(cv::Mat *mat)
// {
// }

// C++: Mat Mat::operator();(int rowStart, int rowEnd, int colStart, int
// colEnd);
cv::Mat* submat1(cv::Mat *mat, int rowStart, int rowEnd, int colStart, int colEnd)
{
    cv::Mat *subMat = new cv::Mat(mat->operator()(cv::Range(rowStart, rowEnd), cv::Range(colStart, colEnd)));
    return subMat;
}

/*
// C++: Mat Mat::operator();(Range rowRange, Range colRange);
cv::Mat* submat2(cv::Range rowRange, cv::Range colRange)
{
}

// C++: Mat Mat::operator();(Rect roi);
cv::Mat* submat3(cv::Rect roi)
{
}

// C++: Mat Mat::t();
cv::Mat* t()
{
}
*/

// C++: size_t Mat::total();
// Done
long total(cv::Mat *mat)
{
    //TODO return long is correct?
    return mat->total();
}

// C++: int Mat::type();
// Done, TODO: need further verify
int type(cv::Mat *mat)
{
    return mat->type();
}

// C++: static Mat Mat::zeros(int rows, int cols, int type);
cv::Mat* zeros(int rows, int cols, int type)
{
    cv::Mat *zeros = new cv::Mat();
    *zeros = cv::Mat::zeros(rows, cols, type);
    return zeros;
}

/*
// C++: static Mat Mat::zeros(Size size, int type);
cv::Mat* Mat zeros(Size size, int type)
{
}
*/



/* Input and Output Array */

cv::_InputArray* createInputArray()
{
    return new cv::_InputArray();
}

cv::_InputArray* createInputArrayWithMat(cv::Mat *mat)
{
    return new cv::_InputArray(*mat);
}

void freeInputArray(cv::_InputArray *arr)
{
    delete arr;
}

int inputArrayType(cv::_InputArray *arr)
{
    return arr->type();
}

cv::_OutputArray* createOutputArray()
{
    return new cv::_OutputArray();
}

cv::_OutputArray* createOutputArrayWithMat(cv::Mat *mat)
{
    return new cv::_OutputArray(*mat);
}

void freeOutputArray(cv::_OutputArray *arr)
{
    delete arr;
}

cv::Rect* createRect()
{
  return new cv::Rect();
}

void freeRect(cv::Rect *rec)
{
  delete rec;
}


/* 
   ----------------------------------------------
   | Get and set index functions for Mat        |
   ----------------------------------------------
*/
#define COPY_ELEMS_TO_PTR {        \
for (int i = 0; i < nelems; i++) { \
    ret[i] = vec[i];               \
 } }

unsigned char *mat_getindex_Cuchar(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    unsigned char *ret = (unsigned char *)malloc(sizeof(unsigned char) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<unsigned char>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2b vec = m->at<cv::Vec2b>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3b vec = m->at<cv::Vec3b>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4b vec = m->at<cv::Vec4b>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

char *mat_getindex_Cchar(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    char *ret = (char *)malloc(sizeof(char) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<char>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2b vec = m->at<cv::Vec2b>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3b vec = m->at<cv::Vec3b>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4b vec = m->at<cv::Vec4b>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

unsigned short *mat_getindex_Cushort(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    unsigned short *ret = (unsigned short *)malloc(sizeof(unsigned short) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<unsigned short>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2w vec = m->at<cv::Vec2w>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3w vec = m->at<cv::Vec3w>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4w vec = m->at<cv::Vec4w>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

short *mat_getindex_Cshort(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    short *ret = (short *)malloc(sizeof(short) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<short>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2s vec = m->at<cv::Vec2s>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3s vec = m->at<cv::Vec3s>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4s vec = m->at<cv::Vec4s>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

int *mat_getindex_Cint(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    int *ret = (int *)malloc(sizeof(int) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<int>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2i vec = m->at<cv::Vec2i>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3i vec = m->at<cv::Vec3i>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4i vec = m->at<cv::Vec4i>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

float *mat_getindex_Cfloat(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    float *ret = (float *)malloc(sizeof(float) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<float>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2f vec = m->at<cv::Vec2f>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3f vec = m->at<cv::Vec3f>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4f vec = m->at<cv::Vec4f>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

double *mat_getindex_Cdouble(cv::Mat *m, int i, int j)
{
    int nelems = m->channels();
    double *ret = (double *)malloc(sizeof(double) * nelems);

    if (nelems == 1) {
	ret[0] = m->at<double>(i, j);
	return ret;
    } else if (nelems == 2) {
	cv::Vec2d vec = m->at<cv::Vec2d>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 3) {
	cv::Vec3d vec = m->at<cv::Vec3d>(i, j);
	COPY_ELEMS_TO_PTR;
    } else if (nelems == 4) {
	cv::Vec4d vec = m->at<cv::Vec4d>(i, j);
	COPY_ELEMS_TO_PTR;
    }
    return ret;
}

void *mat_getindex_dispatcher(int type, cv::Mat *m, int i, int j)
{
    switch(type) {
    case CV_8U:
	return mat_getindex_Cuchar(m, i, j);
	break;
    case CV_8S:
	return mat_getindex_Cchar(m, i, j);
	break;
    case CV_16U:
	return mat_getindex_Cushort(m, i, j);
	break;
    case CV_16S:
	return mat_getindex_Cshort(m, i, j);
	break;
    case CV_32S:
	return mat_getindex_Cint(m, i, j);
	break;
    case CV_32F:
	return mat_getindex_Cfloat(m, i, j);
	break;
    case CV_64F:
	return mat_getindex_Cdouble(m, i, j);
	break;
    }
    return NULL;
}

#define COPY_ELEMS_TO_VEC {        \
for (int i = 0; i < nelems; i++) { \
    vec[i] = val[i];		   \
 } }

void mat_setindex_Cuchar(cv::Mat *m, int i, int j, unsigned char *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<unsigned char>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2b vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2b>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3b vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3b>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4b vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4b>(i, j) = vec;
    }
}

void mat_setindex_Cchar(cv::Mat *m, int i, int j, char *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<char>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2b vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2b>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3b vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3b>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4b vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4b>(i, j) = vec;
    }
}

void mat_setindex_Cushort(cv::Mat *m, int i, int j, unsigned short *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<unsigned short>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2w vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2w>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3w vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3w>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4w vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4w>(i, j) = vec;
    }
}

void mat_setindex_Cshort(cv::Mat *m, int i, int j, short *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<short>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2s vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2s>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3s vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3s>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4s vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4s>(i, j) = vec;
    }
}

void mat_setindex_Cint(cv::Mat *m, int i, int j, int *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<int>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2i vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2i>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3i vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3i>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4i vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4i>(i, j) = vec;
    }
}

void mat_setindex_Cfloat(cv::Mat *m, int i, int j, float *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<short>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2f vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2f>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3f vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3f>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4f vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4f>(i, j) = vec;
    }
}

void mat_setindex_Cdouble(cv::Mat *m, int i, int j, double *val)
{
    int nelems = m->channels();

    if (nelems == 1) {
	m->at<short>(i, j) = val[0];
    } else if (nelems == 2) {
	cv::Vec2d vec(0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec2d>(i, j) = vec;
    } else if (nelems == 3) {
	cv::Vec3d vec(0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec3d>(i, j) = vec;
    } else if (nelems == 4) {
	cv::Vec4d vec(0, 0, 0, 0);
	COPY_ELEMS_TO_VEC;
	m->at<cv::Vec4d>(i, j) = vec;
    }
}


void mat_setindex_dispatcher(int type, cv::Mat *m, int i, int j, void *val)
{
    switch(type) {
    case CV_8U:
	return mat_setindex_Cuchar(m, i, j, (unsigned char *)val);
	break;
    case CV_8S:
	return mat_setindex_Cchar(m, i, j, (char *)val);
	break;
    case CV_16U:
	return mat_setindex_Cushort(m, i, j, (unsigned short *)val);
	break;
    case CV_16S:
	return mat_setindex_Cshort(m, i, j, (short *)val);
	break;
    case CV_32S:
	return mat_setindex_Cint(m, i, j, (int *)val);
	break;
    case CV_32F:
	return mat_setindex_Cfloat(m, i, j, (float *)val);
	break;
    case CV_64F:
	return mat_setindex_Cdouble(m, i, j, (double *)val);
	break;
    }
}
