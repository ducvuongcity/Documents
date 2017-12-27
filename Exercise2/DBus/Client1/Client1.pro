TEMPLATE = app

QT += qml quick dbus
CONFIG += c++11

INCLUDEPATH += ../qdbus


HEADERS += \
    Client1.h \
    ../qdbus/ContactAdaptor.h \
    ../qdbus/ContactInterface.h

SOURCES += main.cpp \
    Client1.cpp \
    ../qdbus/ContactAdaptor.cpp \
    ../qdbus/ContactInterface.cpp

RESOURCES += qml.qrc \
    image.qrc \
    xml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
