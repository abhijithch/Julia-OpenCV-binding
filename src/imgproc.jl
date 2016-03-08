import Base.convert
function split(image::Mat)
    hnd = ccall( (:split, cv2_lib), Ptr{Ptr{Void}}, (Ptr{Void},), image.handle)
    images = pointer_to_array(hnd, 3)
    imageR = convert(Array{Mat, 1}, images)
    return imageR
end

function convert(::Type{Array{Mat, 1}}, ptrArray::Array{Ptr{Void}, 1})
    matArray = Mat[]
    for ptr in ptrArray
        append!(matArray, [Mat(ptr)])
    end
    return matArray
end

function columnStack(x::Array{Int, 1}, y::Array{Int, 1})
    pts = cv2.Point[]
    for i = 1:length(x)
        pt = cv2.Point(x[i], y[i])
        append!(pts, [pt])
    end
    return pts
end

function normarlizeT(array::Array{Int32, 1})
        big = array[1]
        small = array[1]

    for i = 2:length(array)
        temp = array[i]
        #println(temp)
        if temp > big
            big = temp
        end
        if temp < small
            small = temp
        end
    end

    rArray = Int[]

    for i = 1:length(array)
        append!(rArray, [convert(Int32, round(((array[i] - small)/(big - small))
        * 255))])
    end

    return rArray
end



function calcHist(images::Array{Mat,},
                  channels::Array{Int, 1},
                  #Null, #mask
                  histSize::Array{Int, 1},
                  ranges::Array{Float64, 1},
                  uniform::Bool = true,
                  accumulate::Bool = false)
    nimages = length(images)
    mask = Mat()

    imagesPtr = convertMatArray(images)
    hnd = ccall( (:calcHist, cv2_lib),
              Ptr{Int32},
              (Ptr{Ptr{Void}}, Int, Ptr{Int}, Ptr{Void}, Int, Ptr{Int}, Ptr{Float64}, Bool, Bool),
              imagesPtr, nimages, channels, mask.handle, dims(images[1]), histSize, ranges, uniform, accumulate)
    hist = pointer_to_array(hnd, histSize[1])

    return hist
end

type Point
    x::Int
    y::Int
end

type cvPoint
    handle::Ptr{Void}
end

function cvPoint(x::Int, y::Int)
    pt = cvPoint(ccall( (:setPoint, cv2_lib), Ptr{Void}, (Int, Int), x, y))
    return pt
end

function blur(image::Mat,
              size::Tuple{Int, Int},
              anchor::cv2.Point=cv2.Point(-1, -1),
              borderType::Int=0)
    sizeX = convert(Int32, size[1])
    sizeY = convert(Int32, size[2])
    sizePtr = [sizeX, sizeY]

    anchorPtr = cvPoint(anchor.x, anchor.y)
    result = Mat(ccall( (:blur, cv2_lib), Ptr{Void}, (Ptr{Void}, Ptr{Int32},
    Ptr{Void}, Int), image.handle, sizePtr, anchorPtr.handle, borderType))

    return result
end

function line(image::Mat,
              color::Tuple{Int64, Int64, Int64},
              p1::cv2.Point,
              p2::cv2.Point,
              thickness::Int64 = 1,
              lineType::Int64 = 8,
              shift::Int64 = 0)
    
    colorPtr = convertColortoPtr(color)
    cvPt1 = cvPoint(p1.x, p1.y)
    cvPt2 = cvPoint(p2.x, p2.y)

    println(colorPtr)
    #println(cvPt1)
    ccall((:line, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void}, Int, Int, Int), image.handle, cvPt1.handle, cvPt2.handle, colorPtr, thickness, lineType, shift)
end

function rectangle(image::Mat,
              color::Tuple{Int64, Int64, Int64},
              p1::cv2.Point,
              p2::cv2.Point,
              thickness::Int64 = 1,
              lineType::Int64 = 8,
              shift::Int64 = 0)
    colorPtr = convertColortoPtr(color)
    cvPt1 = cvPoint(p1.x, p1.y)
    cvPt2 = cvPoint(p2.x, p2.y)
    ccall((:rectangle, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void}, Int, Int, Int), image.handle, cvPt1.handle, cvPt2.handle, colorPtr, thickness, lineType, shift)
end

function circle(image::Mat,
                centre::cv2.Point,
                radius::Int,
                color::Tuple{Int64, Int64, Int64},
                thickness::Int64 = 1,
                lineType::Int64 = 8,
                shift::Int64 = 0)
    colorPtr = convertColortoPtr(color)
    cvCentre = cvPoint(centre.x, centre.y)
    ccall((:circle, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Int, Ptr{Void}, Int, Int, Int), image.handle, cvCentre.handle, radius, colorPtr, thickness, lineType, shift)
