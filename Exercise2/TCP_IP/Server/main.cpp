#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQuick>

#include "contactmodel.h"
#include "contactmanager.h"
#include "Server.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<ContactModel>();

    Server server;

    server.getContactList().add("Nguyen Duc Vuong", "01685753613");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("AppModel", &server.getContactList());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
