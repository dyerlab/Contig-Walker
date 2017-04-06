#ifndef PLOTOPS_H
#define PLOTOPS_H

#include <gsl/gsl_vector.h>
#include "vector.h"
#include <QChart>
using namespace QtCharts;


QChart* barChartFromVector(Vector *theVec , QString title);


#endif // PLOTOPS_H
