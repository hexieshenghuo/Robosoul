TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp \
    ../../../Vision/C/CameraDS/CameraDS.cpp \
    ../../../Vision/C/BinocularCameras.cpp


HEADERS += \
    ../../../Vision/C/CameraDS/CameraDS.h \
    ../../../Vision/C/BinocularCameras.h


include(deployment.pri)
qtcAddDeployment()

#OpenCV包含文件
INCLUDEPATH +=D:\OpenCV\build\include
INCLUDEPATH +=D:\OpenCV\build\include\opencv
INCLUDEPATH +=D:\OpenCV\build\include\opencv2

#RoboSoul包含文件
INCLUDEPATH +=G:\RoboSoul\Vision\C
INCLUDEPATH +=G:\RoboSoul\Vision\C\CameraDS
INCLUDEPATH +=G:\RoboSoul\Vision\C\CameraDS\DirectShow\Include
LIBS +=G:\RoboSoul\Vision\C\CameraDS\DirectShow\Lib\strmiids.lib


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
