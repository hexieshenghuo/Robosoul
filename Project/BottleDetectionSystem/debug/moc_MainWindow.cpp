/****************************************************************************
** Meta object code from reading C++ file 'MainWindow.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../MainWindow.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MainWindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_MainWindow_t {
    QByteArrayData data[25];
    char stringdata0[221];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MainWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MainWindow_t qt_meta_stringdata_MainWindow = {
    {
QT_MOC_LITERAL(0, 0, 10), // "MainWindow"
QT_MOC_LITERAL(1, 11, 11), // "ShowMessage"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 3), // "Str"
QT_MOC_LITERAL(4, 28, 11), // "SendCommand"
QT_MOC_LITERAL(5, 40, 7), // "Command"
QT_MOC_LITERAL(6, 48, 12), // "CommandParam"
QT_MOC_LITERAL(7, 61, 13), // "UpdateMessage"
QT_MOC_LITERAL(8, 75, 11), // "MotorAction"
QT_MOC_LITERAL(9, 87, 4), // "Auto"
QT_MOC_LITERAL(10, 92, 8), // "TaskStop"
QT_MOC_LITERAL(11, 101, 10), // "CreateBack"
QT_MOC_LITERAL(12, 112, 9), // "ImageShow"
QT_MOC_LITERAL(13, 122, 3), // "img"
QT_MOC_LITERAL(14, 126, 11), // "TypeChanged"
QT_MOC_LITERAL(15, 138, 11), // "TrainSample"
QT_MOC_LITERAL(16, 150, 5), // "Train"
QT_MOC_LITERAL(17, 156, 6), // "Detect"
QT_MOC_LITERAL(18, 163, 4), // "Test"
QT_MOC_LITERAL(19, 168, 12), // "ComboBoxProc"
QT_MOC_LITERAL(20, 181, 5), // "Index"
QT_MOC_LITERAL(21, 187, 9), // "ShowCount"
QT_MOC_LITERAL(22, 197, 4), // "good"
QT_MOC_LITERAL(23, 202, 3), // "bad"
QT_MOC_LITERAL(24, 206, 14) // "updateDetector"

    },
    "MainWindow\0ShowMessage\0\0Str\0SendCommand\0"
    "Command\0CommandParam\0UpdateMessage\0"
    "MotorAction\0Auto\0TaskStop\0CreateBack\0"
    "ImageShow\0img\0TypeChanged\0TrainSample\0"
    "Train\0Detect\0Test\0ComboBoxProc\0Index\0"
    "ShowCount\0good\0bad\0updateDetector"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MainWindow[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   94,    2, 0x06 /* Public */,
       4,    2,   97,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    1,  102,    2, 0x0a /* Public */,
       8,    0,  105,    2, 0x0a /* Public */,
       9,    0,  106,    2, 0x0a /* Public */,
      10,    0,  107,    2, 0x0a /* Public */,
      11,    0,  108,    2, 0x0a /* Public */,
      12,    1,  109,    2, 0x0a /* Public */,
      14,    0,  112,    2, 0x0a /* Public */,
      15,    0,  113,    2, 0x0a /* Public */,
      16,    0,  114,    2, 0x0a /* Public */,
      17,    0,  115,    2, 0x0a /* Public */,
      18,    0,  116,    2, 0x0a /* Public */,
      19,    1,  117,    2, 0x0a /* Public */,
      21,    2,  120,    2, 0x0a /* Public */,
      24,    0,  125,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::Int, QMetaType::VoidStar,    5,    6,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QImage,   13,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   20,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   22,   23,
    QMetaType::Void,

       0        // eod
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MainWindow *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->ShowMessage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->SendCommand((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< void*(*)>(_a[2]))); break;
        case 2: _t->UpdateMessage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->MotorAction(); break;
        case 4: _t->Auto(); break;
        case 5: _t->TaskStop(); break;
        case 6: _t->CreateBack(); break;
        case 7: _t->ImageShow((*reinterpret_cast< QImage(*)>(_a[1]))); break;
        case 8: _t->TypeChanged(); break;
        case 9: _t->TrainSample(); break;
        case 10: _t->Train(); break;
        case 11: _t->Detect(); break;
        case 12: _t->Test(); break;
        case 13: _t->ComboBoxProc((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 14: _t->ShowCount((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 15: _t->updateDetector(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (MainWindow::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MainWindow::ShowMessage)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (MainWindow::*_t)(int , void * );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MainWindow::SendCommand)) {
                *result = 1;
                return;
            }
        }
    }
}

const QMetaObject MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWindow.data,
      qt_meta_data_MainWindow,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow.stringdata0))
        return static_cast<void*>(const_cast< MainWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 16)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void MainWindow::ShowMessage(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void MainWindow::SendCommand(int _t1, void * _t2)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
