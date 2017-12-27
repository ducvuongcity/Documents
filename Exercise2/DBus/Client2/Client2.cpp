#include "Client2.h"

Client2::Client2()
{
    m_contactManager = new ContactManager();

    new ContactAdaptor(this);

    QDBusConnection::sessionBus().registerService(CONTACT_SERVICE);
    QDBusConnection::sessionBus().registerObject(CONTACT_PATH, this);

    com::ducvuongcity::contact *pIface = new com::ducvuongcity::contact(QString(), QString(), QDBusConnection::sessionBus(), this);
    QObject::connect(pIface, SIGNAL(sgn_sendContact(QString,QString)), this, SLOT(slt_revContactToDbus(QString,QString)));
}

ContactManager &Client2::getContactList()
{
    return *m_contactManager;
}

void Client2::slt_revContactToDbus(QString name, QString number)
{
    LOG << "Client 2 rev contact: " << name << ", " << number;
    m_contactManager->add(name, number);

    //response
    QDBusMessage msg = QDBusMessage::createSignal(CONTACT_PATH, CONTACT_SERVICE, "sgn_sendReply");
    msg << "Client 2 Received";
    QDBusConnection::sessionBus().send(msg);
    LOG << "Send reply";
}
