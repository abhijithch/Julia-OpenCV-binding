using LibOpenCV
using Base.Test

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))

rrange = 10:12
crange = 20:23
subrrange = 1:3
subcrange = 1:4

submat = img[rrange, crange]

println("Submatrix is : ")
for i = subrrange
    for j = subcrange
        print(submat[i, j])
    end
    println()
end

println("Source image of submatrix is : ")
for i = rrange
    for j = crange
        print(img[i, j])
    end
    println()
end

for i = subrrange
    for j = subcrange
        @test submat[i, j] == img[rrange.start + i - 1, crange.start + j - 1]
    end
end

println("Passed: sub matrix equal to source")



println("Setting pixels in box to 0")
img[rrange, crange] = [0x00, 0x00, 0x00]
for i = rrange
    for j = crange
        @test img[i, j] == [0x00, 0x00, 0x00]
    end
end

println("Passed: pixels set")


println("Setting pixels in box to 1 using Array")
arr = Array(Any, length(subrrange), length(subcrange))
for i = subrrange
    for j = subcrange
        arr[i, j] = [0x01, 0x01, 0x01]
    end
end

img[rrange, crange] = arr
for i = rrange
    for j = crange
        @test img[i, j] == [0x01, 0x01, 0x01]
    end
end

println("Passed: pixels set")

println("\n\n\n--- Testing with grayscale image ---\n")

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
gimg = cv2.Mat()
inarr = cv2.InputArray(img)
outarr = cv2.OutputArray(gimg)
cv2.cvtColor(inarr, outarr, cv2.CV_BGR2GRAY)

submat = gimg[rrange, crange]

println("Submatrix is : ")
for i = subrrange
    for j = subcrange
        print(string(submat[i, j]) * ", ")
    end
    println()
end

println("Source image of submatrix is : ")
for i = rrange
    for j = crange
        print(string(gimg[i, j]) * ", ")
    end
    println()
end

for i = subrrange
    for j = subcrange
        @test submat[i, j] == gimg[rrange.start + i - 1, crange.start + j - 1]
    end
end

println("Passed: sub matrix equal to source")



println("Setting pixels in box to 0")
gimg[rrange, crange] = 0x00
for i = rrange
    for j = crange
        @test gimg[i, j] == 0x00
    end
end

println("Passed: pixels set")


println("Setting pixels in box to 1 using Array")
arr = Array(Any, length(subrrange), length(subcrange))
for i = subrrange
    for j = subcrange
        arr[i, j] = 0x01
    end
end

gimg[rrange, crange] = arr
for i = rrange
    for j = crange
        @test gimg[i, j] == 0x01
    end
end

println("Passed: pixels set")
