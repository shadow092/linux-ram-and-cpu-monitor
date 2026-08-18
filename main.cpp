#include "SystemMonitor.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // SystemData test("/proc/stat", "/proc/meminfo");
    qmlRegisterType<SystemData> ("SystemDataComp",1,0,"SystemData");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("test", "Main");

    return QGuiApplication::exec();
}
