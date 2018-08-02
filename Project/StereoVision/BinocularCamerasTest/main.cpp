/*---------------------------------------------------------------------------------
文件名称：BinocularCamerasTest.cpp
版本：
功能：RS.Vision
目的：用测试BinocularCameras类
作者：MaLe
说明：
   1)基于DriectShow，因此只能用于VS编译器
修改记录:

File Name: BinocularCameras.h
Version:  1.0
Function: RS.Vision
Objective:
Descriprtion:
Revise Record:

---------------------------------------------------------------------------------*/
#include <BinocularCameras.h>
#include <highgui.h>

#include<iostream>
using namespace std;

int main()
{
    BinocularCameras* BiCamera=new BinocularCameras;

    int res=BiCamera->Open();

    cout<<res<<endl;
    cvNamedWindow("L");
    cvNamedWindow("R");

    BiCamera->CreateOutImage();
    for(;;)
    {
        BiCamera->UpdateOutImage();

        cvShowImage("L", BiCamera->OutImageL);
        cvShowImage("R", BiCamera->OutImageR);
        if (cvWaitKey(1) == 'q')
        {
            break;
        }
    }

    cvDestroyWindow("L");
    cvDestroyWindow("R");
    BiCamera->Close();
    delete BiCamera;

    return 0;
}
