#ifndef CLIENT1_H
#define CLIENT1_H

#include <QObject>
#include <QSharedMemory>
#include <QDebug>

#include <QBuffer>
#include <QDataStream>

#define KEY_CONTACT         QString("ContactShared")
#define KEY_CHANGED         QString("NewContact")
#define NOTIFY_DEFAULT      QString("NoChange")
#define NOTIFY_CHANGED      QString("Changed")
#define LOG                 qDebug()

class Client1 : public QObject
{
    Q_OBJECT

private:
    QSharedMemory *m_smWrite;

public:
    Client1();
    Q_INVOKABLE void writeContactToSharedMemory(QString name, QString number);

};

#endif // CLIENT1_H
