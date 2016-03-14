import Base: getindex, setindex!

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

Mat(rows::Int, cols::Int, matType::Int) =
    _Mat(ccall( (:createMat2, cv2_lib), Ptr{Void}, (Cint, Cint, Cint),
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

ones(rows::Int, cols::Int, matType::Int) =
    _Mat(ccall((:ones, cv2_lib), Ptr{Void}, (Int, Int, Int), rows, cols, matType))

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

matType(iarr::InputArray) = ccall((:inputArrayType, cv2_lib), Cint,
                                  (Ptr{Void}, ), iarr.handle)

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


type Rect
    handle::Ptr{Void}
end

function _Rect(ptr::Ptr{Void})
    rec = InputArray(ptr)
    finalizer(rec, x -> ccall((:freeRect, cv2_lib),
                              Void, (Ptr{Void}, ), x.handle))
    return rec
end

Rect() = _Rect(ccall((:createRect, cv2_lib), Ptr{Void}, ()))



# Get index and set index functions

const CV_8U = 0
const CV_8S = 1
const CV_16U = 2
const CV_16S = 3
const CV_32S = 4
const CV_32F = 5
const CV_64F = 6

const CV_DEPTH_TO_JULIA_TYPE_MAP =
    Dict(CV_8U => Cuchar,
         CV_8S => Cchar,
         CV_16U => Cushort,
         CV_16S => Cshort,
         CV_32S => Cint,
         CV_32F => Cfloat,
         CV_64F => Cdouble)

const JULIA_TYPE_TO_CV_DEPTH_MAP =
    Dict(Cuchar => CV_8U,
         Cchar => CV_8S,
         Cushort => CV_16U,
         Cshort => CV_16S,
         Cint => CV_32S,
         Cfloat => CV_32F,
         Cdouble => CV_64F)

# Returns scalar or vector of required type, depends on type of Mat.
function getindex(img::Mat, i::Int, j::Int)
    t = CV_DEPTH_TO_JULIA_TYPE_MAP[depth(img)]     # Type of each cell
    nelems = channels(img)
    return getindex_by_type(t, nelems, img, i, j)
end

for t in [:Cuchar, :Cchar, :Cushort, :Cshort, :Cint, :Cfloat, :Cdouble]
    q = quote
        function getindex_by_type(::Type{$t}, nelems, img, i, j)
            ptr = ccall((:mat_getindex_dispatcher, cv2_lib), Ptr{Void},
                        (Cint, Ptr{Void}, Cint, Cint),
                        JULIA_TYPE_TO_CV_DEPTH_MAP[$t], img.handle, i, j)
            ptr = convert(Ptr{$t}, ptr)
            return pointer_to_array(ptr, nelems, true)
        end
    end
    eval(q)
end

# Return values as julia array
getindex(img::Mat, i::UnitRange{Int}, j::UnitRange{Int}) = nothing

# Set a scalar or vector value to the specified index
function setindex!(img::Mat, val, i::Int, j::Int)
    _val = isa(val, Array) ? val : [val]
    _setindex(img, _val, i, j)
end

function _setindex(img::Mat, val, i::Int, j::Int)
    t = CV_DEPTH_TO_JULIA_TYPE_MAP[depth(img)]     # Type of each cell
    nelems = channels(img)

    # Check whether val is of required type and length.
    if length(val) != nelems
        error("Cannot assign vector of size $(length(val)) when image has $nelems channels")
    end

    conval = []
    try
        conval = map(t, val)
    catch e
        if isa(e, InexactError)
            error("Unable to convert input values to the required depth of the image.  Please check inputs")
        else
            throw(e)
        end
    end
    setindex_by_type(t, img, conval, i, j)
    return val
end

for t in [:Cuchar, :Cchar, :Cushort, :Cshort, :Cint, :Cfloat, :Cdouble]
    q = quote
        function setindex_by_type(::Type{$t}, img, val, i, j)
            ccall((:mat_setindex_dispatcher, cv2_lib), Void,
                  (Cint, Ptr{Void}, Cint, Cint, Ptr{$t}),
                  JULIA_TYPE_TO_CV_DEPTH_MAP[$t], img.handle, i, j, pointer(val))
        end
    end
    eval(q)
end

# Set a scalar or vector value to the specified index
setindex!(img::Mat, i::UnitRange{Int}, j::UnitRange{Int}, val) = nothing
setindex!(img::Mat, i::UnitRange{Int}, j::UnitRange{Int}, vals::Array) = nothing

# TODO: implement endof

#getindex(img::Mat, channel::Int, i::Int, j::Int) = at(img, channel, i, j)
