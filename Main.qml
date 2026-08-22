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
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    SystemData{
        id: systemDataId
    }


    MouseArea {
            id: resizeMouseArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton

            property int edgeOffset: 5
            property int calculatedEdges: 0

            function updateEdges(x, y) {
                calculatedEdges = 0;
                if (x < edgeOffset) calculatedEdges |= Qt.LeftEdge;
                if (x > (width - edgeOffset)) calculatedEdges |= Qt.RightEdge;
                if (y < edgeOffset) calculatedEdges |= Qt.TopEdge;
                if (y > (height - edgeOffset)) calculatedEdges |= Qt.BottomEdge;
            }

            cursorShape: {
                if (!containsMouse) return Qt.ArrowCursor;
                switch (calculatedEdges) {
                    case Qt.LeftEdge:
                    case Qt.RightEdge: return Qt.SizeHorCursor;
                    case Qt.TopEdge:
                    case Qt.BottomEdge: return Qt.SizeVerCursor;
                    case Qt.TopEdge | Qt.LeftEdge:
                    case Qt.BottomEdge | Qt.RightEdge: return Qt.SizeFDiagCursor;
                    case Qt.TopEdge | Qt.RightEdge:
                    case Qt.BottomEdge | Qt.LeftEdge: return Qt.SizeBDiagCursor;
                    default: return Qt.ArrowCursor;
                }
            }

            onPositionChanged: {
                if (!pressed) {
                    updateEdges(mouseX, mouseY);
                }
            }

            onPressed: (mouse) => {
                updateEdges(mouseX, mouseY);
                if (calculatedEdges !== 0) {
                    window.startSystemResize(calculatedEdges);
                }
            }
        }

Rectangle{
    id:root
    color: "#2e2e2e"
    radius: 20
    border.width: 8
    border.color: "#3d3d3d"
    anchors{
    fill: parent
    margins: 2
    }

    Rectangle{
    radius: 10
    height: 40
    color: parent.border.color
    anchors{
    top:parent.top
    right:parent.right
    left: parent.left
    }

    MouseArea{
        anchors.fill: parent
    onPressed: { window.startSystemMove()}
    }

    Button{
    id:closeBtn
    text: "X"
    width:40
    height: 30
    anchors{
    right: parent.right
    rightMargin: 5
    verticalCenter: parent.verticalCenter
    }

    background:Rectangle {
    radius: 10
    Behavior on color { ColorAnimation { duration: 150 }    }

    color : closeBtn.down ? "#555555" : (closeBtn.hovered ? "#ff2424" : "#333333")
    }

    contentItem: Text{
        text: closeBtn.text
        font.pixelSize: 20
        Behavior on color { ColorAnimation { duration: 150 }    }
        color: closeBtn.hovered ? "white" : "#ff2424"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    onClicked: {
        console.log("button")
        window.close()}
    }

    Button{
    id:minimizeBtn
    text: "-"
    width:40
    height: 30
    anchors{
    right: closeBtn.left
    rightMargin: 5
    verticalCenter: parent.verticalCenter
    }



    background:Rectangle {

    Behavior on color { ColorAnimation { duration: 150 }                }
    radius: 10
    color : minimizeBtn.down ? "#555555" : (minimizeBtn.hovered ? "#bdfdff" : "#333333")
    }

    contentItem: Text{
        text: minimizeBtn.text
        font.pixelSize: 35
        Behavior on color { ColorAnimation { duration: 150 }    }
        color: minimizeBtn.hovered ? "black" : "#bdfdff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    onClicked: {
        window.showMinimized()}
    }

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
