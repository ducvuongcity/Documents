#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Client1.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Client1 client1;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Client1", &client1);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
