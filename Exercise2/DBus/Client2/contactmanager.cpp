#include "contactmanager.h"

ContactManager::ContactManager(QObject *parent) : QObject(parent)
{
}

void ContactManager::add(ContactModel *contact)
{
    m_list.append(contact);
}

void ContactManager::add(QString name, QString number)
{
    m_list.push_back(new ContactModel(name, number));
    emit sgn_requestUpdateListView();
}

void ContactManager::modify(int index, QString name, QString number)
{
    m_list.at(index)->setContactName(name);
    m_list.at(index)->setContactNumber(number);

    qDebug() << "Modify name: " << name << ", number: " << number;
}

void ContactManager::remove(int index)
{
    if(index < m_list.size())
        m_list.erase(m_list.begin() + index);
}

void ContactManager::swap(int src, int dst)
{
    m_list.swap(src, dst);
    emit sgn_requestUpdateListView();
}

QQmlListProperty<ContactModel> ContactManager::list()
{
    return QQmlListProperty<ContactModel>(this, m_list);
}

void ContactManager::toString()
{
    qDebug() << "List Contact";
    for (int i = 0; i < m_list.size(); ++i) {
        qDebug() << "\rName: " << m_list.at(i)->contactName() << ", Number: " << m_list.at(i)->contactNumber();
    }
}
