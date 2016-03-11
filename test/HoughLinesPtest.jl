using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
gimg = cv2.Mat()
inarr = cv2.InputArray(img)
outarr = cv2.OutputArray(gimg)
cv2.cvtColor(inarr, outarr, cv2.CV_BGR2GRAY)
hin = cv2.InputArray(gimg)
lines = cv2.HoughLinesP(hin, 1.0, cv2.CV_PI/180.0, 50, 60.0, 5.0)
