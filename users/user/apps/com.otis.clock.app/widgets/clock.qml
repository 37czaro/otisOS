import QtQuick 2.15

Rectangle {
    color: "#40d3e2ff"
    radius: 23.75

    Column {
        anchors.centerIn: parent

        Text {
            id: widgetClock
            text: Qt.formatTime(new Date(), "hh:mm")
            color: "white"
            font.pixelSize: 38
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: widgetClock.text = Qt.formatTime(new Date(), "hh:mm")
            }
        }

        Text {
            text: Qt.formatDate(new Date(), "dddd, d MMMM")
            color: "#dddddd"
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}