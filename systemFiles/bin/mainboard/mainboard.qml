import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    width: 480
    height: 800
    visible: true
    title: "MainBoard"

    function appClicked(appId) {
        console.log("clicked: " + appId)
    }

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
        color: "transparent"
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
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        readonly property real iconSize: 95
        readonly property real colSpacing: (width - (4 * iconSize)) / 5

        Repeater {
            model: mainboardManager.gridItems

            delegate: Item {
                x: gridContainer.colSpacing + modelData.col * (gridContainer.iconSize + gridContainer.colSpacing)
                y: modelData.row * (gridContainer.iconSize + 25) + 10
                width: modelData.spanX * gridContainer.iconSize + (modelData.spanX - 1) * gridContainer.colSpacing
                height: modelData.spanY * gridContainer.iconSize + (modelData.spanY - 1) * 25

                Item {
                    anchors.fill: parent
                    visible: modelData.type === "app"

                    Column {
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
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
                            width: 95
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }

                Item {
                    anchors.fill: parent
                    visible: modelData.type === "widget"

                    Column {
                        anchors.fill: parent
                        spacing: 4

                        Loader {
                            width: parent.width
                            height: parent.height - 18
                            source: modelData.widgetSource
                        }

                        Text {
                            text: modelData.appName
                            color: "white"
                            font.pixelSize: 12
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                            elide: Text.ElideRight
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
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
            spacing: (gridContainer.width - (4 * gridContainer.iconSize)) / 5

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