#include "SamplePathWidget.h"

SamplePathWidget::SamplePathWidget(QWidget *parent)
    : QWidget(parent)
{
    if (this->objectName().isEmpty())
        this->setObjectName(QStringLiteral("TestWidget"));
    this->resize(534, 42);
    PathText = new QLineEdit(this);
    PathText->setObjectName(QStringLiteral("PathText"));
    PathText->setGeometry(QRect(10, 9, 271, 21));

    groupBox = new QGroupBox(this);
    groupBox->setObjectName(QStringLiteral("groupBox"));
    groupBox->setGeometry(QRect(340, 0, 91, 31));

    RadioP = new QRadioButton(groupBox);
    RadioP->setText("P");
    RadioP->setObjectName(QStringLiteral("RadioP"));
    RadioP->setGeometry(QRect(10, 10, 89, 16));

    RadioN = new QRadioButton(groupBox);
    RadioN->setObjectName(QStringLiteral("RadioN"));
    RadioN->setGeometry(QRect(50, 10, 31, 16));
    RadioN->setText("N");

    PathBtn = new QPushButton(this);
    PathBtn->setObjectName(QStringLiteral("PathBtn"));
    PathBtn->setText("路径");
    PathBtn->setGeometry(QRect(290, 10, 41, 23));

    CloseBtn = new QPushButton(this);
    CloseBtn->setText("确定");
    CloseBtn->setObjectName(QStringLiteral("pushButton_2"));
    CloseBtn->setGeometry(QRect(440, 10, 75, 23));

    SampleLabel=0;

    //信号连接
    connect(RadioP,SIGNAL(toggled(bool)),this,SLOT(GetRadioBtnState()));
//  connect(RadioN,SIGNAL(toggled(bool)),this,SLOT(GetRadioBtnState()));
    connect(PathBtn,SIGNAL(clicked(bool)),this,SLOT(GetDirectory()));
    connect(CloseBtn,SIGNAL(clicked(bool)),this,SLOT(CloseWidget()));
}

SamplePathWidget::~SamplePathWidget()
{

}

int SamplePathWidget::GetRadioBtnState()
{
    SampleLabel=RadioP->isChecked();
//    cout<<SampleLabel<<endl;
    return 0;
}

int SamplePathWidget::GetDirectory()
{
    PathName=QFileDialog::getExistingDirectory();
    PathText->setText(PathName);
    return 0;
}

int SamplePathWidget::CloseWidget()
{
    emit SendData(PathName,SampleLabel);
    close();
    return 0;
}
