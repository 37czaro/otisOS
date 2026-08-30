import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow{
    id: mainWindow
    width: 480
    height: 800
    visible: true
    title: "MainBoard"

    Image{
        id: wallpaper
        anchors.fill: parent
        source: "activeWallpaper.png"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle{
        id: topBar
        width: parent.width
        height: 30
        anchors.top: parent.top
        color: '#05d3e2ff'
        z: 9999

        Text{
            id: topBarClock
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 14
            font.bold: true
            text: Qt.formatTime(new Date(), "hh:mm")

            Timer{
                interval: 1000
                running: true
                repeat: true
                onTriggered: topBarClock.text = Qt.formatTime(new Date(), "hh:mm")
            }
        }

        Text{
            id: betaIndicator
            color: "red"
            font.pixelSize: 14
            font.bold: true
            text: "BETA"
            anchors.centerIn: parent
        }

        Row{
            id: topBarStatus
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8


            Image{
                id: bluetoothIcon
                source: mainboardManager.bluetoothInactiveIcon
                height: 16
                fillMode: Image.PreserveAspectFit
            }

            Image{
                id: wifiIcon
                source: mainboardManager.wifi3Icon
                height: 14
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Rectangle{
        id: dock
        width: parent.width - 20
        height: 125
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
        color: '#40d3e2ff'
        radius: 31.25
        z: 9985

        Row{
            id: dockRow
            anchors.centerIn: parent
            spacing: 15

            Rectangle{
                id: app1
                width: 95
                height: 95
                color: '#00ff2f'
                radius: 23.75
            }

            Rectangle{
                id: app2
                width: 95
                height: 95
                color: '#fbff00'
                radius: 23.75
            }

            Rectangle{
                id: app3
                width: 95
                height: 95
                color: '#00d9ff'
                radius: 23.75
            }

            Rectangle{
                id: app4
                width: 95
                height: 95
                color: '#ff0000'
                radius: 23.75
            }
        }
    }

    Rectangle{
        id: searchButton
        width: 90
        height: 28
        anchors.bottom: dock.top
        anchors.bottomMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
        color: '#40d3e2ff'
        radius: 14

        Text{
            id: searchButtonText
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 14
            font.bold: true
            text: "Szukaj"
        }
    }
}