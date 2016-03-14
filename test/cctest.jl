using LibOpenCV

# Need to give full paths of images and classifier xml files
img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "test", "sample.jpg"))
carCascade = cv2.CascadeClassifier()
cv2.load(carCascade, joinpath(Pkg.dir("LibOpenCV"), "test", "haarcascade_cars3.xml"))
inarr = cv2.InputArray(img)
# recs, nds = cv2.detectMultiScale(carCascade, inarr)
# Output reject levels needs to be true due to a bug in OpenCV C++ code
recs, nl, lw = cv2.detectMultiScaleRejectLevels(carCascade, inarr, outputRejectLevels=true)
