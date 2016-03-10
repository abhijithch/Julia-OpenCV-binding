 LibOpenCV.jl
====================

Julia bindings for [OpenCV](http://opencv.org/).

## Installation

### Unix (Ubuntu and Mac OSX)

Install [OpenCV](http://docs.opencv.org/2.4/doc/tutorials/introduction/linux_install/linux_install.html), then:

```julia
Pkg.clone("https://github.com/abhijithch/LibOpenCV.jl")
Pkg.build("LibOpenCV")
```

### Windows

Download or [build](https://sourceforge.net/p/opencvmingw/wiki/Build%20OpenCV%20under%20MinGW/) the MinGW 64-bit binaries of OpenCV and add the `bin` directory to `PATH` environment variable.

Clone the package from julia prompt.

```julia
Pkg.clone("https://github.com/abhijithch/LibOpenCV.jl")
```

Add `deps/windows` directory to the `PATH` environment variable.

Minimal Example -- Calculate histogram
-------------------

The code of calculating histogram that use OpenCV Julia binding is like this:

```julia
include("../src/OpenCV.jl")

img = cv2.imread("/home/sun/workspace/Lena.jpg")

# split image by each channel
images = cv2.split(img)

# make an empty image to draw histogram
histImage = cv2.zeros(300, 256, cv2.matType(img))

# prepare the x coordinate of each bin
bins = reshape(1:256, 256)

#Three color of BGR
color = [ (255,0,0),(0,255,0),(0,0,255) ]

# draw the histogram for each channel by cv.polylines
for i = 1:3
    # calculate histogram for each channel
    hist = cv2.calcHist([images[i]], [0], [256], [0.0, 255.0])
    # an custom function, normarlize the hist value to 0-255
    hist = cv2.normarlizeT(hist)
    # make the histogram draw in image from down to top
    for j = 1:length(hist)
        hist[j] = 300 - hist[j]
    end
    # stack two array by column, I don't know whether there has
    # similar function in Julia
    pts = cv2.columnStack(bins, hist)
    # draw each hist, represent to a polyline
    cv2.polylines(histImage, pts, false, color[i])
end

cv2.imshow("HistImage", histImage)
cv2.waitKey(0)
```

Here is the output that generated in Julia by the binding:

![Hist](./doc/figures/hist_Julia.png)
