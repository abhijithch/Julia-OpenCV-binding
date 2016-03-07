import Base.convert

# Kalman Filter: To create a type replicating the KalmanFilter class.


# Member functions from KalmanFilter class.
function correct(measurement::Mat)
    hnd = Mat(ccall((:correct, cv2_lib), Ptr{Void}, (Ptr{Void}), measurement))
    return hnd
end

function predict()
    hnd = Mat(ccall(:predict, cv2_lib), Ptr{Void}, ())
    return hnd
end
