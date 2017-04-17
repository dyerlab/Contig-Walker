/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  chartswidget.cpp
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

#include "chartswidget.h"
#include "chartops.h"
#include <gsl/gsl_vector.h>
#include <QtCharts>

#include "graphops.h"

ChartsWidget::ChartsWidget(Graph *theGraph, QWidget *parent) : QWidget(parent)
{
    Q_ASSERT( theGraph );

    gsl_vector *deg = theGraph->centrality( CENTRALITY_DEGREE );
    gsl_vector *clo = theGraph->centrality( CENTRALITY_CLOSENESS );
    gsl_vector *btw = theGraph->centrality( CENTRALITY_BETWEENESS );

    mainLayout = new QVBoxLayout(this);

    QChart *degChart = histogram(deg,20,QString("Degree Centrality"));
    QChartView *degView = new QChartView( degChart );
    degView->setRenderHint(QPainter::Antialiasing);
    mainLayout->addWidget( degView );

    QChart *cloChart =  histogram(clo,20,QString("Closeness Centrality"));
    QChartView *cloView = new QChartView(cloChart);
    mainLayout->addWidget( cloView );

    QChart *btwChart = histogram(btw,20,QString("Betweenness Centrality"));
    QChartView *btwView = new QChartView( btwChart );
    mainLayout->addWidget(  btwView );

    gsl_vector_free( deg );
    gsl_vector_free( clo );
    gsl_vector_free( btw );
}
