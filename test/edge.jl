#Test for Canny edge detection
using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
img = cv2.InputArray(img)

a = cv2.Mat()
out = cv2.OutputArray(a)

cv2.Canny(img, out, 100, 100)

cv2.imshow("Canny edge detection", a)
