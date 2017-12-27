#ifndef CLIENT1_H
#define CLIENT1_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>

#define LOG qDebug()
#define HOST_IP QString("127.0.0.1")
#define PORT    8888

class Client : public QObject
{
    Q_OBJECT

private:
    QTcpSocket *m_socket;
    QTimer *m_timer;

public:
    Client();
    ~Client();
    Q_INVOKABLE void sendContactToServer(QString name, QString number);
    Q_INVOKABLE void connectToServer(QString ip, QString port);
    Q_INVOKABLE void disconnectToServer();

signals:
    void sgn_revReply(QString reply);
    void sgn_updateStatus(QString status);

public slots:
    void slt_revReply(QString reply);
    void slt_updateConnectStatus();

};

#endif // CLIENT1_H
