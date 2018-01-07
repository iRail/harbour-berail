/*
*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   BeRail is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
*/
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
    this->setId(id);
    this->setTitle(title);
    this->setText(text);
    this->setTimestamp(timestamp);
    this->setLink(link);
}

Alert::Alert(int id, QString title, QString text, QDateTime timestamp)
{
    this->setId(id);
    this->setTitle(title);
    this->setText(text);
    this->setTimestamp(timestamp);
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
    emit this->idChanged();
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
    emit this->titleChanged();
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
    emit this->textChanged();
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
    emit this->timestampChanged();
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
    this->setHasLink(link.url().length() > 0);
    emit this->linkChanged();
}

bool Alert::hasLink() const
{
    return m_hasLink;
}

void Alert::setHasLink(bool hasLink)
{
    m_hasLink = hasLink;
}
