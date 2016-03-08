import Base: getindex

type Mat
    handle::Ptr{Void}
end

type cvRange
    rangeStart::Int
    rangeEnd::Int
end

function _Mat(ptr::Ptr{Void})
    m = Mat(ptr)
    finalizer(m, x -> ccall((:freeMat, cv2_lib), Void, (Ptr{Void}, ), x.handle))
    return m
end

Mat(rows::Int32, cols::Int32, matType::Int32) =
    _Mat(ccall( (:createMat2, cv2_lib), Ptr{Void}, (Int32, Int32, Int32),
           rows, cols, matType))
Mat() = _Mat(ccall( (:createMat1, cv2_lib), Ptr{Void}, (), ))

assignTo(dst::Mat, src::Mat, matType::Int = -1) =
    _Mat(ccall( (:assignTo, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Int),
                dst.handle, src.handle, matType))

depth(mat::Mat) = ccall( (:depth, cv2_lib), Int, (Ptr{Void}, ), mat.handle)

channels(mat::Mat) = ccall( (:channels, cv2_lib), Int, (Ptr{Void}, ), mat.handle)

dims(mat::Mat) = ccall( (:dims, cv2_lib), Int, (Ptr{Void}, ), mat.handle)

cols(mat::Mat) = ccall( (:cols, cv2_lib), Int, (Ptr{Void}, ), mat.handle)

rows(mat::Mat) = ccall( (:rows, cv2_lib), Int, (Ptr{Void}, ), mat.handle)

empty(mat::Mat) = ccall( (:empty, cv2_lib), Bool, (Ptr{Void}, ), mat.handle)

clone(mat::Mat) = _Mat(ccall( (:cloneInWrap, cv2_lib), Ptr{Void}, (Ptr{Void}, ),
                              mat.handle))

adjustROI(mat::Mat, dtop::Int, dbottom::Int, dleft::Int, dright::Int) =
    _Mat(ccall( (:adjustROI, cv2_lib), Ptr{Void}, (Ptr{Void}, Int, Int, Int, Int),
                mat.handle, dtop, dbottom, dleft, dright))

# C++: void Mat::convertTo(Mat& m, int rtype, double alpha = 1, double beta
# = 0);
convertTo(dst::Mat, src::Mat, rtype::Int, alpha::Float64 = 1.0, beta::Float64 = .0) =
    ccall( (:convertTo, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Int, Float64, Float64),
           dst.handle, src.handle, rtype, alpha, beta)

copyTo(dst::Mat, src::Mat) = ccall( (:copyTo, cv2_lib), Void,
                                    (Ptr{Void}, Ptr{Void}), dst.handle, src.handle)

copyTo(dst::Mat, src::Mat, mask::Mat) = ccall( (:copyTo, cv2_lib), Void,
                                               (Ptr{Void}, Ptr{Void}, Ptr{Void}),
                                               dst.handle, src.handle, mask.handle)

subMatrix(mat::Mat, rowRange::cvRange, colRange::cvRange) =
    _Mat(ccall( (:submat1, cv2_lib), Ptr{Void}, (Ptr{Void}, Int, Int, Int, Int),
                mat.handle, rowRange.rangeStart, rowRange.rangeEnd,
                colRange.rangeStart, colRange.rangeEnd))

cross(mat1::Mat, mat2::Mat) =
    _Mat(ccall( (:cross, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void}),
                mat1.handle, mat2.handle))

dot(mat1::Mat, mat2::Mat) =
    ccall( (:dot, cv2_lib), Float64, (Ptr{Void}, Ptr{Void}), mat1.handle, mat2.handle)

elemSize(mat::Mat) =
    ccall( (:elemSize, cv2_lib), Int, (Ptr{Void},), mat.handle)

elemSize1(mat::Mat) =
    ccall( (:elemSize1, cv2_lib), Int, (Ptr{Void},), mat.handle)

eye(rows::Int, cols::Int, matType::Int) =
    _Mat(ccall( (:eye, cv2_lib), Ptr{Void}, (Int, Int, Int), rows, cols, matType))

zeros(rows::Int, cols::Int, matType::Int) =
    _Mat(ccall( (:zeros, cv2_lib), Ptr{Void}, (Int, Int, Int), rows, cols, matType))

isContinuous(mat::Mat) =
    ccall( (:isContinuous, cv2_lib), Bool, (Ptr{Void},), mat.handle)
inv(mat::Mat, method::Int = 1) =
    _Mat(ccall( (:inv, cv2_lib), Ptr{Void}, (Ptr{Void}, Int), mat.handle, method))

step1(mat::Mat, i::Int = 0) =
    ccall( (:step1, cv2_lib), Int, (Ptr{Void},), mat.handle)
total(mat::Mat) =
    ccall( (:total, cv2_lib), Int, (Ptr{Void},), mat.handle)
matType(mat::Mat) =
    ccall( (:type, cv2_lib), Int, (Ptr{Void},), mat.handle)
# index support,
# like image[1,1]
getindex(img::Mat, channel::Int, i::Int, j::Int) = at(img, channel, i, j)
# C++ Mat::at
at(mat::Mat, channel::Int, i::Int, j::Int) =
    ccall( (:at, cv2_lib), Int, (Ptr{Void}, Int, Int, Int),
           mat.handle, channel, i, j)


# Input and Output Array

type InputArray
    handle::Ptr{Void}
end

function _InputArray(ptr::Ptr{Void})
    arr = InputArray(ptr)
    finalizer(arr, x -> ccall((:freeInputArray, cv2_lib),
                              Void, (Ptr{Void}, ), x.handle))
    return arr
end

InputArray() = _InputArray(ccall((:createInputArray, cv2_lib),
                                 Ptr{Void}, ()))

InputArray(mat) = _InputArray(ccall((:createInputArrayWithMat, cv2_lib),
                                    Ptr{Void}, (Ptr{Void}, ), mat.handle))

type OutputArray
    handle::Ptr{Void}
end

function _OutputArray(ptr::Ptr{Void})
    arr = OutputArray(ptr)
    finalizer(arr, x -> ccall((:freeOutputArray, cv2_lib),
                              Void, (Ptr{Void}, ), x.handle))
    return arr
end

OutputArray() = _OutputArray(ccall((:createOutputArray, cv2_lib),
                                   Ptr{Void}, ()))

OutputArray(mat) = _OutputArray(ccall((:createOutputArrayWithMat, cv2_lib),
                                      Ptr{Void}, (Ptr{Void}, ), mat.handle))
