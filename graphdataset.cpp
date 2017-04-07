/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphdataset.cpp
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

#include "graphdataset.h"

GraphDataSet::GraphDataSet(QObject *parent) : QObject(parent) {
    theGraph = NULL;
}

GraphDataSet::~GraphDataSet() {
    if( theGraph != NULL )
        delete theGraph;
}

bool GraphDataSet::loadGraph( QString path, PARSE_TYPE type ) {
    ParseGraphJSON *parser;
    bool parse_status;

    if( type == PARSE_TYPE_GRAPH_JSON )
        parser = new ParseGraphJSON( path, this);
    else {
        qDebug() << "Incorrect parser.";
        return false;
    }

    parse_status = parser->parse();

    if( parse_status ) {
        theGraph = parser->getGraph();
    }

    delete parser;
    return parse_status;
}

void GraphDataSet::setGraph( Graph *graph ) {
    if( theGraph != NULL )
        delete theGraph;

    theGraph = graph;
}
