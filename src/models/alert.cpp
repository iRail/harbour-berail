#include "alert.h"

/**
 * @class Alert
 * @brief Alert constructor.
 * @param id
 * @param title
 * @param text
 */
Alert::Alert(int id, QString title, QString text, QDateTime timestamp, QUrl link)
{
    setId(id);
    setTitle(title);
    setText(text);
    setTimestamp(timestamp);
    setLink(link);
}

Alert::Alert(int id, QString title, QString text, QDateTime timestamp)
{
    setId(id);
    setTitle(title);
    setText(text);
    setTimestamp(timestamp);
}

/*********************
 * Getters & Setters *
 *********************/

/**
 * @class Alert
 * @brief id getter.
 * @return int
 */
int Alert::id() const
{
    return m_id;
}

/**
 * @class Alert
 * @brief id setter.
 * @param id
 */
void Alert::setId(int id)
{
    m_id = id;
}

/**
 * @class Alert
 * @brief title getter.
 * @return QString
 */
QString Alert::title() const
{
    return m_title;
}

/**
 * @class Alert
 * @brief title setter.
 * @param title
 */
void Alert::setTitle(const QString &title)
{
    m_title = title;
}

/**
 * @class Alert
 * @brief text getter.
 * @return QString
 */
QString Alert::text() const
{
    return m_text;
}

/**
 * @class Alert
 * @brief text setter.
 * @param text
 */
void Alert::setText(const QString &text)
{
    m_text = text;
}

/**
 * @class Alert
 * @brief timestamp getter.
 * @return QDateTime
 */
QDateTime Alert::timestamp() const
{
    return m_timestamp;
}

/**
 * @class Alert
 * @brief timestamp setter.
 * @param timestamp
 */
void Alert::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
}

/**
 * @class Alert
 * @brief link getter.
 * @return QUrl
 */
QUrl Alert::link() const
{
    return m_link;
}

/**
 * @class Alert
 * @brief link setter.
 * @param link
 */
void Alert::setLink(const QUrl &link)
{
    m_link = link;
}
