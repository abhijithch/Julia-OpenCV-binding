import Base: >>

type VideoCapture
    handle::Ptr{Void}
end

function _VideoCapture(ptr::Ptr{Void})
    v = VideoCapture(ptr)
    finalizer(v, x -> ccall((:freeVideoCapture, cv2_lib),
                            Void, (Ptr{Void}, ), x.handle))
    return v
end

VideoCapture() = _VideoCapture(ccall((:createVideoCapture, cv2_lib),
                                     Ptr{Void}, ()))

VideoCapture(dev::Int) = _VideoCapture(ccall((:createVideoCaptureWithDevice, cv2_lib),
                                             Ptr{Void}, (Cint, ), dev))

VideoCapture(file::AbstractString) =
    _VideoCapture(ccall((:createVideoCaptureWithFile, cv2_lib),
                        Ptr{Void}, (Ptr{Cchar}, ), pointer(file)))

macro getbool(v)
    quote
        $v == 1
    end
end

open(v::VideoCapture, file::AbstractString) =
    @getbool(ccall((:videoCaptureOpenWithFile, cv2_lib), Cint,
                   (Ptr{Void}, Ptr{Cchar}, ), v.handle, pointer(file)))

open(v::VideoCapture, device::Int) =
    @getbool(ccall((:videoCaptureOpenWithDevice, cv2_lib), Cint,
                   (Ptr{Void}, Cint, ), v.handle, device))

isOpened(v::VideoCapture) = @getbool(ccall((:videoCaptureIsOpened, cv2_lib), Cint,
                                           (Ptr{Void}, ), v.handle))

release(v::VideoCapture) = ccall((:videoCaptureRelease, cv2_lib), Void,
                                 (Ptr{Void}, ), v.handle)

grab(v::VideoCapture) = @getbool(ccall((:videoCaptureGrab, cv2_lib), Cint,
                                       (Ptr{Void}, ), v.handle))

retrieve(v::VideoCapture, arr::OutputArray, flag=0) =
    @getbool(ccall((:videoCaptureRetrieve, cv2_lib), Cint, (Ptr{Void}, Ptr{Void}, Cint),
                   v.handle, arr.handle, flag))

read(v::VideoCapture, arr::OutputArray) =
    @getbool(ccall((:videoCaptureRead, cv2_lib), Cint, (Ptr{Void}, Ptr{Void}, ),
                   v.handle, arr.handle))

set(v::VideoCapture, propId, value) =
    @getbool(ccall((:videoCaptureSet, cv2_lib), Cint, (Ptr{Void}, Cint, Cdouble, ),
                   v.handle, propId, value))

get(v::VideoCapture, propId, value) =
    @getbool(ccall((:videoCaptureGet, cv2_lib), Cint, (Ptr{Void}, Cint, ),
                   v.handle, propId))

>>(v::VideoCapture, m::Mat) = ccall((:videoCaptureShiftOperatorWithMat, cv2_lib), Void,
                                    (Ptr{Void}, Ptr{Void}, ), v.handle, m.handle)

