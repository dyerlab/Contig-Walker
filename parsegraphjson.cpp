#include "parsegraphjson.h"

#include "node.h"
#include "edge.h"
#include "graph.h"

#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

ParseGraphJSON::ParseGraphJSON(QString path, QObject *parent) :
    Parser( path, parent )
{

}


bool ParseGraphJSON::parse() {

    if( path.isEmpty() ) {
        errors << "Path not set";
        return false;
    }

    QFile file(path);
    if( !file.open(QIODevice::ReadOnly)) {
        errors << "Cannot open file " << path;
        return false;
    }

    QByteArray contents = file.readAll();
    QJsonDocument doc = QJsonDocument::fromJson(contents);

    if( doc.isEmpty() ) {
        errors <<  "Empty JSON document";
        return false;
    }

    if( doc.isNull() ){
        errors << "JSON Document is NULL";
        return false;
    }

    if( doc.isObject() ){        
        QJsonObject obj = doc.object();

        // bad json, bail out!
        if( !(obj.keys().contains("nodes") && obj.keys().contains("links"))){
            file.close();
            errors << "Not a valid JSON file, no 'nodes' or 'links' objects in it.";
        }

        theGraph = new Graph();

        // Grab the nodes
        QJsonArray nodes = obj.value("nodes").toArray();
        for(int nodeidx = 0; nodeidx<nodes.count();nodeidx++){
            QJsonObject node = nodes[nodeidx].toObject();
            QString label = node["name"].toString();
            double size = node["size"].toDouble();

            Node *theNode = new Node(label,size);

            theGraph->addNode(theNode);
        }



        // Grab the edges
        QJsonArray edges = obj.value("links").toArray();

        for( int i=0;i<edges.count();i++){
            QJsonObject edge = edges[i].toObject();
            int source = edge["source"].toInt();
            int target = edge["target"].toInt();
            double weight = edge["weight"].toDouble();

            if( !theGraph->addEdge(source,target,weight) )
                qDebug() << "ERROR: could not add edge";

        }

    }
    else  {
        errors << "JSON docuement was not object";
        file.close();
        return false;

    }
    return true;
}