end

function ellipse(image::Mat,
                 centre::cv2.Point,
                 size::Tuple{Int, Int},
                 angle::Int64,
                 startAngle::Int64,
                 endAngle::Int64,
                 color::Tuple{Int64, Int64, Int64},
                 thickness::Int64 = 1,
                 lineType::Int64 = 8,
                 shift::Int64 = 0)

    colorPtr = convertColortoPtr(color)
    cvCentre = cvPoint(centre.x, centre.y)
    sizeX = convert(Int32, size[1])
    sizeY = convert(Int32, size[2])
    sizePtr = [sizeX, sizeY]
    ccall((:ellipse, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void}, Int, Int, Int, Ptr{Void}, Int, Int, Int), image.handle, cvCentre.handle, sizePtr, angle, startAngle, endAngle, colorPtr, thickness, lineType, shift)

end

#=
// C++: void putText(Mat& img, const string& text, Point org, int fontFace, double fontScale, Scalar color, int thickness=1, intlineType=8, bool bottomLeftOrigin=false )              
extern "C" void putText(cv::Mat *img, const char* text, cv::Point org, int fontFace, int fontScale, int color, );
=#

function putText(image::Mat,
                 text::AbstractString,
                 org::cv2.Point,
                 fontFace::Int64,
                 fontScale::Float64,
                 color::Tuple{Int64, Int64, Int64},
                 thickness::Int64 = 1,
                 lineType::Int64 = 8,
                 bottomLeftOrigin::Bool = false)

    colorPtr = convertColortoPtr(color)
    cvOrg = cvPoint(org.x, org.y)
    cvbottomLeftOrigin = Int(bottomLeftOrigin)
    
    ccall((:putText, "../libcv2.so"), Void, (Ptr{Void}, Ptr{Char}, Ptr{Void}, Int, Cdouble, Ptr{Void}, Int, Int, Cint),image.handle, pointer(text), cvOrg.handle, fontFace, fontScale, colorPtr, thickness, lineType, cvbottomLeftOrigin )

end

function polylines(image::Mat,
                   points::Array{cv2.Point, 1},
                   isClosed::Bool,
                   color::Tuple{Int, Int, Int},
                   thickness::Int = 1,
                   lineType::Int = 8,
                   shift::Int = 0)

    cvPts = convertPointArray(points)
    numOfPt = length(points) 
    colorPtr = convertColortoPtr(color)

    ccall( (:polylines, cv2_lib), Void, (Ptr{Void}, Ptr{Ptr{Void}}, Int, Bool, Ptr{Int32}, Int, Int, Int), image.handle, cvPts, numOfPt, isClosed, colorPtr, thickness, lineType, shift)
end

function convertColortoPtr(color::Tuple{Int, Int, Int})
    r = convert(Int32, color[1])
    g = convert(Int32, color[2])
    b = convert(Int32, color[3])
    colorPtr = [r, g, b]
    return colorPtr
end

function convertMatArray(images::Array{cv2.Mat, 1})
    cvMat = Ptr{Void}[]
    for i in 1:length(images)
        append!(cvMat, [images[i].handle])
    end
    return cvMat
end

function convertPointArray(points::Array{cv2.Point, 1})
    cvPts = Ptr{Void}[]
    for i in 1:length(points)
        pt = cvPoint(points[i].x, points[i].y)
        append!(cvPts, [pt.handle])
    end
    return cvPts
end

cvtColor(inarr::InputArray, outarr::OutputArray, code, dstCn = 0) =
    ccall((:cvtColor, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Cint, Cint, ),
          inarr.handle, outarr.handle, code, dstCn)


Sobel(src::InputArray, dst::OutputArray, ddepth::Int, dx::Int, dy::Int, ksize::Int, scale::Float64, delta::Float64, borderType::Int) =
    ccall((:Sobel, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Cint, Cint, Cint, Cint, Float64, Float64, Cint,), src.handle, dst.handle, ddepth, dx, dy, ksize, scale, delta, borderType)

function filter2D(src::InputArray, dst::OutputArray, ddepth::Int, kernel::InputArray, anchor::cv2.Point=cv2.Point(-1, -1), delta::Float64=0.0, borderType::Int=1)
    anchorPtr = cvPoint(anchor.x, anchor.y)
    ccall((:filter2D, cv2_lib), Void, (Ptr{Void}, Ptr{Void}, Cint, Ptr{Void}, Ptr{Void}, Float64, Cint,), src.handle, dst.handle, ddepth, kernel.handle, anchorPtr.handle, delta, borderType)

end
