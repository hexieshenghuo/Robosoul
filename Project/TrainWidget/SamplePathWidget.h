#ifndef SAMPLEPATHWIDGET_H
#define SAMPLEPATHWIDGET_H

#include <QWidget>
#include <QApplication>
#include <QButtonGroup>
#include <QGroupBox>
#include <QHeaderView>
#include <QLineEdit>
#include <QPushButton>
#include <QRadioButton>
#include <QString>
#include <QFileDialog>

//#include <iostream>
//using namespace std;

class SamplePathWidget : public QWidget
{
    Q_OBJECT

public:
    SamplePathWidget(QWidget *parent = 0);
    ~SamplePathWidget();
public:
    QLineEdit *PathText;
    QGroupBox *groupBox;
    QRadioButton *RadioP;
    QRadioButton *RadioN;
    QPushButton *PathBtn;
    QPushButton *CloseBtn;

    int SampleLabel;
    QString PathName;
signals:
    int SendData(QString& pathName,int sampleLabel);

public slots:
    int GetRadioBtnState();
    int GetDirectory();
    int CloseWidget();
};

#endif // TRAINWIDGET_H
