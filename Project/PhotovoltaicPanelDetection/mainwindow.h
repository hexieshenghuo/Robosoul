#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QLabel>
#include <QFont>
#include <QPalette>
#include <QString>
#include <QStringList>
#include <QTextCodec>
#include <QImage>
#include <QRadioButton>
#include <QTextEdit>
#include <QMenuBar>
#include <QToolBar>
#include <QGroupBox>
#include <QPushButton>
#include <QTableView>
#include <QTableWidget>
#include <QComboBox>
#include <QTableWidgetItem>
#include <QAbstractItemView>
#include <QHeaderView>

#include "pvDetector.h"

#define SHOWWID       (360)
#define SHOWHEI       (240)

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget*parent = 0);
    ~MainWindow();

public:
    // UI
    QWidget *centralWidget;
    QLabel *label;
    QTextEdit*RunningInfor;
    QMenuBar *menuBar;
    QToolBar *mainToolBar;
    QGroupBox* groupBox1;
    QGroupBox* groupBox2;
    QGroupBox* groupBox3;  // 数据表
    QLabel *Display;       // 图像显示
    QTableWidget*Table;
    QComboBox* IntervalBox;
    QLabel* IntervalLabel;


    QRadioButton *P;
    QRadioButton *N;

    QPushButton* StartDetect;
    QPushButton* StartStitch;
    QPushButton* StopThread;
    QPushButton* UpdateSpotInfor;

    //--- 后台功能
    pvDetector*detector;

signals:
    void SendMessage(QString Str);

public slots:
    void ImageShow(QImage img);
    void ShowMessage(QString Str);
    void TypeChanged();
    void onIntervalBox(int Index);
    void onStartDetect();
    void onStartStitch();
    void onStopThread();
    void onUpdateSpotInfor();
    void Retrieval(int Row,int Col);
};

#endif // MAINWINDOW_H
