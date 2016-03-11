using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))

println("The image at [10, 10] is: ", img[10, 10])

gimg = cv2.Mat()
inarr = cv2.InputArray(img)
outarr = cv2.OutputArray(gimg)
cv2.cvtColor(inarr, outarr, cv2.CV_BGR2GRAY)

println("The greyed image at [10, 10] is: ", gimg[10, 10])

gimg[10, 10] = 123
img[10, 10] = [123, 123, 123]

println("New value at [10, 10] for img is: ", img[10, 10])
println("New value at [10, 10] for greyed image is: ", gimg[10, 10])
