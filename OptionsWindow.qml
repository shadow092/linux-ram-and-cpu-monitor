import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

import SystemDataComp 1.0

Window {
id:optionWindow
flags: Qt.Window | Qt.FramelessWindowHint
width: 180
height : 420
minimumHeight: 400
minimumWidth: 180
visible: false
color: "transparent"

property string currentOption: "background"

Rectangle{

border.color: root.borderColor
anchors.fill: parent

CustomeTopBar{
id:topWindowBar
showMinimize: false
targetWindow: optionWindow
rounded: false
}

Rectangle{
anchors.top: topWindowBar.bottom
anchors.bottom: parent.bottom
width: parent.width
border.width:4
border.color: root.borderColor
color:root.backgroundColor


Loader {
        anchors.fill: parent
        anchors.margins: 10

        sourceComponent: {
            switch (optionWindow.currentOption) {
                case "background": return bgOptionsComponent;
                case "progressBar": return barOptionsComponent;
                default: return bgOptionsComponent;
            }
        }
    }

    Component {
        id: bgOptionsComponent
        Column {
            spacing: 10
            width: parent.width
            Text { text: "Background Options"; color: root.textColor; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter; }


            Grid{
                width: parent.width
                columns: 2
                spacing: 8
            Repeater {
                id:myRepeter
                    model: ["#2e2e2e", "#248992", "#1FB7C4", "#1AE4F6", "#662779","#9E1FC4","#5C82DD"]
                    property var borderColors: ["#3d3d3d", "#165056", "#126d75", "#0e8793", "#3a1445", "#5e1176", "#344c8c"]

                    delegate: Button {
                        required property string modelData
                        required property int index

                        width: parent.width/2.2
                        height: 40

                        background: Rectangle {
                            color: modelData
                            border.color: "#66ffffff"
                            border.width: 2
                            radius: 5
                        }

                        ToolTip.visible: hovered
                        ToolTip.text: "Color: " + modelData

                        onClicked: {root.backgroundColor = modelData
                        root.borderColor = myRepeter.borderColors[index]
                        }
                    }
                }}

        }
    }

    Component {
        id: barOptionsComponent
        Column {
            spacing: 10
            width: parent.width
            Text { text: "Bar Options"; color: root.textColor; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter; }
            Button { text: "normal"
            onClicked: root.barStyle = "normal"
            }
            Button { text: "bars"
            onClicked: root.barStyle = "bars"
            }
            Button { text: "thin"
            onClicked: root.barStyle = "thin"
            }
                Text{
                text: "text color"
                color: root.textColor
                font.bold: true; anchors.horizontalCenter: parent.horizontalCenter;
                }

                Button{ text: "White"; onClicked: root.textColor = "white"}
                Button{ text: "Black"; onClicked: root.textColor = "black"}

        }
    }

}

}

}