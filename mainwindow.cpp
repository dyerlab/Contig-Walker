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
#include <QSettings>
#include <QChartView>
#include <QStringList>
#include <QFileDialog>

#include "parsegraphjson.h"
#include "plotops.h"
#include "vectorops.h"

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


void MainWindow::closeEvent(QCloseEvent *event) {
    saveSettings();
    event->accept();
}

void MainWindow::loadSettings() {
    QSettings settings("Dyerlab","ChromosomeWalking");
    move( settings.value("pos", QVariant(QPoint(100,100))).toPoint());
    resize( settings.value( "size", QVariant(QSize(500,500))).toSize());

    QString dir = settings.value("dataDir", QVariant(QDir::homePath())).toString();
    qDebug() << "Loading dir as:" << dir;
    this->dataDir = new QDir( dir );

    mainSplitter->restoreState( settings.value("splitter", QVariant(QByteArray())).toByteArray());
}

void MainWindow::saveSettings() {
    QSettings settings("Dyerlab", "ChromosomeWalking");
    settings.setValue("pos",QVariant(pos()));
    settings.setValue("size",QVariant(size()));
    if( dataDir ) {
        settings.setValue("dataDir", dataDir->absolutePath());
        qDebug() << "Saving dataDir as: " << dataDir->absolutePath();
    } else {
        qDebug() << "DataDir not set";
    }
    settings.setValue("splitter",QVariant(mainSplitter->saveState()));
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
    mainSplitter = new QSplitter(this);
    tableView = new QTableView(mainSplitter);
    tableView->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    graphScene = new GraphScene(this);
    graphView  = new GraphView(graphScene);
    graphView->setScene(graphScene);
    mainSplitter->setOrientation(Qt::Horizontal);
    mainSplitter->addWidget(tableView);
    mainSplitter->addWidget(graphView);

    connect( tableView,
             SIGNAL(clicked(QModelIndex)),
             this,
             SLOT(slotGraphClicked(QModelIndex)));


    setCentralWidget(mainSplitter);
    loadSettings();

}




/******************************************     SLOTS ********/

void MainWindow::slotSetFolder(){
    QString defaultPath = QDir::homePath();

    if( dataDir )
        defaultPath = dataDir->absolutePath();

    QString path = QFileDialog::getExistingDirectory(this,
                                                    "Locate data directory",
                                                    defaultPath);
    if( path.isEmpty())
        return;



    dataSet = new DataSet(this);
    if( dataSet->loadGraphsFromFolder(path) ) {

        qDebug() << "This has " << dataSet->count() << " graphs in it!";
        tableModel = new GraphDataTableModel( dataSet, this );
        tableView->setModel(tableModel);
        tableView->update();
        dataDir = new QDir(path);

    }
    else {
        qDebug() << "Deleting dataSet";
        delete dataSet;
    }
}

void MainWindow::slotGraphClicked(const QModelIndex &index) {
    int row = index.row();

    qDebug() << "graphSelectionChanged()";

    GraphScene *scene = new GraphScene(this);
    scene->setGraph( dataSet->graph(row));
    delete graphScene;
    graphScene = scene;
    graphView->setScene(graphScene);
    graphView->itemMoved();

}






