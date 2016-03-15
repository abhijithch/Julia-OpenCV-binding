using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "test", "lineup.jpg"))
hog = cv2.HOGDescriptor()
def = cv2.getDefaultPeopleDetector(hog)
cv2.setSVMDetector(hog, def)
rects, weights = cv2.detectMultiScale(hog,cv2.InputArray(img))
for r in rects
    cv2.rectangle(img, (23, 46, 78), r)
end
cv2.imshow("Blah", img)
cv2.waitKey(0)
