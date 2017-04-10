/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  mainwindow.cpp
*
*  Created: 4 2017 by rodney
*
*  Copyright 2017 rodney.  All Rights Reserved.
*
* This file may be distributed under the terms of GNU Public License version
* 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
* license should have been included with this file, or the project in which
* this file belongs to. You may also find the details of GPL v3 at:
*
* http://www.gnu.org/licenses/gpl-3.0.txt
*
* If you have any questions regarding the use of this file, feel free to
* contact the author of this file, or the owner of the project in which
* this file belongs to.
*
******************************************************************************/

#include <QMenu>
#include <QDebug>
#include <QChart>
#include <QChartView>
#include <QStringList>
#include <QFileDialog>

#include "parsegraphjson.h"
#include "plotops.h"
#include "vectorops.h"
#include "graphanalysisdegree.h"

#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    makeActions();
    makeMenus();
    makeUI();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::makeActions(){
    actionOpenDataFolder = new QAction( tr("&Open Data Folder"));
    actionOpenDataFolder->setShortcut(tr("CTRL+O"));
    connect( actionOpenDataFolder, SIGNAL(triggered(bool)),this, SLOT(slotSetFolder()));

    actionQuit = new QAction(tr("&Quit"));
    actionQuit->setShortcut(tr("CTRL+Q"));
    connect( actionQuit, SIGNAL(triggered(bool)),qApp,SLOT(closeAllWindows()));

}

void MainWindow::makeMenus() {
    QMenu *fileMenu = menuBar()->addMenu(tr("&File"));
    fileMenu->addAction( actionOpenDataFolder );
    fileMenu->addSeparator();
    fileMenu->addAction( actionQuit );

}

void MainWindow::makeUI() {

}





void MainWindow::slotSetFolder(){
    QString path = QFileDialog::getExistingDirectory(this,
                                                    "Locate data directory",
                                                    QDir::homePath());
    if( path.isEmpty())
        return;



    dataSet = new DataSet(this);
    if( dataSet->loadGraphsFromFolder(path) ) {
        // put in the stuff to load it into the UI here
        qDebug() << "This has " << dataSet->count() << " graphs in it!";
    }
    else {
        qDebug() << "Deleting dataSet";
        delete dataSet;
    }

/*
 *
 *
 *

    QStringList filters;
    filters << "*.json";


    dataDir = new QDir(path);
    dataDir->setNameFilters(filters);
    dataDir->setFilter( QDir::Files );
    dataDir->makeAbsolute();

    qDebug() << "Directory has " << dataDir->count() << " items.";
    if( !dataDir->count() ) {
        qDebug() << "No json files in that folder";
        return;
    }


    QString dataFile = dataDir->absoluteFilePath( dataDir->entryList().at(0) );

    graphDataSet = new GraphDataSet( this );
    if( graphDataSet->loadGraph( dataDir->entryList().at(0), PARSE_TYPE_GRAPH_JSON)){

    } else {
        delete graphDataSet;
    }





    ParseGraphJSON *parser = new ParseGraphJSON( dataFile, this);
    qDebug() << "a parser was made";

    if( !parser->parse()){
        qDebug() << "Cannot parse " << dataFile;
        //qDebug() << parser->getFeedback();
   }
    else {
        Graph *theGraph = parser->getGraph();
        qDebug() << "theGraph";
        GraphAnalysisDegree *analysis = new GraphAnalysisDegree(theGraph);
        qDebug() << "analysis";
        if( analysis->run() ) {
            qDebug() << "analysis->run()";
            gsl_vector * degree = analysis->getDegreeDistribution();
            QStringList labels = theGraph->nodeLabels();

            QChart *chart = makeBarChart(degree, labels, QString("Graph Degree Distribution"));
            QChartView *chartView = new QChartView(chart);
            chartView->setRenderHint(QPainter::Antialiasing);
            setCentralWidget( chartView );
        }
        free(theGraph);
        free(analysis);


        qDebug() << "Parser finished";
    }

    delete parser;

*/

}






