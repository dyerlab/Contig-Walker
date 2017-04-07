#ifndef PLOTOPS_H
#define PLOTOPS_H

#include <gsl/gsl_vector.h>

#include <QChart>
#include <QString>
#include <QStringList>

using namespace QtCharts;


QChart* makeBarChart(gsl_vector *theVec, QStringList labels, QString title);


#endif // PLOTOPS_H
