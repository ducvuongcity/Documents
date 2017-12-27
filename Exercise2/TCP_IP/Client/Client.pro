TEMPLATE = app

QT += qml quick
CONFIG += c++11

HEADERS += \
    Client.h \

SOURCES += main.cpp \
    Client.cpp \

RESOURCES += qml.qrc \
    image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
