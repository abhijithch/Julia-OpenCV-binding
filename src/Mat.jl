import Base: getindex

type Mat
	handle::Ptr{Void}
end

type cvRange
    rangeStart::Int
    rangeEnd::Int
end

Mat(rows::Int32, cols::Int32, matType::Int32) = Mat(createMat(rows::Int32, cols::Int32, matType::Int32))
Mat() = Mat(createMat())
# C++: void Mat::create(int rows, int cols, int type);
function create(rows::Int32, cols::Int32, matType::Int32)
    hnd = Mat(createMat(rows::Int32, cols::Int32, matType::Int32))
    return hnd
end

# C++: Mat::Mat(int rows, int cols, int type)
function createMat(rows::Int32, cols::Int32, matType::Int32)
    hnd = ccall( (:createMat2, cv2_lib), Ptr{Void}, (Int32, Int32, Int32), rows, cols, matType)
    return hnd;
end
function createMat()
    hnd = ccall( (:createMat1, cv2_lib), Ptr{Void}, (), )
    return hnd;
end

function assignTo(dst::Mat, src::Mat, matType::Int = -1)
    hnd = Mat(ccall( (:assignTo, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Int), dst.handle, src.handle, matType))
    return hnd
end

function depth(mat::Mat)
    ccall( (:depth, cv2_lib), Int, (Ptr{Void}, ), mat.handle)
end

function channels(mat::Mat)
    ccall( (:channels, cv2_lib), Int, (Ptr{Void}, ), mat.handle)
end

function dims(mat::Mat)
    ccall( (:dims, cv2_lib), Int, (Ptr{Void}, ), mat.handle)
end

function cols(mat::Mat)
    ccall( (:cols, cv2_lib), Int, (Ptr{Void}, ), mat.handle)
end

function rows(mat::Mat)
    ccall( (:rows, cv2_lib), Int, (Ptr{Void}, ), mat.handle)
end
function empty(mat::Mat)
    ccall( (:empty, cv2_lib), Bool, (Ptr{Void}, ), mat.handle)
end

function clone(mat::Mat)
    image = Mat(ccall( (:cloneInWrap, cv2_lib), Ptr{Void}, (Ptr{Void}, ), mat.handle))
    return image
end

function adjustROI(mat::Mat, dtop::Int, dbottom::Int, dleft::Int, dright::Int)
    mat = Mat(ccall( (:adjustROI, cv2_lib), Ptr{Void}, (Ptr{Void}, Int, Int, Int, Int), mat.handle, dtop, dbottom, dleft, dright))
    return mat
end

# C++: void Mat::convertTo(Mat& m, int rtype, double alpha = 1, double beta
# = 0);
function convertTo(dst::Mat, src::Mat, rtype::Int, alpha::Float64 = 1.0, beta::Float64 = .0)
    ccall( (:convertTo, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Int, Float64, Float64), dst.handle, src.handle, rtype, alpha, beta)
end

function copyTo(dst::Mat, src::Mat)
    ccall( (:copyTo, cv2_lib), Void, (Ptr{Void}, Ptr{Void}), dst.handle, src.handle)
end

function copyTo(dst::Mat, src::Mat, mask::Mat)
    ccall( (:copyTo, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void}), dst.handle, src.handle, mask.handle)
end

function subMatrix(mat::Mat, rowRange::cvRange, colRange::cvRange)
    subMat = Mat(ccall( (:submat1, cv2_lib), Ptr{Void}, (Ptr{Void}, Int, Int, Int, Int), mat.handle, rowRange.rangeStart, rowRange.rangeEnd, colRange.rangeStart, colRange.rangeEnd))
    return subMat
end

function cross(mat1::Mat, mat2::Mat)
    result = Mat(ccall( (:cross, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void}), mat1.handle, mat2.handle))
    return result
end

function dot(mat1::Mat, mat2::Mat)
    result = ccall( (:dot, cv2_lib), Float64, (Ptr{Void}, Ptr{Void}), mat1.handle, mat2.handle)
    return result;
end

function elemSize(mat::Mat)
    result = ccall( (:elemSize, cv2_lib), Int, (Ptr{Void},), mat.handle)
    return result
end

function elemSize1(mat::Mat)
    result = ccall( (:elemSize1, cv2_lib), Int, (Ptr{Void},), mat.handle)
    return result
end

function eye(rows::Int, cols::Int, matType::Int)
    mat = Mat(ccall( (:eye, cv2_lib), Ptr{Void}, (Int, Int, Int), rows, cols, matType))
    return mat
end

function zeros(rows::Int, cols::Int, matType::Int)
    mat = Mat(ccall( (:zeros, cv2_lib), Ptr{Void}, (Int, Int, Int), rows, cols, matType))
    return mat
end

function isContinuous(mat::Mat)
    ccall( (:isContinuous, cv2_lib), Bool, (Ptr{Void},), mat.handle)
end

function inv(mat::Mat, method::Int = 1)
    inversed = Mat(ccall( (:inv, cv2_lib), Ptr{Void}, (Ptr{Void}, Int), mat.handle, method))
    return inversed
end

function step1(mat::Mat, i::Int = 0)
    ccall( (:step1, cv2_lib), Int, (Ptr{Void},), mat.handle)
end

function total(mat::Mat)
    ccall( (:total, cv2_lib), Int, (Ptr{Void},), mat.handle)
end

function matType(mat::Mat)
    ccall( (:type, cv2_lib), Int, (Ptr{Void},), mat.handle)
end

# index support,
# like image[1,1]
getindex(img::Mat, channel::Int, i::Int, j::Int) = at(img, channel, i, j)
# C++ Mat::at
function at(mat::Mat, channel::Int, i::Int, j::Int)
    ccall( (:at, cv2_lib), Int, (Ptr{Void}, Int, Int, Int), mat.handle, channel, i, j)
end
