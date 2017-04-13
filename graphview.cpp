/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphview.cpp
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

#include <QtGlobal>
#include <QKeyEvent>
#include "graphview.h"

GraphView::GraphView(GraphScene *scene) : QGraphicsView(scene) {
    resetLayout();
    setInteractive(true);
    setRenderHints( QPainter::Antialiasing | QPainter::SmoothPixmapTransform | QPainter::TextAntialiasing | QPainter::HighQualityAntialiasing );
    setSceneRect(0,0,1000,1000);
}


void GraphView::itemMoved() {
    if( !timerID )
        timerID = startTimer( 1000/25 );
}

void GraphView::resetLayout() {
    timerID = 0;
    canMove = true;
    temperature = 100.0;
}

/*********************  EVENTS *************************/

void GraphView::timerEvent(QTimerEvent *event) {
    Q_UNUSED( event );

    if( !canMove )
        return;

    GraphScene *scene = qobject_cast<GraphScene*>( this->scene() );

    if( scene ) {
        scene->calculateNodeForces( temperature );
        temperature = (temperature > 0.5 ) ? 0.999 * temperature : 0.45;
    }

}


void GraphView::keyPressEvent(QKeyEvent *event) {
    switch( event->key() ){
    case Qt::Key_R:
        shuffleNodes();
        break;

    case Qt::Key_L:
        toggleLabels();
        break;

    case Qt::Key_Escape:
        canMove = !canMove;
        itemMoved();
        break;

    case Qt::Key_PageDown:
        scaleNodes( 1.0/1.2 );
        break;

    case Qt::Key_PageUp:
        scaleNodes( 1.2 );
        break;

    case Qt::Key_Plus:
        zoom( ZOOM_IN );
        break;

    case Qt::Key_Minus:
        zoom( ZOOM_OUT );
        break;

    default:
        break;
    }
}



void GraphView::shuffleNodes() {
    GraphScene *scene = qobject_cast<GraphScene*>( this->scene() );
    QList<Node*> nodes = scene->getNodes();
    foreach(Node* node, nodes )
        node->setPos( qrand() % (int)scene->height(),
                      qrand() % (int)scene->height() );
    itemMoved();
}


void GraphView::toggleLabels() {
    GraphScene *scene = qobject_cast<GraphScene*>( this->scene() );
    QList<Node*> nodes = scene->getNodes();
    foreach(Node* node, nodes )
        node->toggleLabel();
    update();
}

void GraphView::scaleNodes(double val) {
    GraphScene *scene = qobject_cast<GraphScene*>( this->scene() );
    QList<Node*> nodes = scene->getNodes();
    foreach(Node* node, nodes ) {
        double newSize = node->getSize() * val;
        if( newSize > 4 && newSize < 26 )
            node->setSize(newSize);
    }
    update();
}

void GraphView::zoom(ZOOM_DIRECTION direction) {
    if( direction == ZOOM_OUT )
        scale(1.2,1.2);
    else
        scale(1/1.2, 1/1.2);
}
