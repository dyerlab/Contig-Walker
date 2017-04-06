#ifndef GRAPHANALYSIS_H
#define GRAPHANALYSIS_H


#include "graph.h"
#include "vector.h"
#include <gsl/gsl_matrix.h>

#include <QString>
#include <QStringList>

class GraphAnalysis
{
public:
    GraphAnalysis(Graph *graph);

    inline QString getResultsText() { return results; }
    inline QStringList getErrors() { return errors; }
    virtual bool run() = 0;

    bool check();

protected:
    Graph *theGraph;
    QString results;
    QStringList errors;
};

#endif // GRAPHANALYSIS_H
