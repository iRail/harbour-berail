#include "stationlistmodelfilter.h"

#include <QtCore/QtGlobal>
#include <QtCore/QDebug>

StationListModelFilter::StationListModelFilter()
{
    this->setDynamicSortFilter(false); // Dynamic filtering should be deactivated while manipulating the model
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setFilterRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->setSortRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->setDynamicSortFilter(true);
}

StationListModelFilter::StationListModelFilter(StationListModel *stationListModel)
{
    this->setDynamicSortFilter(false); // Dynamic filtering should be deactivated while manipulating the model
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setSourceModel(stationListModel);
    this->setFilterRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->setSortRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->setDynamicSortFilter(true);
}

StationListModelFilter::StationListModelFilter(StationListModel *stationListModel, StationListModel::Roles sortRole, StationListModel::Roles filterRole)
{
    this->setDynamicSortFilter(false); // Dynamic filtering should be deactivated while manipulating the model
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setSourceModel(stationListModel);
    this->setSortRole(sortRole);
    this->setFilterRole(filterRole);
    this->setDynamicSortFilter(true);
}

bool StationListModelFilter::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = this->sourceModel()->index(sourceRow, 0, sourceParent);
    if(index.isValid()) {
        QVariant rowData = index.data(this->filterRole());
        if(this->filterRole() == StationListModel::NameRole && rowData.isValid()) {
            QString name = rowData.toString();
            return name.indexOf(this->searchName()) >= 0;
        }
        else if(this->filterRole() == StationListModel::LocationRole && rowData.isValid()) {
            QGeoCoordinate location = rowData.value<QGeoCoordinate>();
            return location.distanceTo(this->searchLocation()) <= this->maxRadiusLocation();
        }
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

