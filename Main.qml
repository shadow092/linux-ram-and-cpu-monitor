import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Qt.labs.settings

import SystemDataComp 1.0

ApplicationWindow {
    id: window
    width: 700
    height: 440
    minimumWidth: 700
    minimumHeight: 400
    visible: true
    title: qsTr("System Stats")
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"



    SystemData{
        id: systemDataId
    }

    OptionsWindow{
        id: optionWindow
        transientParent: window
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
    color: backgroundColor
    radius: 20
    border.width: 8
    border.color: borderColor
    anchors{
    fill: parent
    margins: 2
    }

    property color textColor: "#ffffff"
    property color backgroundColor: "#2e2e2e"
    property color borderColor: "#3d3d3d"
    property string barStyle: "normal"


    Settings{
        id: appSettings
        property alias backgroundColor: root.backgroundColor
        property alias borderColor: root.borderColor
        property alias barStyle: root.barStyle
        property alias textColor: root.textColor

    }

CustomeTopBar{
id:windowTopBar
showMinimize: true
targetWindow: window
}

CustomeProgressBar{}


    Rectangle{
    id:styleOptions
    width: 80
    anchors{
    right: parent.right
    bottom: parent.bottom
    top:windowTopBar.bottom
    rightMargin: 5
    bottomMargin: 6}
    color: "#401c1c1c"
    border.color: "#66ffffff"
    border.width: 4
    radius: 10

    Item {
        anchors.fill: parent

    Column{
        anchors.centerIn: parent
        spacing: 10
        width: parent.width

    Button{
    id:backgroundStyleBtn
    width: parent.width/1.4
    text: "BG"
    anchors.horizontalCenter: parent.horizontalCenter

    ToolTip.visible: hovered
    ToolTip.text: "Background Style"

    background: Rectangle {
            color: "#401c1c1c"
            border.color: "#66ffffff"
            border.width: 2
            radius: 5
        }

    onClicked: {
            optionWindow.currentOption = "background"
            optionWindow.x = window.x + window.width + 5
            optionWindow.y = window.y
            optionWindow.show()
            optionWindow.raise()
        }

    }

    Button {
        id: progressStyleBtn
        text: "Bar"
        width: parent.width/1.4
        anchors.horizontalCenter: parent.horizontalCenter

        background: Rectangle {
            color: "#401c1c1c"
            border.color: "#66ffffff"
            border.width: 2
            radius: 5
        }

        ToolTip.visible: hovered
        ToolTip.text: "Progress Bar Style"

        onClicked: {
                optionWindow.currentOption = "progressBar"
                optionWindow.setX(window.x + window.width + 5)
                optionWindow.setY(window.y)
                optionWindow.show()
                optionWindow.raise()
            }
    }

    }
}
    }



}


}





