import QtQuick
import QtQuick.Controls

Rectangle{
id:windowTopBar
required property var targetWindow
property bool showMinimize: true
property bool rounded: true

radius: rounded ? 10 : 0
height: 40
color: (parent && parent.border && parent.border.color) ? parent.border.color : "#3d3d3d"
anchors{
top:parent.top
right:parent.right
left: parent.left
}

MouseArea{
anchors.fill: parent
onPressed: { windowTopBar.targetWindow.startSystemMove()}
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
    targetWindow.close()}
}

Button{
id:minimizeBtn
visible: windowTopBar.showMinimize
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
    targetWindow.showMinimized()}
}

}

