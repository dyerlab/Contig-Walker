/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  dataset.cpp
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

#include <QDir>
#include <QDebug>
#include <QtGlobal>
#include "dataset.h"
#include <QApplication>
#include <QProgressDialog>

DataSet::DataSet(QObject *parent) : QObject(parent) {

}

DataSet::~DataSet() {
    foreach( GraphDataSet *gds, this->theGraphs)
        delete gds;
}

bool DataSet::loadGraphsFromFolder(QString path) {
    QStringList filters;
    filters << "*.json";

    QDir *dataDir = new QDir(path);
    dataDir->setNameFilters(filters);
    dataDir->setFilter( QDir::Files );
    dataDir->makeAbsolute();
    if( !dataDir->count() ) {
        qDebug() << "No graph files in that folder";
        return false;
    }
    int ctr = 0;
    QProgressDialog progress(QObject::tr("Loading graph files"),
                             QObject::tr("Cancel"),
                             0, dataDir->entryList().count(),
                             qApp->activeWindow());

    foreach(QString dataFilePath, dataDir->entryList()){


        QString dataFile = dataDir->absoluteFilePath( dataFilePath );

        GraphDataSet *graphDataSet = new GraphDataSet( this );
        if( graphDataSet->loadGraph( dataFile, PARSE_TYPE_GRAPH_JSON) ) {
            theGraphs.append( graphDataSet );
            qDebug() << "Adding" << path;
        }
        else {
            qDebug() << "Deleting graphDataSet";
            delete graphDataSet;
        }
        progress.setValue(++ctr);
        qApp->processEvents();
    }

    progress.setValue(dataDir->entryList().count());
    qApp->processEvents();

    delete dataDir;
    return (theGraphs.count() > 0) ;
}
