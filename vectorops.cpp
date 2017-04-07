#include "vectorops.h"

gsl_histogram* vector2histogram(gsl_vector *vec , int numBins){
    gsl_histogram *hist = gsl_histogram_calloc( numBins );
    double mn = gsl_vector_min(vec);
    double mx = gsl_vector_max(vec);
    gsl_histogram_set_ranges_uniform(hist,mn,mx);

    for( size_t i=0;i<vec->size;++i){
        gsl_histogram_increment(hist, gsl_vector_get(vec,i));
    }

    return hist;
}

