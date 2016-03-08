using LibOpenCV

cap = cv2.VideoCapture(0)
mat = cv2.Mat()


while true
    cap >> mat
    cv2.imshow("video", mat)
    cv2.waitKey(1)
    sleep(0.02)
end
