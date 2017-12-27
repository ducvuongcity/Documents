#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Client.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Client client;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Client", &client);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
