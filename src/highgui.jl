imread(filename::AbstractString) = Mat(ccall( (:imread, cv2_lib), Ptr{Void},(Ptr{UInt8},), bytestring(filename)))

imshow(winName::AbstractString, mat::Mat) = ccall( (:imshow, cv2_lib), Void, (Ptr{UInt8}, Ptr{Void}), bytestring(winName), mat.handle)

waitKey(delay::Int) = ccall( (:waitKey, cv2_lib), Void, (Int32,), delay)
