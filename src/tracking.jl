import Base.convert

# Kalman Filter: To create a type replicating the KalmanFilter class.
type KalmanFilter
    handle::Ptr{Void}
end

KalmanFilter() = KalmanFilter(KalmanFilter(ccall((:createKalmanFilter, cv2_lib), Ptr{Void}, (()))))
                        
KalmanFilter(dynamParams, measureParams, controlParams=0, t=CV_32F) = KalmanFilter(KalmanFilter(ccall((:createKalmanFilterWithArgs, cv2_lib), Ptr{Void}, (Cint, Cint, Cint, Cint,), dynamParams, measureParams, controlParams, t)))


function KalmanFilter(arr::KalmanFilter)
    finalizer(arr, x -> ccall((:freeKalmanFilter, cv2_lib),
                              Void, (Ptr{Void}, ), x.handle))
    return arr
end

# Member functions from KalmanFilter class.
function correct(kf::KalmanFilter, measurement::Mat)
    hnd = Mat(Mat(ccall((:correct, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void},), kf.handle, measurement.handle)))
    return hnd
end

function predict(kf::KalmanFilter, control = Mat())
    hnd = Mat(Mat(ccall((:predict, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void},), kf.handle, control.handle)))
    return hnd
end
