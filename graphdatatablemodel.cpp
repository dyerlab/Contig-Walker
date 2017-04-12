/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphdatatablemodel.cpp
*
*  Created: 4 2017 by rodney
*
*  Copyright 2017 rodney.  All Rights Reserved.
*
* This file may be distributed under the terms of GNU Public License version
* 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
* license should have been included with this file, or the project in which
* this file belongs to. You may also find the details of GPL v3 at:
*
* http://www.gnu.org/licenses/gpl-3.0.txt
*
* If you have any questions regarding the use of this file, feel free to
* contact the author of this file, or the owner of the project in which
* this file belongs to.
*
******************************************************************************/

#include "graphdatatablemodel.h"

GraphDataTableModel::GraphDataTableModel(DataSet *theData, QObject *parent) : QAbstractTableModel(parent)
{
    this->theData = theData;
}


int GraphDataTableModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED( parent );
    return 4;
}

int GraphDataTableModel::columnCount(const QModelIndex &parent) const {
    Q_UNUSED( parent );
    return theData->count();
}

QVariant GraphDataTableModel::data(const QModelIndex &index, int role) const {
    QVariant ret;

    if( role == Qt::DisplayRole ){
        int displayType = index.row();
        int graphID = index.column();
        Graph *theGraph = theData->graph( graphID );


        switch (displayType) {
        case TABLE_ROW_PATH:
            ret = QVariant( theGraph->path() );
            break;

        case TABLE_ROW_GRAPH:
            ret = QVariant("Graph image here");
            break;

        case TABLE_ROW_SIZE:
            ret = QVariant(  QString("Nodes %1; Edges %2").arg(theGraph->numNodes()).arg(theGraph->numEdges()));
            break;

        case TABLE_ROW_DEGREE:
            ret = QVariant("Degree");
            break;
        }

    }
    else
        ret = QVariant();


    return ret;

}
