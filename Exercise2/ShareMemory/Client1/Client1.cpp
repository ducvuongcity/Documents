#include "Client1.h"

Client1::Client1()
{
    m_smWrite = new QSharedMemory();
}

void Client1::writeContactToSharedMemory(QString name, QString number)
{
    QString data = QString("name:%1\nnumber:%2").arg(name).arg(number);
    QBuffer buffer;
    buffer.open(QBuffer::ReadWrite);
    QDataStream ds(&buffer);
    ds << data;

    //write contact
    m_smWrite->setKey(KEY_CONTACT);
    if (!m_smWrite->create(data.size())) {
        LOG << "Can't create shared memory segment";
        return;
    }
    m_smWrite->lock();
    memcpy((char*)m_smWrite->data(), data.toStdString().c_str(), data.size());
    m_smWrite->unlock();
    LOG << "Client 1 write to memory: " << QString((char*)m_smWrite->data());

    //update status
    m_smWrite->setKey(KEY_CHANGED);
    ds << NOTIFY_CHANGED;

    if (!m_smWrite->create(NOTIFY_CHANGED.size())) {
        LOG << "Can't create STATUS segment";
    }
    else {
        m_smWrite->lock();
        memcpy((char*)m_smWrite->data(), NOTIFY_CHANGED.toStdString().c_str(), NOTIFY_CHANGED.size());
        m_smWrite->unlock();
        LOG << "Client 1 update status: " << QString((char*)m_smWrite->constData());
    }
}
