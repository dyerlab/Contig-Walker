#include "plotops.h"

#include <QBarSet>
#include <QBarSeries>


QChart* barChartFromVector( Vector *theVec, QString title ) {
    QBarSet *set = new QBarSet("Main");

    for(int i=0;i<theVec->count();++i) {
        set->append(theVec->get(i) );
    }

    QBarSeries *series = new QBarSeries();
    series->append(set);

    QChart *chart = new QChart();
    chart->addSeries(series);
    chart->setTitle(title);
    chart->setAnimationOptions(QChart::SeriesAnimations);

    return chart;

}

