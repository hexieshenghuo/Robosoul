#include <QCoreApplication>
#include <BasicOperation.h>
#include <FileOper.h>
#include <RandomForest.h>
#include <FeatCreator.h>

#define test1 (1) //图像分割--颜色分割
#define test2 (2) //图像分割--纹理分割
#define test3 (3) //图像分割--图像融合
#define test4 (4) //热斑检测--梯度特征+随机森林分类器
#define test5 (5) //热斑检测--Faster-RCNN
#define test6 (6) //热斑定位--光流法
#define test7 (7) //热斑定位--LSD直线检测
#define test8 (8) //热斑定位
#define test9 (9) //综合测试

#define Running 5

#if(Running==test1)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);


    return a.exec();
}

#elif(Running==test2)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    return a.exec();
}

#elif(Running==test3)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);


    return a.exec();
}

#elif(Running==test4)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);



    return a.exec();
}

#elif(Running==test5)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    CvCapture*capture=cvCaptureFromAVI("F:/RoboSoul/Project/PhotovoltaicPanelDetection/DetectVideos/2017_00.mp4");
    IplImage*img=0;


    return a.exec();
}

#elif(Running==test6)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    return a.exec();
}

#elif(Running==test7)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    return a.exec();
}

#elif(Running==test8)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    return a.exec();
}

#elif(Running==test9)
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    return a.exec();
}
#endif
