using LibOpenCV

#People detector test
h = cv2.HOGDescriptor()
out = cv2.getDefaultPeopleDetector(h)
@test length(out) == 3781
@test sum(out) - 17.829723 < 1e-4

# Test the cvtColor function


img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))
gimg = cv2.Mat()
inarr = cv2.InputArray(img)
outarr = cv2.OutputArray(gimg)
kimg = cv2.Mat()
kernel = cv2.InputArray(kimg)

p2 = cv2.Point(-1,-1)
#cv2.Sobel(inarr, outarr, 1,2,3,1, 1.0, 0.0,1)
#cv2.filter2D(inarr, outarr, 1, kernel, p2, 0.0, 1)

