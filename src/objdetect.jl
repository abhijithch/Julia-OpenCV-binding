type CascadeClassifier
    handle::Ptr{Void}
end

function _CascadeClassifier(ptr::Ptr{Void})
    arr = CascadeClassifier(ptr)
    finalizer(arr, x -> ccall((:freeCascadeClassifier, cv2_lib),
                                Void, (Ptr{Void}, ), arr.handle))
    return arr
end

CascadeClassifier() = _CascadeClassifier(ccall((:createCascadeClassifier, cv2_lib),
                                            Ptr{Void}, ()))

CascadeClassifier(path::AbstractString) =
    _CascadeClassifier(ccall((:createCascadeClassifierWithString, cv2_lib),
                             Ptr{Void}, (Cstring, ), path))

load(cc::CascadeClassifier, path::AbstractString) =
    ccall((:loadCCFromFile, cv2_lib), Void, (Ptr{Void}, Cstring), cc.handle, path)

type HOGDescriptor
    handle::Ptr{Void}
end

function _HOGDescriptor(ptr::Ptr{Void})
    hg = HOGDescriptor(ptr)
    finalizer(hg, x -> ccall((:freeHOGDescriptor, cv2_lib),
                             Void, (Ptr{Void}, ), x.handle))
    return hg
end

HOGDescriptor() = _HOGDescriptor(ccall((:createHOGDescriptor, cv2_lib),Ptr{Void}, (())))

# Member functions of HOGDescriptor
setSVMDetector(hg::HOGDescriptor, svmdetector::InputArray) =
    ccall((:setSVMDetector, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, ),
          hg.handle, svmDetector.handle)

setSVMDetector(hg::HOGDescriptor, svmdetector::Array{Cfloat}) =
    ccall((:setSVMDetectorWithFloatArray, cv2_lib), Void, (Ptr{Void}, Ptr{Cfloat}, Cint),
          hg.handle, pointer(svmdetector), length(svmdetector))

# Returns an array of rects and fWeights
function detectMultiScale(hog::HOGDescriptor, img::InputArray, hitThreshold = 0., 
                          winStride = Size(), padding = Size(), scale = 1.05, 
                          finalThreshold = 2.0, useMeanshiftGrouping=false)
    _nrecs = [Cint(0)]
    _nfw = [Cint(0)]
    _fwptr = [C_NULL]

    rptr = ccall((:detectMultiScaleHOG, cv2_lib), Void,
                 (Ptr{Void}, Ptr{Void}, Ptr{Ptr{Cdouble}}, Cdouble, Ptr{Cint}, Ptr{Cint},
                  Cdouble, Cdouble, Cint, Ptr{Cint}, Ptr{Cint}),
                 hog.handle, img.handle, pointer(_fwptr), hitThreshold,
                 winStride.handle, padding.handle, scale, finalThreshold,
                 Cint(useMeanshiftGrouping), pointer(_nrecs), pointer(_nfw))
    
    nrecs = _nrecs[1]
    nfw = _nfw[1]
    fwptr = convert(Ptr{Cdouble}, _fwptr[1])

    recs = map(_Rect, pointer_to_array(rptr, nrecs, true))
    fw = pointer_to_array(fwptr, nfw, true)
    return recs, fw
end 

function getDefaultPeopleDetector(hog::HOGDescriptor)
    _nout = [Cint(0)]
    outptr = ccall((:getDefaultPeopleDetector,cv2_lib), Ptr{Cfloat}, (Ptr{Void}, Ptr{Cint}), 
                   hog.handle, pointer(_nout))
    nout = _nout[1]
    return pointer_to_array(outptr, nout, true)
end

function getDaimlerPeopleDetector(hog::HOGDescriptor)
    _nout = [Cint(0)]
    outptr = ccall((:getDaimlerPeopleDetector,cv2_lib), Ptr{Cfloat}, (Ptr{Void}, Ptr{Cint}), 
                   hog.handle, pointer(_nout))
    nout = _nout[1]
    return pointer_to_array(outptr, nout, true)
end

# Returns an array of rects and numDetects
function detectMultiScale(cc::CascadeClassifier, image::InputArray, scaleFactor = 1.1,
                          minNeighbors = 3, flags = 0, minSize = Size(),
                          maxSize = Size())
    minNeighbors = convert(Cint, minNeighbors)
    flags = convert(Cint, flags)
    _nrecs = [Cint(0)]
    _ndetects = [Cint(0)]
    _ndptr = [C_NULL]
    rptr = ccall((:detectMultiScaleCC1, cv2_lib), Ptr{Ptr{Void}},
                 (Ptr{Void}, Ptr{Void}, Ptr{Ptr{Cint}}, Cdouble, Cint, Cint, Ptr{Void},
                  Ptr{Void}, Ptr{Cint}, Ptr{Cint}),
                 cc.handle, image.handle, pointer(_ndptr), scaleFactor, minNeighbors,
                 flags, minSize.handle, maxSize.handle, pointer(_nrecs), pointer(_ndetects))
    nrecs = _nrecs[1]
    ndetects = _ndetects[1]
    ndptr = convert(Ptr{Cint}, _ndptr[1])
    recs = map(_Rect, pointer_to_array(rptr, nrecs, true))
    nds = pointer_to_array(ndptr, ndetects, true)
    return recs, nds
end

# Returns an array of rects, rejectLevels and levelWeights
function detectMultiScale(cc::CascadeClassifier, image::InputArray, scaleFactor = 1.1,
                          minNeighbors = 3, flags = 0, minSize = Size(),
                          maxSize = Size(), outputRejectLevels=false)
    minNeighbors = convert(Cint, minNeighbors)
    flags = convert(Cint, flags)
    _nrecs = [Cint(0)]
    _nrl = [Cint(0)]
    _rlptr = [C_NULL]
    _nlw = [Cint(0)]
    _lwptr = [C_NULL]
    rptr = ccall((:detectMultiScaleCC2, cv2_lib), Ptr{Ptr{Void}},
                 (Ptr{Void}, Ptr{Void}, Ptr{Ptr{Cint}}, Ptr{Ptr{Cdouble}}, Cdouble,
                  Cint, Cint, Ptr{Void}, Ptr{Void}, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
                 cc.handle, image.handle, pointer(_rlptr), pointer(_lwptr),
                 scaleFactor, minNeighbors, flags, minSize.handle, maxSize.handle,
                 Cint(outputRejectLevels), pointer(_nrecs), pointer(_nrl), pointer(_nlw))
    nrecs = _nrecs[1]
    nrl = _nrl[1]
    nlw = _nlw[1]
    rlptr = convert(Ptr{Cint}, _rlptr[1])
    lwptr = convert(Ptr{Cdouble}, _lwptr[1])
    recs = map(_Rect, pointer_to_array(rptr, nrecs, true))
    rl = pointer_to_array(rlptr, nrl, true)
    lw = pointer_to_array(lwptr, nlw, true)
    return recs, rl, lw
end
