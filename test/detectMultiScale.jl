using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "test", "people-01.jpg"))

hog = cv2.HOGDescriptor()
def = cv2.getDefaultPeopleDetector(hog)
cv2.setSVMDetector(hog, def)
rects, weights = cv2.detectMultiScale(hog,cv2.InputArray(img))
