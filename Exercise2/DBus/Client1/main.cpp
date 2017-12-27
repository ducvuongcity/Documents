#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Client1.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    if (!QDBusConnection::sessionBus().isConnected()) {
        qWarning("Cannot connect to the D-Bus session bus.\n"
                 "Please check your system settings and try again.\n");
        return 0;
    }

    Client1 client1;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Client1", &client1);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
