#ifndef PARSEGRAPHJSON_H
#define PARSEGRAPHJSON_H

#include "graph.h"
#include "parser.h"




class ParseGraphJSON : public Parser
{
public:
    ParseGraphJSON(QString path = QString(), QObject *parent = 0);

    bool parse();


};

#endif // PARSEGRAPHJSON_H
