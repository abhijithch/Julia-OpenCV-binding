# Tests for all the exported APIs are implemented here in an interactive mode.

println("\nLibOpenCV.jl tests: press ESC to continue")

function test_Sobel()
    println("test Sobel: apply Sobel operator to get the 1st, 2nd, 3rd or mixed derivative of an image.")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    gimg = cv2.Mat()
    inarr = cv2.InputArray(img)
    outarr = cv2.OutputArray(gimg)
    cv2.Sobel(inarr, outarr, -1, 1,1,1,1,1,1)
    cv2.imshow("Sobel",gimg)
    cv2.imclose("Sobel")
end

function test_putText()
    println("test putText: Place text over an image.")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    cv2.putText(img, "Hello Lena!", cv2.Point(50,50), 4, 2.0, (155,230,12),1,8,false)
    cv2.imshow("Lena",img)
    cv2.imclose("Lena")
end

function test_filter2D()
    println("test filter2D")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    inarr = cv2.InputArray(img)
    gimg = cv2.Mat()
    outarr = cv2.OutputArray(gimg)
    kernel = cv2.ones(3,3,1)
    cv2.filter2D(inarr, outarr, -1, kernel, cv2.Point(-1, -1), 0.0, 1 )
    cv2.imshow(gimg)
    
    cv2.close()
end


function test_line()
    println("test line draw function.")

    img = cv2.Mat(100, 100, 1)
    cv2.line(img, (255,133,10), cv2.Point(1,1), cv2.Point(10,-10))
    cv2.imshow("line", img)
    cv2.waitKey(5)
    cv2.imclose("line")
end

function test_rectangle()
    println("test rectangle draw function.")

    img = cv2.Mat(100, 100, 1)
    cv2.rectangle(img, (255,133,10), cv2.Point(1,1), cv2.Point(10,-10))
    cv2.imshow("rectangle", img)
    cv2.waitKey(5)
    cv2.imclose("rectangle")
end

function test_circle()
    println("test circle draw function.")

    img = cv2.Mat(100, 100, 1)
    cv2.circle(img, cv2.Point(1,1), 10, (255,133,10))
    cv2.imshow("circle", img)
    cv2.waitKey(5)
    cv2.imclose("circle")
end

function test_ellipse()
    println("test ellipse draw function.")

    img = cv2.Mat(100, 100, 1)
    cv2.ellipse(img, cv2.Point(150,100),cv2.Size(100,70), 0, 0, 360, (255,130,12)
    cv2.imshow("ellipse", img)
    cv2.waitKey(5)
    cv2.imclose("ellipse")
end

function test_polylines()
    println("test polylines drawing function.")
    
    img = cv2.Mat(100, 100, 1)
    pts = cv2.Point[]
    append!(pts, [cv2.Point(10,10)])
    append!(pts, [cv2.Point(20,30)])
    append!(pts, [cv2.Point(30,50)])
    append!(pts, [cv2.Point(60,70)])

    cv2.polylines(img, pts, false, (233,122,21))
    cv2.imshow("polylines", img)
    cv2.waitKey(5)
    cv2.imclose("polylines")
end
            
function test_histogram()
    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    
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
    cv2.waitKey(5)
    cv2.imclose("HistImage")
end                

function test_GaussianBlur()
    println("test GaussianBlur function.")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    inarr = cv2.InputArray(img)
    gimg = cv2.Mat(100, 100, cv2.matType(img))
    outarr = cv2.OutputArray(gimg)
    cv2.GaussianBlur(inarr, outarr, (5,5),2.0,0.0,1)
    cv2.imshow("GS", gimg)
    cv2.waitKey(5)
    cv2.imclose("GS")
end

function test_resize()
    println("test resize.")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    inarr = cv2.InputArray(img)
    gimg = cv2.clone(img)
    outarr = cv2.OutputArray(gimg)
    println("Before resize.")
    cv2.imshow("rs",gimg)
    cv2.waitKey(30)
    cv2.imclose("rs")
    cv2.resize(inarr, outarr, (50,50),2.0,2.0,0)
    cv2.imshow("rs",gimg)
    cv2.waitKey(30)
    cv2.imclose("rs")
    
end

function test_Canny()
    println("test Canny function.")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    inarr = cv2.InputArray(img)
    gimg = cv2.Mat(100, 100, cv2.matType(img))
    outarr = cv2.OutputArray(gimg)
    cv2.Canny(inarr, outarr, 50, 200, 3)
    cv2.imshow("canny", gimg)
    cv2.waitKey(5)
    cv2.imclose("canny")
end

function test_getDefaultPeopleDetector()
    #People detector test
    h = cv2.HOGDescriptor()
    out = cv2.getDefaultPeopleDetector(h)
    @test length(out) == 3781
    @test sum(out) - 17.829723 < 1e-4
end

function test_getDaimlerPeopleDetector()
    h = cv2.HOGDescriptor()
    out = cv2.getDaimlerPeopleDetector(h)
    @test length(out) == 1981
    @test sum(out) - 17.829723 < 1e-4
end

function test_HoughLinesP()
    println("test HoughLinesP")
    
    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    gimg = cv2.Mat()
    inarr = cv2.InputArray(img)
    outarr = cv2.OutputArray(gimg)
    cv2.cvtColor(inarr, outarr, cv2.CV_BGR2GRAY)
    hin = cv2.InputArray(gimg)
    lines = cv2.HoughLinesP(hin, 1.0, cv2.CV_PI/180.0, 50, 60.0, 5.0)
        
end

function test_namedWindow()
    println("test namedWindow function")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    cv2.namedWindow("test", 1)
    cv2.imshow("test", img)
    cv2.waitKey(5)
    cv2.imclose("test")
end


function test_HOGDescriptor()
    println("test HOGDescriptor, getDefaultPeopleDetector, setSVMDetector, detectMultiScale.")
    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "test", "jl", "people-01.jpg"))

    hog = cv2.HOGDescriptor()
    def = cv2.getDefaultPeopleDetector(hog)
    cv2.setSVMDetector(hog, def)
    rects, weights = cv2.detectMultiScale(hog,cv2.InputArray(img))
end

function test_CascadeClassifier()
    println("test ")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "test", "sample.jpg"))
    carCascade = cv2.CascadeClassifier()
    cv2.load(carCascade, joinpath(Pkg.dir("LibOpenCV"), "test", "haarcascade_cars3.xml"))
    inarr = cv2.InputArray(img)
    recs, nl, lw = cv2.detectMultiScaleRejectLevels(carCascade, inarr, outputRejectLevels=true)
end

function test_threshold()
    println("test thrshold")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    inarr = cv2.InputArray(img)
    oimg = cv2.clone(img)
    outarr = cv2.OutputArray(oimg)
    cv2.threshold(inarr, outarr, 0.0, 255, 1)
end

function test_minMaxLoc()
    prinlnt("test minMaxLoc")

    img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
    inarr = cv2.InputArray(img)
    cv2.minMaxLoc(inarr)

end
