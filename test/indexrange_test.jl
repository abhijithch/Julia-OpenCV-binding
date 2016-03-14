using LibOpenCV

img = cv2.imread(joinpath(Pkg.dir("LibOpenCV"), "doc", "figures", "Lena.jpg"))

submat = img[1:3, 2:4]

println("Submatrix is : ", submat)
