function minMaxLoc(src::InputArray, mask::InputArray)

    minVal = zeros(Float64, 1)
    maxVal = zeros(Float64, 1)
    minLoc = cv2.Point(C_NULL)
    maxLoc = cv2.Point(C_NULL)

    ccall((:minMaxLoc, cv2_lib), Void, (Ptr{Void}, Ptr{Float64}, Ptr{Float64}, Ptr{Void}, Ptr{Void}, Ptr{Void},), src.handle, minVal, maxVal, minLoc.handle, maxLoc.handle, mask.handle)

    return minVal, maxVal, minLoc, maxLoc

end
