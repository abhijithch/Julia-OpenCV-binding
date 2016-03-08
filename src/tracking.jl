import Base.convert

# Kalman Filter: To create a type replicating the KalmanFilter class.
type KalmanFilter
    handle::Ptr{Void}
end

function _KalmanFilter(ptr::Ptr{Void})
    kf = KalmanFilter(ptr)
    finalizer(kf, x -> ccall((:freeKalmanFilter, cv2_lib),
                             Void, (Ptr{Void}, ), x.handle))
    return kf
end

KalmanFilter() = _KalmanFilter(ccall((:createKalmanFilter, cv2_lib),
                                     Ptr{Void}, (())))
                        
KalmanFilter(dynamParams, measureParams, controlParams=0, t=CV_32F) =
    _KalmanFilter(ccall((:createKalmanFilterWithArgs, cv2_lib),
                        Ptr{Void}, (Cint, Cint, Cint, Cint,),
                        dynamParams, measureParams, controlParams, t))


# Member functions from KalmanFilter class.
correct(kf::KalmanFilter, measurement::Mat) =
    _Mat(ccall((:correct, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void},),
               kf.handle, measurement.handle))

predict(kf::KalmanFilter, control = Mat()) =
    _Mat(ccall((:predict, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Void},),
               kf.handle, control.handle))
