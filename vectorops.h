#ifndef VECTOROPS_H
#define VECTOROPS_H

#include <gsl/gsl_vector.h>
#include <gsl/gsl_histogram.h>


gsl_histogram* vector2histogram( gsl_vector *vector, int numBins=20 );




#endif // VECTOROPS_H
