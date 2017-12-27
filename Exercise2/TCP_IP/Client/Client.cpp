#include "Client.h"

Client::Client()
{
    m_socket = new QTcpSocket();
    m_timer = new QTimer();
    QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(slt_updateConnectStatus()));
//    QObject::connect(m_socket, SIGNAL(disconnected()), this, SLOT(slt_updateConnectStatus()));
    m_timer->start(1000);
}

Client::~Client()
{
    delete m_socket;
    delete m_timer;
}

void Client::sendContactToServer(QString name, QString number)
{
    if (m_socket->state() == QTcpSocket::ConnectedState) {
        m_socket->write(QString("name:%1\nnumber:%2").arg(name).arg(number).toLatin1());
        LOG << "Send msg " << QString("name:%1\nnumber:%2").arg(name).arg(number) << "to Server";
    }
    else
        LOG << "not connected";
}

void Client::connectToServer(QString ip, QString port)
{
    if (m_socket->state() == QTcpSocket::ConnectedState || m_socket->state() == QTcpSocket::ConnectingState) {
        m_socket->disconnectFromHost();
    }
    m_socket->connectToHost(ip, port.toInt());
}

void Client::disconnectToServer()
{
    if (m_socket->state() == QTcpSocket::ConnectedState || m_socket->state() == QTcpSocket::ConnectingState)
        m_socket->disconnectFromHost();
}

void Client::slt_revReply(QString reply)
{
    LOG << "Reply: " << reply;
    emit sgn_revReply(reply);
}

void Client::slt_updateConnectStatus()
{
    if (m_socket->state() == QTcpSocket::ConnectedState) {
        emit sgn_updateStatus("Connected");
    }
    else
        emit sgn_updateStatus("Disconnected");
}
