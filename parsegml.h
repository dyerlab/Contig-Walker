#ifndef PARSEGML_H
#define PARSEGML_H

#include "parser.h"
#include <QXmlStreamReader>

class ParseGML : public Parser
{
public:
    ParseGML(QString path, QObject *parent = 0);

    bool parse();

};

#endif // PARSEGML_H
