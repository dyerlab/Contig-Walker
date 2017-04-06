#include "parser.h"

Parser::Parser(QString path, QObject *parent) : QObject(parent)
{
    if( !path.isEmpty())
        this->path = path;

}


PARSER_STATUS Parser::getStatus() const {
    if( errors.count() && warnings.count() )
        return PARSER_STATUS_FUBAR;
    else if( errors.count())
        return PARSER_STATUS_ERROR;
    else if( warnings.count())
        return PARSER_STATUS_WARNING;
    else
        return PARSER_STATUS_OK;
}


QString Parser::getFeedback(){
    QString ret;

    if( errors.count())
        ret.append( QString("Errors:\n%1").arg(errors.join("\n")));
    if( warnings.count())
        ret.append( QString("Errors:\n%1").arg(warnings.join("\n")));

    return ret;
}
