#-------------------------------------------------
#
# Project created by QtCreator 2017-01-03T23:22:21
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = BottleMeasuringSystem
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h


HEADERS  += MainWindow.h


INCLUDEPATH +=../../Vision/C
INCLUDEPATH +=../../AuxOper/C

SOURCES += main.cpp \
    ../../Vision/C/BasicOperation.cpp \
    ../../AuxOper/C/FileOper.cpp

HEADERS  += ../../Vision/C/BasicOperation.h \
    ../../AuxOper/C/FileOper.h


INCLUDEPATH +=D:\OpenCV\build\include
INCLUDEPATH +=D:\OpenCV\build\include\opencv
INCLUDEPATH +=D:\OpenCV\build\include\opencv2

CONFIG +=debug_and_release

# 不同模式配置
CONFIG(release,release|debug){
   #release mode
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ml2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_calib3d2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_contrib2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_core2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_features2d2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_flann2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_gpu2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_highgui2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_imgproc2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_legacy2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_objdetect2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ts2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_video2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_nonfree2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ocl2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_photo2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_stitching2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_superres2412.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_videostab2412.lib
}
else{
   # debug mode
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ml2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_calib3d2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_contrib2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_core2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_features2d2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_flann2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_gpu2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_highgui2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_imgproc2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_legacy2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_objdetect2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ts2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_video2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_nonfree2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_ocl2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_photo2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_stitching2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_superres2412d.lib
   LIBS += D:\OpenCV\build\x86\vc12\lib\opencv_videostab2412d.lib
}
