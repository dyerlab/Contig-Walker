#include "vectorops.h"
#include "vector.h"

gsl_histogram* vector2histogram(Vector *vector , int numBins){
    gsl_histogram *hist = gsl_histogram_calloc( numBins );
    gsl_vector *vec = vector->raw();
    double mn = gsl_vector_min(vec);
    double mx = gsl_vector_max(vec);
    gsl_histogram_set_ranges_uniform(hist,mn,mx);

    for( size_t i=0;i<vec->size;++i){
        gsl_histogram_increment(hist, gsl_vector_get(vec,i));
    }

    return hist;
}

Vector* vector2bins( Vector *vec, int numBins ) {
    gsl_histogram *hist = vector2histogram(vec,numBins);
    Vector *theVec = new Vector(numBins);
    for( size_t i=0;i<hist->n;i++) {
        double mn;
        double mx;
        gsl_histogram_get_range(hist,i,&mn, &mx);
        double center = (mx-mn)/2;
        QString key = QString("%1").arg(center,5);
        theVec->setLabel(i, key);
        theVec->set(i,gsl_histogram_get(hist,i));
    }
    return theVec;
}
