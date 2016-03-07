# Test the cvtColor function

using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
gimg = cv2.Mat()
inarr = cv2.InputArray(img)
outarr = cv2.OutputArray(gimg)
cv2.cvtColor(inarr, outarr, cv2.CV_BGR2GRAY)
cv2.imshow("Blur", gimg)
cv2.waitKey(0)
