#ifndef STATIONLISTMODELFILTER_H
#define STATIONLISTMODELFILTER_H

#include <QtCore/QSortFilterProxyModel>
#include <QtCore/QList>
#include <QtCore/QString>
#include <QtCore/QModelIndex>
#include <QtPositioning/QGeoCoordinate>

#include "stationlistmodel.h"

class StationListModelFilter : public QSortFilterProxyModel
{
public:
    StationListModelFilter();
    StationListModelFilter(StationListModel* stationListModel);
    StationListModelFilter(StationListModel* stationListModel, StationListModel::Roles sortRole, StationListModel::Roles filterRole);
    QString searchName() const;
    void setSearchName(const QString &searchName);
    QGeoCoordinate searchLocation() const;
    void setSearchLocation(const QGeoCoordinate &searchLocation);
    double maxRadiusLocation() const;
    void setMaxRadiusLocation(double maxRadiusLocation);

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const override;

private:
    QString m_searchName;
    QGeoCoordinate m_searchLocation;
    double m_maxRadiusLocation;
};

#endif // STATIONLISTMODELFILTER_H
