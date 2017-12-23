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
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
    Q_PROPERTY(QUrl link READ link WRITE setLink NOTIFY linkChanged)
    Q_PROPERTY(bool hasLink READ hasLink NOTIFY hasLinkChanged)

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
    bool hasLink() const;
    void setHasLink(bool hasLink);

signals:
    void idChanged();
    void titleChanged();
    void textChanged();
    void timestampChanged();
    void linkChanged();
    void hasLinkChanged();

private:
    int m_id;
    QString m_title;
    QString m_text;
    QDateTime m_timestamp;
    QUrl m_link;
    bool m_hasLink;
};

#endif // ALERT_H
