import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Column {
    anchors.centerIn: parent
    spacing: 5

    Loader {
        sourceComponent: (function() {
            switch (root.barStyle) {
                case "normal":
                    return normalStyle;
                case "thin":
                    return thinStyle;
                case "bars":
                    return barsStyle;
                default:
                    return normalStyle;
            }
        })()
    }



    // --- 1. Normal Style ---
    Component {
        id: normalStyle

        Column {
            spacing: 10

            RowLayout {
                spacing: 10
                Text {
                    text: "CPU Usage : "
                    color: root.textColor
                    font.pixelSize: 28
                    Layout.alignment: Qt.AlignVCenter
                }

                ProgressBar {
                    id: cpuProgressBar
                    value: systemDataId.cpuUsage.toFixed(1)
                    from: 0
                    to: 100
                    Layout.alignment: Qt.AlignVCenter

                    Behavior on value {
                        NumberAnimation { duration: 300; easing.type: Easing.OutQuad }
                    }

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 20
                        color: "#2a2d32"
                        radius: 8
                        border.color: "#3a3f47"
                        border.width: 1
                    }
                    contentItem: Item {
                        implicitWidth: 200
                        implicitHeight: 16

                        Rectangle {
                            width: cpuProgressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 8
                            color: cpuProgressBar.value > 80 ? "#e61518" : "#00d2ff"
                        }
                    }
                }

                Text {
                    text: systemDataId.cpuUsage.toFixed(2) + " %"
                    color: root.textColor
                    font.pixelSize: 28
                    Layout.alignment: Qt.AlignVCenter
                }
            }

            RowLayout {
                spacing: 10
                Text {
                    text: "RAM Usage : "
                    color: root.textColor
                    font.pixelSize: 28
                    Layout.alignment: Qt.AlignVCenter
                }

                ProgressBar {
                    id: ramProgressBar
                    value: systemDataId.ramUsage.toFixed(1)
                    from: 0
                    to: 100
                    Layout.alignment: Qt.AlignVCenter

                    Behavior on value {
                        NumberAnimation { duration: 300; easing.type: Easing.OutQuad }
                    }

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 20
                        color: "#2a2d32"
                        radius: 8
                        border.color: "#3a3f47"
                        border.width: 1
                    }
                    contentItem: Item {
                        implicitWidth: 200
                        implicitHeight: 16

                        Rectangle {
                            width: ramProgressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 8
                            color: ramProgressBar.value > 80 ? "#e61518" : "#00d2ff"
                        }
                    }
                }

                Text {
                    text: systemDataId.ramUsage.toFixed(2) + " %"
                    color: root.textColor
                    font.pixelSize: 28
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }

    // --- 2. Thin Style (Balanced: readable font size with a cleaner slim bar) ---
    Component {
        id: thinStyle

        Column {
            spacing: 12

            RowLayout {
                spacing: 12
                Text {
                    text: "CPU Usage : "
                    color: root.textColor
                    font.pixelSize: 22 // Kept large and readable
                    Layout.alignment: Qt.AlignVCenter
                }

                ProgressBar {
                    id: thinCpuBar
                    value: systemDataId.cpuUsage.toFixed(1)
                    from: 0
                    to: 100
                    Layout.alignment: Qt.AlignVCenter

                    background: Rectangle {
                        implicitWidth: 180
                        implicitHeight: 10 // Slightly thicker than before
                        color: "#2a2d32"
                        radius: 5
                    }
                    contentItem: Item {
                        implicitWidth: 180
                        implicitHeight: 10
                        Rectangle {
                            width: thinCpuBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: thinCpuBar.value > 80 ? "#e61518" : "#00d2ff"
                        }
                    }
                }

                Text {
                    text: systemDataId.cpuUsage.toFixed(1) + " %"
                    color: root.textColor
                    font.pixelSize: 22
                    Layout.alignment: Qt.AlignVCenter
                }
            }

            RowLayout {
                spacing: 12
                Text {
                    text: "RAM Usage : "
                    color: root.textColor
                    font.pixelSize: 22
                    Layout.alignment: Qt.AlignVCenter
                }

                ProgressBar {
                    id: thinRamBar
                    value: systemDataId.ramUsage.toFixed(1)
                    from: 0
                    to: 100
                    Layout.alignment: Qt.AlignVCenter

                    background: Rectangle {
                        implicitWidth: 180
                        implicitHeight: 10
                        color: "#2a2d32"
                        radius: 5
                    }
                    contentItem: Item {
                        implicitWidth: 180
                        implicitHeight: 10
                        Rectangle {
                            width: thinRamBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: thinRamBar.value > 80 ? "#e61518" : "#00d2ff"
                        }
                    }
                }

                Text {
                    text: systemDataId.ramUsage.toFixed(1) + " %"
                    color: root.textColor
                    font.pixelSize: 22
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }

    // --- 3. Bars Style (Segmented LED/Block style with spacing) ---
    Component {
        id: barsStyle

        Column {
            spacing: 10

            // CPU Segmented Bar
            Column {
                spacing: 4
                RowLayout {
                    Text { text: "CPU Usage"; color: root.textColor; font.pixelSize: 30 }
                    Item { Layout.fillWidth: true }
                    Text { text: systemDataId.cpuUsage.toFixed(1) + " %"; color: root.textColor; font.pixelSize: 30 }
                }

                Row {
                    spacing: 3 // Creates the distinct segmented spacing look
                    readonly property int totalBlocks: 15
                    readonly property real activeBlocks: Math.round((systemDataId.cpuUsage / 100) * totalBlocks)

                    Repeater {
                        model: parent.totalBlocks
                        Rectangle {
                            width: 30
                            height: 20
                            radius: 2
                            color: index < parent.activeBlocks ? (systemDataId.cpuUsage > 80 ? "#e61518" : "#fc7f03") : "#2a2d32"
                        }
                    }
                }
            }

            // RAM Segmented Bar
            Column {
                spacing: 4
                RowLayout {
                    Text { text: "RAM Usage"; color: root.textColor; font.pixelSize: 30 }
                    Item { Layout.fillWidth: true }
                    Text { text: systemDataId.ramUsage.toFixed(1) + " %"; color: root.textColor; font.pixelSize: 30 }
                }

                Row {
                    spacing: 3
                    readonly property int totalBlocks: 15
                    readonly property real activeBlocks: Math.round((systemDataId.ramUsage / 100) * totalBlocks)

                    Repeater {
                        model: parent.totalBlocks
                        Rectangle {
                            width: 30
                            height: 20
                            radius: 2
                            color: index < parent.activeBlocks ? (systemDataId.ramUsage > 80 ? "#e61518" : "#fc7f03") : "#2a2d32"
                        }
                    }
                }
            }
        }
    }
}