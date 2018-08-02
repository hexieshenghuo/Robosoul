#ifndef MOTOR_H
#define MOTOR_H

#include <QObject>
#include <QSerialPort>
#include <QTimer>
#include <QString>
#include <QDebug>
#include <string>
#include <FileOper.h>

using namespace std;

class Motor : public QObject
{
    Q_OBJECT
public:
    explicit Motor(QObject *parent = 0);
    ~Motor();

    QSerialPort* SerialPort;

    int Open(char* FileName);

    char BlowOn[9];   //吹瓶开
    char BlowOFF[9];  //吹瓶关

    char ShuntOn[9];   //分流气泵开
    char ShuntOFF[9];  //分流气泵关

    string ComName;
    QTimer* BeginTimer; //吹瓶开始定时器
    QTimer* EndTimer;   //吹瓶结束定时器

    QTimer* ShuntBeginTimer;  //
    QTimer* ShuntEndTimer;    //

    long ms1; //吹瓶电磁阀从发指令到开启的时间
    long ms2; //吹瓶电磁阀打开的时间，即吹多长时间
    long ShuntOnTime;
    long ShuntOffTime;

    string DelayTimeFileName;

signals:
    int ShowMessage(QString Str);
public slots:
    int SendCommand();
    void Clean(long Time);
    void On();
    void Off();
    void ShuntOnSlot();    //分流开
    void ShuntOffSlot();   //分流关

//    void GetBackOn();
//    void GetBackOff();

//    void serialRead();
};

#endif // MOTOR_H
