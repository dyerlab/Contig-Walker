/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphwidget.cpp
*
*  Created: 5 2017 by rodney
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

#include "graphwidget.h"
#include "chartops.h"

#include <QDebug>
#include <QChartView>
#include <QVBoxLayout>


GraphWidget::GraphWidget(Graph *theGraph, QWidget *parent) : QWidget(parent)
{

    graphScene = new GraphScene();
    graphView = new GraphView(graphScene);
    graphView->setAttribute(Qt::WA_MacShowFocusRect, false);

    mainLayout = new QHBoxLayout(this);
    mainLayout->addWidget(graphView);
    mainLayout->setContentsMargins(0,0,0,0);

    graphLayout = new QVBoxLayout();
    mainLayout->addLayout( graphLayout );


    if( theGraph )
        changeGraph(theGraph);

    this->setLayout( mainLayout );
    this->setStyleSheet("background-color:white");
}


void GraphWidget::changeGraph(Graph *theGraph){
    Q_ASSERT( theGraph );

    graphScene->setGraph( theGraph );

    // Do DEGREE
    qDebug() << "Degree";
    QChart *degreeChart = histogram( theGraph->centrality(CENTRALITY_DEGREE),20, "Degree Distribution");
    if( degreeChart ) {
        if( !degreeView ){
            degreeView = new QChartView(degreeChart);
            degreeView->setRenderHint(QPainter::Antialiasing);
            graphLayout->addWidget( degreeView );
        } else {
            degreeView->setChart( degreeChart);
        }
    }

    // Do CLOSENESS
    qDebug() << "Closeness";
    QChart *closenessChart = histogram( theGraph->centrality(CENTRALITY_CLOSENESS),20, "Degree Distribution");
    if( closenessChart ) {
        if( !closenessView ){
            closenessView = new QChartView(closenessChart);
            closenessView->setRenderHint(QPainter::Antialiasing);
            graphLayout->addWidget( closenessView );
        } else {
            closenessView->setChart( closenessChart );
        }
    }


    /*

    // Do Betweenness
    qDebug() << "Betweenness";
    QChart *betweennessChart = histogram( theGraph->centrality(CENTRALITY_CLOSENESS),20, "Degree Distribution");
    if( betweennessChart ){
        if( !betweennessView ){
            betweennessView = new QChartView(betweennessChart);
            betweennessView->setRenderHint(QPainter::Antialiasing);
            graphLayout->addWidget( betweennessView );
        } else {
            betweennessView->setChart( betweennessChart );
        }

    }
    */

    qDebug() << "Done";

    // Add bottom stretch
    graphLayout->addStretch(20);


    // make the rest of the graph go.

    graphView->resetLayout();
    graphView->itemMoved();

}
