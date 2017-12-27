#include "Server.h"

Server::Server()
{
    m_contactManager = new ContactManager();
    m_server = new QTcpServer();
    QObject::connect(m_server, SIGNAL(newConnection()), this, SLOT(slt_connectionHandler()));
    if (m_server->listen(QHostAddress::Any, PORT)) {
        LOG << "Server started";
    }
    else
        LOG << "Server start error";
}

Server::~Server()
{
    delete m_contactManager;
    delete m_server;
}

ContactManager &Server::getContactList()
{
    return *m_contactManager;
}

void Server::slt_connectionHandler()
{
    m_socket = m_server->nextPendingConnection();
    QObject::connect(m_socket, SIGNAL(readyRead()), this, SLOT(slt_revContactFromClient()));
}

void Server::slt_revContactFromClient()
{
    QString msg = m_socket->readAll();
    QStringList list = msg.split('\n');
    QString name, number;
    if (list.size() > 1) {
        if (list.at(0).split(':').size() > 1) {
            name = list.at(0).split(':').at(1);
        }
        if (list.at(1).split(':').size() > 1) {
            number = list.at(1).split(':').at(1);
        }
        m_contactManager->add(name, number);
        emit sgn_requestUpdateListView();
    }
    else
        LOG << msg;
}
