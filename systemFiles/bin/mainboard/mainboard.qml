import QtQuick 2.15
import QtQuick.Controls 2.15

function appClicked(appId) {
    console.log("clicked:  " + appId)
}

ApplicationWindow {
    id: mainWindow
    width: 480
    height: 800
    visible: true
    title: "MainBoard"

    Image {
        id: wallpaper
        anchors.fill: parent
        source: "activeWallpaper.png"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: topBar
        width: parent.width
        height: 30
        anchors.top: parent.top
        color: '#05d3e2ff'
        z: 9999

        Text {
            id: topBarClock
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 14
            font.bold: true
            text: Qt.formatTime(new Date(), "hh:mm")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: topBarClock.text = Qt.formatTime(new Date(), "hh:mm")
            }
        }

        Text {
            id: betaIndicator
            color: "red"
            font.pixelSize: 14
            font.bold: true
            text: "BETA"
            anchors.centerIn: parent
        }

        Row {
            id: topBarStatus
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Image {
                id: bluetoothIcon
                source: mainboardManager.bluetoothInactiveIcon
                height: 16
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: wifiIcon
                source: mainboardManager.wifi3Icon
                height: 14
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Item {
        id: gridContainer
        anchors.top: topBar.bottom
        anchors.bottom: searchButton.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        anchors.topMargin: 15

        readonly property real cellWidth: width / 4
        readonly property real cellHeight: height / 4

        Repeater {
            model: mainboardManager.gridItems

            delegate: Item {
                x: modelData.col * gridContainer.cellWidth
                y: modelData.row * gridContainer.cellHeight
                width: modelData.spanX * gridContainer.cellWidth
                height: modelData.spanY * gridContainer.cellHeight

                Item {
                    anchors.fill: parent
                    visible: modelData.type === "app"

                    Column {
                        anchors.centerIn: parent
                        spacing: 4

                        Image {
                            width: 95
                            height: 95
                            source: modelData.icon
                            fillMode: Image.PreserveAspectFit

                            MouseArea {
                                anchors.fill: parent
                                onClicked: appClicked(modelData.id)
                            }
                        }

                        Text {
                            text: modelData.name
                            color: "white"
                            font.pixelSize: 12
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                            elide: Text.ElideRight
                            width: gridContainer.cellWidth - 8
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 6
                    visible: modelData.type === "widget"
                    color: "#40d3e2ff"
                    radius: 23.75

                    Column {
                        anchors.centerIn: parent
                        visible: modelData.id === "clock_widget"

                        Text {
                            text: Qt.formatTime(new Date(), "hh:mm")
                            color: "white"
                            font.pixelSize: 36
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: modelData.name
                            color: "#dddddd"
                            font.pixelSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: searchButton
        width: 90
        height: 28
        anchors.bottom: dock.top
        anchors.bottomMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
        color: '#40d3e2ff'
        radius: 14

        Text {
            id: searchButtonText
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 14
            font.bold: true
            text: "Szukaj"
        }
    }

    Rectangle {
        id: dock
        width: parent.width - 20
        height: 125
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
        color: '#40d3e2ff'
        radius: 31.25
        z: 9985

        Row {
            id: dockRow
            anchors.centerIn: parent
            spacing: 15

            Repeater {
                model: mainboardManager.dockItems

                delegate: Image {
                    width: 95
                    height: 95
                    source: modelData.icon
                    fillMode: Image.PreserveAspectFit
                    

                    MouseArea {
                        anchors.fill: parent
                        onClicked: appClicked(modelData.id)
                    }
                }
            }
        }
    }
}