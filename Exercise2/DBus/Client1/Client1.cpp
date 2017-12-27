#include "Client1.h"

Client1::Client1()
{
    new ContactAdaptor(this);
    QDBusConnection::sessionBus().registerService(CONTACT_SERVICE);
    QDBusConnection::sessionBus().registerObject(CONTACT_PATH, this);
    com::ducvuongcity::contact *pIface = new com::ducvuongcity::contact(QString(), QString(), QDBusConnection::sessionBus(), this);
    QObject::connect(pIface, SIGNAL(sgn_sendReply(QString)), this, SLOT(slt_revReply(QString)));
}

void Client1::sendContactToDbus(QString name, QString number)
{
    QDBusMessage msg = QDBusMessage::createSignal(CONTACT_PATH, CONTACT_SERVICE, "sgn_sendContact");
    msg << name << number;
    QDBusConnection::sessionBus().send(msg);
    LOG << "send contact: " << name << ", " << number << " to Client2";
}

void Client1::slt_revReply(QString reply)
{
    LOG << "Reply: " << reply;
    emit sgn_revReply(reply);
}
