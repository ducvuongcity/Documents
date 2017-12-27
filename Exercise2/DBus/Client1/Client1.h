#ifndef CLIENT1_H
#define CLIENT1_H

#include <QObject>
#include <QTimer>

#include <QtDBus/QDBusConnection>
#include "ContactInterface.h"
#include "ContactAdaptor.h"

#define CONTACT_SERVICE "com.ducvuongcity.contact"
#define CONTACT_PATH    "/Contact"
#define LOG qDebug()

class Client1 : public QObject
{
    Q_OBJECT

public:
    Client1();
    Q_INVOKABLE void sendContactToDbus(QString name, QString number);

signals:
    void sgn_revReply(QString reply);

public slots:
    void slt_revReply(QString reply);

};

#endif // CLIENT1_H
