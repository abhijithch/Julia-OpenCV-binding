# C++ compiler 
CXX = g++
CFLAGS= -fPIC -shared -o
TARGET = ./libcv2.so
LIBS = -L/usr/local/opt/opencv3/lib -lopencv_highgui -lopencv_core -lopencv_calib3d -lopencv_features2d -lopencv_flann -lopencv_imgcodecs -lopencv_imgproc -lopencv_ml -lopencv_objdetect -lopencv_photo -lopencv_shape -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videoio
SOURCE = ./src/cpp/*.cpp
INCLUDE = -I/usr/local/opt/opencv3/include
libcv2:
	$(CXX) $(INCLUDE) $(SOURCE) $(CFLAGS) $(TARGET) $(LIBS)

