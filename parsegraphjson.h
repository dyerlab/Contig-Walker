#ifndef PARSEGRAPHJSON_H
#define PARSEGRAPHJSON_H

#include "graph.h"
#include "parser.h"




class ParseGraphJSON : public Parser
{
public:
    ParseGraphJSON(QString path = QString(), QObject *parent = 0);

    bool parse();

    inline Graph* getGraph() { return theGraph; }

private:
    Graph *theGraph;

};

#endif // PARSEGRAPHJSON_H
