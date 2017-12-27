#ifndef CONTACTMODEL_H
#define CONTACTMODEL_H

#include <QObject>
#include <QDebug>

class ContactModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString contactName READ contactName WRITE setContactName NOTIFY contactNameChanged)
    Q_PROPERTY(QString contactNumber READ contactNumber WRITE setContactNumber NOTIFY contactNumberChanged)

private:
    QString m_contactName;
    QString m_contactNumber;

public:
    explicit ContactModel(QObject *parent = 0);
    ContactModel(QString name, QString number, QObject *parent = 0);

    QString contactName() const;
    void setContactName(QString name);

    QString contactNumber() const;
    void setContactNumber(QString number);

    void toString();

signals:
    void contactNameChanged();
    void contactNumberChanged();

public slots:
};

#endif // CONTACTMODEL_H
