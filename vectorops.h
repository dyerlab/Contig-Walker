#ifndef VECTOROPS_H
#define VECTOROPS_H

#include <gsl/gsl_histogram.h>
#include "vector.h"

gsl_histogram* vector2histogram( Vector *vector, int numBins=20 );
Vector* vector2bins( Vector *vec, int numBins = 20);



#endif // VECTOROPS_H
