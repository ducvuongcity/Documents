TEMPLATE = app

QT += qml quick
CONFIG += c++11

HEADERS += contactmodel.h \
    contactmanager.h \
    Server.h

SOURCES += main.cpp \
    contactmodel.cpp \
    contactmanager.cpp \
    Server.cpp

RESOURCES += qml.qrc \
    image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
