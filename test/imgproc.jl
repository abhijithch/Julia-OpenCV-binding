using LibOpenCV

#People detector test
h = cv2.HOGDescriptor()
out = cv2.getDefaultPeopleDetector(h)
@test length(out) == 3781
@test sum(out) - 17.829723 < 1e-4
