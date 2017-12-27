#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQuick>

#include "contactmodel.h"
#include "contactmanager.h"
#include "Client2.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<ContactModel>();

    Client2 client2;

    client2.getContactList().add(new ContactModel("Nguyen Duc Vuong", "01685753613"));
    client2.getContactList().add(new ContactModel("Tran Van Tuyen", "0987654321"));
    client2.getContactList().add(new ContactModel("Cao Dac Hau", "01656597721"));
    client2.getContactList().add(new ContactModel("Nguyen Duc Thinh", "0123456789"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));
    client2.getContactList().add(new ContactModel("Hoang Van Quang", "0963852741"));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("AppModel", &client2.getContactList());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
