#ifndef GRAPHANALYSISDEGREE_H
#define GRAPHANALYSISDEGREE_H

#include "vectorops.h"
#include "graphanalysis.h"

typedef enum {
    DEGREE_TYPE_BOTH,
    DEGREE_TYPE_IN,
    DEGREE_TYPE_OUT
} DEGREE_TYPE;

class GraphAnalysisDegree : public GraphAnalysis
{
public:
    GraphAnalysisDegree(Graph *theGraph);

    bool run();

    inline gsl_vector* getInDegree() const { return in_degree; }
    inline gsl_vector* getOutDegree() const { return out_degree; }

    gsl_vector* getDegreeDistribution();

private:
    gsl_vector *in_degree;
    gsl_vector *out_degree;
};

#endif // GRAPHANALYSISDEGREE_H
