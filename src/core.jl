function minMaxLoc(src::InputArray, mask::InputArray=cv2.InputArray(cv2.Mat()))

    minVal_ = Base.zeros(Cdouble, 1)
    maxVal_ = Base.zeros(Cdouble, 1)
    minLoc_ = [C_NULL]
    maxLoc_ = [C_NULL]

    ccall((:minMaxLoc, cv2_lib), Void,
          (Ptr{Void}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Void}, Ptr{Void}, Ptr{Void},),
          src.handle, pointer(minVal_), pointer(maxVal_),
          pointer(minLoc_), pointer(maxLoc_), mask.handle)

    minVal = minVal_[1]
    maxVal = maxVal_[1]
    minLoc = Point(minLoc_[1])
    maxLoc = Point(maxLoc_[1])
    return minVal, maxVal, minLoc, maxLoc
end
