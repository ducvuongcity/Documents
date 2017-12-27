#include "Client2.h"

Client2::Client2()
{
    m_contactManager = new ContactManager();
    m_smReadWrite = new QSharedMemory(KEY_CHANGED);
    m_temp = new QSharedMemory(KEY_CONTACT);

    m_timer = new QTimer();
    QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(slt_readStatus()));
//    QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(slt_readContactFromSharedMemory()));
    QObject::connect(this, SIGNAL(sgn_newContactFound()), this, SLOT(slt_readContactFromSharedMemory()));
    m_timer->start(2000);
}

Client2::~Client2()
{
    delete m_smReadWrite;
    delete m_timer;
}

ContactManager &Client2::getContactList()
{
    return *m_contactManager;
}

void Client2::slt_readStatus()
{
    QString readStatus;

//    m_smReadWrite->setKey(KEY_CHANGED);
    if (!m_smReadWrite->attach())
        return;

    m_smReadWrite->lock();
    readStatus = QString((char*)m_smReadWrite->constData());
    m_smReadWrite->unlock();
    m_smReadWrite->detach();

    LOG << "Client 2 read status: " << readStatus;

    if (readStatus == NOTIFY_CHANGED) {


//        //Reset status
        if (m_smReadWrite->isAttached()) {
            if(m_smReadWrite->detach())
                LOG << "Client 2 detach STATUS SEGMENT: " << QString((char*)m_smReadWrite->constData());
            else
                LOG << "Client 2 can't detach STATUS SEGMENT: " << m_smReadWrite->errorString();
            m_smReadWrite->detach();
        }

//        m_smReadWrite->setKey(KEY_CHANGED);
        if (!m_smReadWrite->create(NOTIFY_DEFAULT.size())){
            LOG << "Client 2 cant't create STATUS SEGMENT" << m_smReadWrite->errorString();
            return;
        }
        m_smReadWrite->lock();
        memcpy((char*)m_smReadWrite->data(), NOTIFY_DEFAULT.toStdString().c_str(), m_smReadWrite->size());
        m_smReadWrite->unlock();
        LOG << "Client 2 update status: " << QString((char*)m_smReadWrite->constData());
////        m_smReadWrite->detach();

        emit sgn_newContactFound();
    }


}

void Client2::slt_readContactFromSharedMemory()
{
    QString readData;

    m_smReadWrite->setKey(KEY_CONTACT);
    if (!m_smReadWrite->attach()) {
        LOG << "Segment not found: " << m_smReadWrite->errorString();
        return;
    }

    m_smReadWrite->lock();
    readData = QString((char*)m_smReadWrite->constData());
    m_smReadWrite->unlock();
    m_smReadWrite->detach();
    LOG << "Client 2 read contact: " << readData;



}

