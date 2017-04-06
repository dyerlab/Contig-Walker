#ifndef GRAPHANALYSISDEGREE_H
#define GRAPHANALYSISDEGREE_H

#include "vector.h"
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

private:
    Vector *in_degree;
    Vector *out_degree;
};

#endif // GRAPHANALYSISDEGREE_H
