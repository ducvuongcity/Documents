#ifndef CONTACTMANAGER_H
#define CONTACTMANAGER_H

#include <QObject>
#include <QtQuick>
#include "contactmodel.h"

class ContactManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ContactModel> list READ list CONSTANT)

private:
    QList<ContactModel*> m_list;

public:
    explicit ContactManager(QObject *parent = 0);
    void add(ContactModel *contact);
    Q_INVOKABLE void add(QString name, QString number);
    Q_INVOKABLE void modify(int index, QString name, QString number);
    Q_INVOKABLE void remove(int index);
    Q_INVOKABLE void swap(int srcIndex, int dstIndex);
    QQmlListProperty<ContactModel> list();

    void toString();

signals:
    void sgn_requestUpdateListView();

    //auto reload
    void listChanged();
};

#endif // CONTACTMANAGER_H
