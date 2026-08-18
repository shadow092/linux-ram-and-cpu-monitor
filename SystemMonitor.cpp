#include "SystemMonitor.h"

#include <QFile>
#include <QDebug>
#include <QTextStream>
#include <QTimer>

SystemData::SystemData(QObject *parent): QObject(parent){
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout,this,&SystemData::updateStats);
    timer->start(1000);
}

double SystemData::reportCpuUsage() const{
    return cpuUsage;
}
double SystemData::reportRamUsage() const{
    return ramUsage;
}

double SystemData::getCpuUsage(){

    double usage = 0;
    QString totalData;
    QFile file(cpuPath);

    // qDebug()<<"CPU"<<file.fileName();
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open CPU file!";
        return -1;
    }

    QTextStream data(&file);
    QString fileContent = data.readLine();
    // qDebug() << "data" << fileContent;

    while(!data.atEnd()){
        // qDebug()<<"weeee";

        if(fileContent.startsWith("cpu ")){
            totalData=fileContent;
            break;
        }
        fileContent = data.readLine();

    }
    QStringList tokens = totalData.split(" ",Qt::SkipEmptyParts);

    // qDebug()<<"test"<<tokens;

    qulonglong idleTime    = tokens[4].toULongLong() + tokens[5].toULongLong();
    qulonglong totalTime   = idleTime + tokens[1].toULongLong() + tokens[2].toULongLong() + tokens[3].toULongLong() + tokens[6].toULongLong() + tokens[7].toULongLong();
    usage = (totalTime == prevTotalCpu) ? 0.0 : (double)((totalTime - prevTotalCpu) - (idleTime - prevIdleCpu)) / (totalTime - prevTotalCpu) * 100.0;

    prevTotalCpu = totalTime;
    prevIdleCpu  = idleTime;

    // qDebug()<<"usage "<<usage;
    cpuUsage = usage;
    emit cpuUsageChanged();
    return usage;
}

double SystemData::getRamUsage(){
    double usage = 0;
    QString totalData;
    QFile file(ramPath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open Ram file!";
        return -1;
    }

    QTextStream data(&file);
    QString fileContent = data.readLine();
    // qDebug() << "ram data" << fileContent;

    while(!data.atEnd()){
        // qDebug()<<"weeee";

        if(fileContent.startsWith("MemAvailable:")){
            totalData+=fileContent;
            break;
        }
        // qDebug() << "ram data" << fileContent;
        totalData+=fileContent;
        fileContent = data.readLine();

    }
    QStringList tokens = totalData.split(" ",Qt::SkipEmptyParts);

    // qDebug()<<"ram test tk"<<tokens;

    qulonglong memTotal     = tokens[1].toULongLong();
    qulonglong memAvailable = tokens[5].toULongLong();

    if (memTotal > 0) {
        usage = (double)(memTotal - memAvailable) / memTotal * 100.0;
    }
    // qDebug()<< usage;
    ramUsage=usage;
    emit ramUsageChanged();
    return usage;
}

void SystemData::updateStats(){
    double cpu =getCpuUsage();
    double ram =getRamUsage();

    // qDebug()<<"Cpu Usage:"<<cpu<<" Ram Usage: "<<ram;
}
