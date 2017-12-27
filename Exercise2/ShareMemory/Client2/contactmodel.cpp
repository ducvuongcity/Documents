#include "contactmodel.h"

ContactModel::ContactModel(QObject *parent) : QObject(parent)
{}

ContactModel::ContactModel(QString name, QString number, QObject *parent) : QObject(parent)
{
    m_contactName = name;
    m_contactNumber = number;
}

QString ContactModel::contactName() const
{
    return m_contactName;
}

void ContactModel::setContactName(QString name)
{
    if (m_contactName != name) {
        m_contactName = name;
        emit contactNameChanged();
        qDebug() << "set name: " << name;
    }
}

QString ContactModel::contactNumber() const
{
    return m_contactNumber;
}

void ContactModel::setContactNumber(QString number)
{
    if (m_contactNumber != number) {
        m_contactNumber = number;
        qDebug() << "set number: " << number;
        emit contactNumberChanged();
    }
}

void ContactModel::toString()
{
    qDebug() << "Name: " << m_contactName << ", number: " << m_contactNumber << endl;
}
