using LibOpenCV

cap = cv2.VideoCapture(0)
mat = cv2.Mat()


while true
    #oarr = cv2.OutputArray(mat)
    #cv2.read(cap, oarr)
    cap >> mat
    cv2.imshow("video", mat)
    cv2.waitKey(1)
    sleep(0.02)
    println("running")
end
