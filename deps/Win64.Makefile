# MinGW 64 build
# First build opencv with mingw64-g++ 
# Add this to environment variable PATH: C:/opencv/build64/install/x64/mingw/bin
# Also add deps/windows to PATH

CXX=C:/Program\ Files/mingw-w64/x86_64-5.3.0-posix-seh-rt_v4-rev0/mingw64/bin/x86_64-w64-mingw32-g++

CFLAGS = -Wall -fpic
BUILD_DIR = build
LIB_DIR = windows/libcv2.dll

LIBS = -L C:/opencv/build64/install/x64/mingw/lib

LDFLAGS = -lopencv_highgui310 -lopencv_core310 -lopencv_calib3d310 -lopencv_features2d310 -lopencv_flann310 -lopencv_imgcodecs310 -lopencv_imgproc310 -lopencv_ml310 -lopencv_objdetect310 -lopencv_photo310 -lopencv_shape310 -lopencv_stitching310 -lopencv_superres310 -lopencv_video310 -lopencv_videoio310

SOURCE_DIR = ../src/cpp
INCLUDE=-I C:/opencv/build64/install/include
OBJECTS = $(BUILD_DIR)/Mat.o $(BUILD_DIR)/imgproc.o $(BUILD_DIR)/cv2.o $(BUILD_DIR)/videoio.o $(BUILD_DIR)/tracking.o

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	$(CXX) $(INCLUDE) $(CFLAGS) -c -o $@ $<

$(LIB_DIR): $(OBJECTS)
	$(CXX) $(LIBS) -shared -o $(LIB_DIR) $(BUILD_DIR)/*.o $(LDFLAGS)

all: $(LIB_DIR)

clean:
	rm -rf build/*.o
	rm -rf usr/lib/*.*
