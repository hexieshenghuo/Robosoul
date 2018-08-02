TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp

include(deployment.pri)
qtcAddDeployment()

INCLUDEPATH +=D:\OpenCV\build\include
INCLUDEPATH +=D:\OpenCV\build\include\opencv
INCLUDEPATH +=D:\OpenCV\build\include\opencv2

LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_ml249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_calib3d249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_contrib249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_core249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_features2d249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_flann249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_gpu249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_highgui249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_imgproc249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_legacy249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_objdetect249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_ts249.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_video249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_nonfree249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_ocl249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_photo249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_stitching249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_superres249.dll.a
LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_videostab249.dll.a
