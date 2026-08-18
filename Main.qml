import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

import SystemDataComp 1.0

ApplicationWindow {
    id: window
    width: 640
    height: 400
    minimumWidth: 640
    minimumHeight: 350
    visible: true
    title: qsTr("System Stats")

    SystemData{
        id: systemDataId
    }

Rectangle{
    id:root
    color: "#2e2e2e"
    anchors{
    fill: parent
    }

    property color textColor: "#ffffff"

    Column{
        anchors.centerIn:parent
        spacing: 5

        RowLayout{
            spacing: 10
            Text {
                text:"CPU Usage : "
                color: root.textColor
                font.pixelSize: 28
                Layout.alignment: Qt.AlignVCenter
            }

            ProgressBar{
            id:cpuProgressBar
            value: systemDataId.cpuUsage.toFixed(1);
            // value: 100
            from:0
            to:100
            Layout.alignment: Qt.AlignVCenter

            Behavior on value{
            NumberAnimation{duration: 300; easing.type:Easing.OutQuad}
            }

            background: Rectangle{
                implicitWidth: 200
                implicitHeight: 20
                color: "#2a2d32"
                radius: 8
                border.color: "#3a3f47"
                border.width: 1
            }
            contentItem: Item{
                implicitWidth: 200
                implicitHeight: 16

                Rectangle{
                width: cpuProgressBar.visualPosition * parent.width
                height: parent.height
                radius: 8
                color: cpuProgressBar.value > 80 ? "#e61518" : "#00d2ff"

                }
            }

            }
            Text {
                text:systemDataId.cpuUsage.toFixed(2) + " %"
                color: root.textColor
                font.pixelSize: 28
                Layout.alignment: Qt.AlignVCenter
            }
        }

        RowLayout{
            spacing: 10
            Text {
                text:"RAM Usage : "
                color: root.textColor
                font.pixelSize: 28
                Layout.alignment: Qt.AlignVCenter
            }

            ProgressBar{
            id:ramProgressBar
            value: systemDataId.ramUsage.toFixed(1);
            // value: 100
            from:0
            to:100
            Layout.alignment: Qt.AlignVCenter

            Behavior on value{
            NumberAnimation{duration: 300; easing.type:Easing.OutQuad}
            }

            background: Rectangle{
                implicitWidth: 200
                implicitHeight: 20
                color: "#2a2d32"
                radius: 8
                border.color: "#3a3f47"
                border.width: 1
            }
            contentItem: Item{
                implicitWidth: 200
                implicitHeight: 16

                Rectangle{
                width: ramProgressBar.visualPosition * parent.width
                height: parent.height
                radius: 8
                color: ramProgressBar.value > 80 ? "#e61518" : "#00d2ff"

                }
            }

            }
            Text {
                text:systemDataId.ramUsage.toFixed(2) + " %"
                color: root.textColor
                font.pixelSize: 28
                Layout.alignment: Qt.AlignVCenter
            }
        }



    }

}

}
