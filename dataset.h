/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  dataset.h
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

#ifndef DATASET_H
#define DATASET_H

#include <QList>
#include <QString>
#include <QObject>
#include "graph.h"

class DataSet : public QObject
{
    Q_OBJECT
public:
    explicit DataSet(QObject *parent = 0);
    ~DataSet();

    bool loadGraphsFromFolder( QString path );

    inline int count() const { return theGraphs.count(); }

    inline Graph* graph(int idx ) { return theGraphs.at(idx); }

    void setUnifiedNodeCoordinates();

signals:

public slots:



private:
    QList<Graph*> theGraphs;
};

#endif // DATASET_H
