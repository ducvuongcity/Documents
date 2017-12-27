#ifndef CLIENT2_H
#define CLIENT2_H

#include <QObject>
#include <QSharedMemory>
#include <QTimer>

#include "contactmanager.h"

#define KEY_CONTACT         QString("ContactShared")
#define KEY_CHANGED         QString("NewContact")
#define NOTIFY_DEFAULT      QString("NoChang")
#define NOTIFY_CHANGED      QString("Changed")
#define LOG                 qDebug()

class Client2 : public QObject
{
    Q_OBJECT

private:
    QSharedMemory *m_smReadWrite;
    QSharedMemory *m_temp;
    ContactManager *m_contactManager;
    QTimer *m_timer;

public:
    Client2();
    ~Client2();
    ContactManager& getContactList();

signals:
    void sgn_newContactFound();


public slots:
    void slt_readStatus();
    void slt_readContactFromSharedMemory();

};

#endif // CLIENT2_H
