#include "Motor.h"
#include <QThread>

//吹瓶开 0x00, 0x5A, 0x40, 0x00, 0x01, 0x01, 0x00, 0x00, 0x9C

//吹瓶关 0x00, 0x5A, 0x40, 0x00, 0x02, 0x01, 0x00, 0x00, 0x9D

//三相阀开 0x00, 0x5A, 0x40, 0x00, 0x01, 0x02, 0x00, 0x00, 0x9D

//三相阀关 0x00, 0x5A, 0x40, 0x00, 0x02, 0x02, 0x00, 0x00, 0x9E

Motor::Motor(QObject *parent) : QObject(parent)
{
    BeginTimer = new QTimer(this);
    EndTimer = new QTimer(this);
    ShuntBeginTimer=new QTimer(this);
    ShuntEndTimer=new QTimer(this);

    connect(BeginTimer,SIGNAL(timeout()),this,SLOT(On()));
    connect(EndTimer,SIGNAL(timeout()),this,SLOT(Off()));
    connect(ShuntBeginTimer,SIGNAL(timeout()),this,SLOT(ShuntOnSlot()));
    connect(ShuntEndTimer,SIGNAL(timeout()),this,SLOT(ShuntOffSlot()));

    char TempBlowOn[9]={0x00, 0x5A, 0x40, 0x00, 0x01, 0x01, 0x00, 0x00, 0x9C};
    memcpy(BlowOn,TempBlowOn,sizeof(char)*9);

    char TempBlowOff[9]={0x00, 0x5A, 0x40, 0x00, 0x02, 0x01, 0x00, 0x00, 0x9D};
    memcpy(BlowOFF,TempBlowOff,sizeof(char)*9);

    char TempShuntOn[9]={0x00, 0x5A, 0x40, 0x00, 0x01, 0x02, 0x00, 0x00, 0x9D};
    memcpy(ShuntOn,TempShuntOn,sizeof(char)*9);

    char TempShuntOff[9]={0x00, 0x5A, 0x40, 0x00, 0x02, 0x02, 0x00, 0x00, 0x9E};
    memcpy(ShuntOFF,TempShuntOff,sizeof(char)*9);


    DelayTimeFileName="F:/RoboSoul/Config/DelayTime.rsc";
    rsLoadDelayTime((char*)DelayTimeFileName.c_str(),&ms1,&ms2,&ShuntOnTime,&ShuntOffTime);

//    ShuntBeginTimer->start(ShuntOnTime);

    //开指令
    //    BlowOn[0]=0x00;
    //    BlowOn[1]=0x5A;
    //    BlowOn[2]=0x54;
    //    BlowOn[3]=0x00;
    //    BlowOn[4]=0x03;
    //    BlowOn[5]=0x00;
    //    BlowOn[6]=0x00;
    //    BlowOn[7]=0x00;
    //    BlowOn[8]=0xB1;
//关指令
//    BlowOFF[0]=0x00;
//    BlowOFF[1]=0x5A;
//    BlowOFF[2]=0x54;
//    BlowOFF[3]=0x00;
//    BlowOFF[4]=0x04;
//    BlowOFF[5]=0x00;
//    BlowOFF[6]=0x00;
//    BlowOFF[7]=0x00;
//    BlowOFF[8]=0xB2;

//分流开
//    ShuntOn[0]=0x00;
//    ShuntOn[1]=0x5A;
//    ShuntOn[2]=0x54;
//    ShuntOn[3]=0x00;
//    ShuntOn[4]=0x04;
//    ShuntOn[5]=0x00;
//    ShuntOn[6]=0x00;
//    ShuntOn[7]=0x00;
//    ShuntOn[8]=0xB2;

//分流关
//    ShuntOFF[0]=0x00;
//    ShuntOFF[1]=0x5A;
//    ShuntOFF[2]=0x54;
//    ShuntOFF[3]=0x00;
//    ShuntOFF[4]=0x04;
//    ShuntOFF[5]=0x00;
//    ShuntOFF[6]=0x00;
//    ShuntOFF[7]=0x00;
//    ShuntOFF[8]=0xB2;
}

Motor::~Motor()
{
    SerialPort->close();
}

int Motor::Open(char* FileName)
{
    rsLoadComName(FileName,ComName);
    SerialPort= new QSerialPort(ComName.c_str());       //串口号，一定要对应好，大写！！！
    SerialPort->open(QIODevice::ReadWrite);      //读写打开
    SerialPort->setBaudRate(QSerialPort::Baud9600);  //波特率
    SerialPort->setDataBits(QSerialPort::Data8); //数据位
    SerialPort->setParity(QSerialPort::NoParity);    //无奇偶校验
    SerialPort->setStopBits(QSerialPort::OneStop);   //无停止位
    SerialPort->setFlowControl(QSerialPort::NoFlowControl);  //无控制

//    connect(SerialPort,SIGNAL(readyRead()),this,SLOT(serialRead()));    //连接槽

    return 0;
}

int Motor::SendCommand()
{
    Clean(0);
    return 0;
}

void Motor::Clean(long Time)
{
//    ShowMessage("Action......");
    //开启延时
    BeginTimer->start(ms1);
}

void Motor::On()
{
   //开电磁阀
// ShowMessage("Action Begin......");

   SerialPort->write(BlowOn,9);

   BeginTimer->stop();
   EndTimer->start(ms2);
}

void Motor::Off()
{
    //经过ms2延时后关闭阀门
//    ShowMessage("Action End......");

    SerialPort->write(BlowOFF,9);

    EndTimer->stop();
}

void Motor::ShuntOnSlot()
{
    ShowMessage("ShuntOn Action......");
    SerialPort->write(ShuntOn,9);

    ShuntBeginTimer->stop();
    ShuntEndTimer->start(ShuntOffTime);
}

void Motor::ShuntOffSlot()
{
    ShowMessage("ShuntOff Action......");
    SerialPort->write(ShuntOFF,9);

    ShuntEndTimer->stop();
    ShuntBeginTimer->start(ShuntOnTime);
}
