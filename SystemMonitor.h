#pragma once

#include <QObject>
#include <QTimer>

class SystemData: public QObject{
    Q_OBJECT
private:

    QString cpuPath = "/proc/stat";
    QString ramPath = "/proc/meminfo";
    double cpuUsage = 1;
    double ramUsage = 1;
    double prevTotalCpu = 0;
    double prevIdleCpu  = 0;
    double prevTotalRam = 0;
    double prevIdleRam  = 0;
    QTimer *timer;
public:
    Q_PROPERTY(double cpuUsage READ reportCpuUsage  NOTIFY cpuUsageChanged)
    Q_PROPERTY(double ramUsage READ reportRamUsage  NOTIFY ramUsageChanged)

    explicit SystemData(QObject *parent = nullptr);

    double reportCpuUsage() const;
    double reportRamUsage() const;
    double getCpuUsage();
    double getRamUsage();
    void updateStats();


signals:
    void cpuUsageChanged();
    void ramUsageChanged();
};