TEMPLATE = app

QT += qml quick dbus
CONFIG += c++11

INCLUDEPATH += ../qdbus

HEADERS += contactmodel.h \
    contactmanager.h \
    ../qdbus/ContactAdaptor.h \
    ../qdbus/ContactInterface.h \
    Client2.h

SOURCES += main.cpp \
    contactmodel.cpp \
    contactmanager.cpp \
    ../qdbus/ContactAdaptor.cpp \
    ../qdbus/ContactInterface.cpp \
    Client2.cpp

RESOURCES += qml.qrc \
    image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
