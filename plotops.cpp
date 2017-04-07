#include "plotops.h"

#include <QBarSet>
#include <QBarSeries>
#include <QBarCategoryAxis>


QChart* makeBarChart(gsl_vector *theVec, QStringList labels, QString title ) {
    QBarSet *set = new QBarSet("Main");

    for(int i=0;i<(int)theVec->size;++i) {
        set->append( gsl_vector_get(theVec, i) );
    }

    QBarSeries *series = new QBarSeries();
    series->append(set);

    QChart *chart = new QChart();
    chart->addSeries(series);
    chart->setTitle(title);
    chart->setAnimationOptions( QChart::SeriesAnimations );

    QBarCategoryAxis *axis = new QBarCategoryAxis();
    axis->append(labels);
    axis->setLabelsAngle(90);
    chart->createDefaultAxes();
    chart->setAxisX(axis, series);

    return chart;
}

