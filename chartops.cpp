/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  chartops
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

#include "chartops.h"

QChart* histogram(gsl_vector *data, int num_bins , QString title) {
    gsl_histogram *hist = gsl_histogram_alloc( num_bins );
    for(size_t i=0;i<data->size;i++){
        gsl_histogram_increment(hist, gsl_vector_get( data, i) );
    }

    QBarSet *set = new QBarSet("Main");
    for( size_t i=0; i < hist->n; i++){
        set->append( (qreal)gsl_histogram_get(hist,i) );
    }

    QBarSeries *series = new QBarSeries();
    series->append(set);

    QChart *chart = new QChart();
    chart->addSeries( series );
    chart->setTitle( title );
    chart->setAnimationOptions( QChart::SeriesAnimations );
    return chart;

}

