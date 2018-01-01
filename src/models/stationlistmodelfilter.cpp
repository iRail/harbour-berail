#include "stationlistmodelfilter.h"

StationListModelFilter::StationListModelFilter()
{
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setFilterRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->setSortRole(StationListModel::NameRole); // Default Qt::DisplayRole
}

StationListModelFilter::StationListModelFilter(StationListModel *stationListModel)
{
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setSourceModel(stationListModel);
    this->setFilterRole(StationListModel::NameRole); // Default Qt::DisplayRole
    this->setSortRole(StationListModel::NameRole); // Default Qt::DisplayRole
}

StationListModelFilter::StationListModelFilter(StationListModel *stationListModel, StationListModel::Roles sortRole, StationListModel::Roles filterRole)
{
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setSourceModel(stationListModel);
    this->setSortRole(sortRole);
    this->setFilterRole(filterRole);
}

bool StationListModelFilter::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = this->sourceModel()->index(sourceRow, 0, sourceParent);
    if(index.isValid()) {
        QVariant rowData = index.data(this->filterRole());
        if(this->filterRole() == StationListModel::NameRole && rowData.isValid()) {
            QString name = rowData.toString().toLower().simplified(); // ignore uppercase and remove spaces
            return name.indexOf(this->searchName().toLower().simplified()) >= 0;
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
    this->invalidate();
}

QGeoCoordinate StationListModelFilter::searchLocation() const
{
    return m_searchLocation;
}

void StationListModelFilter::setSearchLocation(const QGeoCoordinate &searchLocation)
{
    m_searchLocation = searchLocation;
    this->invalidate();
}

QString StationListModelFilter::searchName() const
{
    return m_searchName;
}

void StationListModelFilter::setSearchName(const QString &searchName)
{
    m_searchName = searchName;
    this->invalidate();
}

