TEMPLATE = app

QT += qml quick
CONFIG += c++11

HEADERS += \
    Client1.h

SOURCES += main.cpp \
    Client1.cpp

RESOURCES += qml.qrc \
    image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
