#ifndef CLIENT2_H
#define CLIENT2_H

#include <QObject>
#include <QTcpServer>

#include "contactmanager.h"

#define PORT    8888
#define LOG qDebug()

class Server : public QObject
{
    Q_OBJECT

private:
    ContactManager *m_contactManager;
    QTcpServer *m_server;
    QTcpSocket *m_socket;

public:
    Server();
    ~Server();
    ContactManager& getContactList();

signals:
    void sgn_requestUpdateListView();

public slots:
    void slt_connectionHandler();
    void slt_revContactFromClient();

};

#endif // CLIENT2_H
