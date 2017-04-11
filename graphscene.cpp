/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphscene.cpp
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

#include <QDebug>
#include "graphscene.h"

GraphScene::GraphScene(QObject *parent) : QGraphicsScene(parent)
{
    backgroundColor = Qt::white;
    setBackgroundBrush( backgroundColor);
    setSceneRect(0,0,1000,1000);

}

QList<GraphicNode*> GraphScene::getNodes() {
    QList<GraphicNode*> ret;
    foreach(QGraphicsItem *item, items() ){
        GraphicNode *node = qgraphicsitem_cast<GraphicNode*>(item);
        if( node )
            ret.append( node );
    }
    return ret;
}

QList<GraphicEdge*> GraphScene::getEdges() {
    QList<GraphicEdge*> ret;
    foreach( QGraphicsItem *item, items() ){
        GraphicEdge *edge = qgraphicsitem_cast<GraphicEdge*>(item);
        if( edge )
            ret.append(edge);
    }
    return ret;
}

void GraphScene::mousePressEvent(QGraphicsSceneMouseEvent *event) {
    QGraphicsScene::mousePressEvent( event );
}
