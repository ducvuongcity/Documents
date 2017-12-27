#ifndef CLIENT2_H
#define CLIENT2_H

#include <QObject>
#include <QtDBus/QDBusConnection>

#include "ContactInterface.h"
#include "ContactAdaptor.h"
#include "contactmanager.h"

#define CONTACT_SERVICE "com.ducvuongcity.contact"
#define CONTACT_PATH    "/Contact"
#define LOG qDebug()

class Client2 : public QObject
{
    Q_OBJECT

private:
    ContactManager *m_contactManager;

public:
    Client2();
    ContactManager& getContactList();

public slots:
    void slt_revContactToDbus(QString name, QString number);

};

#endif // CLIENT2_H
