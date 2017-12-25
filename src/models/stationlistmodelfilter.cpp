#include "stationlistmodelfilter.h"

StationListModelFilter::StationListModelFilter()
{
    this->stationListFilter()->setFilterRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->stationListFilter()->setSortRole(StationListModel::NameRole); // Default Qt::DisplayRole
}

StationListModelFilter::StationListModelFilter(StationListModel* stationListModel)
{
    this->setSourceModel(stationListModel);
    this->stationListFilter()->setFilterRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->stationListFilter()->setSortRole(StationListModel::NameRole); // Default Qt::DisplayRole
}

StationListModelFilter::StationListModelFilter(StationListModel* stationListModel, StationListModel::Roles sortRole, StationListModel::Roles filterRole)
{
    this->setSourceModel(stationListModel);
    this->setSortRole(sortRole);
    this->setFilterRole(filterRole);
}

bool StationListModelFilter::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex rowIndex = this->sourceModel()->index(sourceRow, 0, sourceParent);

    /*switch(this->filterRole())
    {
    case StationListModel::NameRole:
        QString name = this->sourceModel()->data(rowIndex).toString();
        return name.indexOf(this->searchName()) > 0;
        break;

    case StationListModel::LocationRole:
        float distance = this->sourceModel()->data(rowIndex).convert(QGeoCoordinate).distanceTo(this->searchLocation());
        return distance <= this->maxRadiusLocation();
        break;
    }*/

    if(this->filterRole() == StationListModel::NameRole) {
        QString name = this->sourceModel()->data(rowIndex).toString();
        return name.indexOf(this->searchName()) > 0;
    }
    return false;
}

bool StationListModelFilter::lessThan(const QModelIndex &left, const QModelIndex &right) const
{
    /*switch(this->sortRole())
    {
    case StationListModel::NameRole:
        return this->sourceModel()->data(left).toString() < this->sourceModel()->data(right).toString();
        break;

    case StationListModel::LocationRole:
        float distanceLeft = this->sourceModel()->data(left).convert(QGeoCoordinate).distanceTo(this->searchLocation());
        float distanceRight = this->sourceModel()->data(right).convert(QGeoCoordinate).distanceTo(this->searchLocation());
        return distanceLeft < distanceRight;
        break;
    }*/
    if(this->filterRole() == StationListModel::NameRole) {
        return this->sourceModel()->data(left).toString() < this->sourceModel()->data(right).toString();
    }
    return false;
}

double StationListModelFilter::maxRadiusLocation() const
{
    return m_maxRadiusLocation;
}

void StationListModelFilter::setMaxRadiusLocation(double maxRadiusLocation)
{
    m_maxRadiusLocation = maxRadiusLocation;
    this->invalidateFilter();
}

QGeoCoordinate StationListModelFilter::searchLocation() const
{
    return m_searchLocation;
}

void StationListModelFilter::setSearchLocation(const QGeoCoordinate &searchLocation)
{
    m_searchLocation = searchLocation;
    this->invalidateFilter();
}

QString StationListModelFilter::searchName() const
{
    return m_searchName;
}

void StationListModelFilter::setSearchName(const QString &searchName)
{
    m_searchName = searchName;
    this->invalidateFilter();
}

