#ifndef ALERT_H
#define ALERT_H

#include <QtCore/QObject>
#include <QtCore/QString>
#include <QtCore/QDateTime>
#include <QtCore/QUrl>

class Alert: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    explicit Alert(int id, QString title, QString text, QDateTime timestamp, QUrl link);
    explicit Alert(int id, QString title, QString text, QDateTime timestamp);
    int id() const;
    void setId(int id);
    QString title() const;
    void setTitle(const QString &title);
    QString text() const;
    void setText(const QString &text);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);
    QUrl link() const;
    void setLink(const QUrl &link);

signals:
    void idChanged();
    void titleChanged();
    void textChanged();

private:
    int m_id;
    QString m_title;
    QString m_text;
    QDateTime m_timestamp;
    QUrl m_link;
};

#endif // ALERT_H
