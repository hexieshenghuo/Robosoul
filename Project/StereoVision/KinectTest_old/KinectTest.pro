TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp \
    ../../../Vision/C/Kinect.cpp

include(deployment.pri)
qtcAddDeployment()

HEADERS += \
    ../../../Vision/C/Kinect.h

#INCLUDEPATH +=G:\RoboSoul\Vision\C
INCLUDEPATH  +=\
    ../../../Vision/C/

#OpenNI
INCLUDEPATH +=D:/Kinect/OpenNI/Include
LIBS +=D:/Kinect/OpenNI/Lib/openNI.lib
LIBS +=D:/Kinect/OpenNI/Lib/NiSampleExtensionModule.lib
LIBS +=D:/Kinect/OpenNI/Lib/NiSampleModule.lib

#OpenCV
INCLUDEPATH +=D:/OpenCV/build/include
INCLUDEPATH +=D:/OpenCV/build/include/opencv
INCLUDEPATH +=D:/OpenCV/build/include/opencv2

#---------VS
CONFIG +=debug_and_release
# 不同模式配置
CONFIG(debug,debug|release){
   # debug mode
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ml249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_calib3d249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_contrib249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_core249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_features2d249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_flann249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_gpu249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_highgui249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_imgproc249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_legacy249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_objdetect249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ts249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_video249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_nonfree249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ocl249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_photo249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_stitching249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_superres249d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_videostab249d.lib
}
else{
   #release mode
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_objdetect249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ts249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_video249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_nonfree249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ocl249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_photo249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_stitching249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_superres249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_videostab249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_calib3d249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_contrib249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_core249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_features2d249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_flann249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_gpu249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_highgui249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_imgproc249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_legacy249.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ml249.lib
}


#---------MinGW
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_ml249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_calib3d249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_contrib249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_core249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_features2d249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_flann249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_gpu249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_highgui249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_imgproc249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_legacy249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_objdetect249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_ts249.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_video249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_nonfree249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_ocl249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_photo249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_stitching249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_superres249.dll.a
#LIBS += D:\OpenCV_MinGW\x64\mingw\lib\libopencv_videostab249.dll.a