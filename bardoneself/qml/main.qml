import QtQuick
import QtQuick.Window

Window {
    width: 800
    height: 600

    visible: true

    title: "Разделитель с ограничениями"

    Rectangle {
        id: audio

        anchors.fill: parent

        color: "black"

        Rectangle {
            id: img

            width: audio.width * (7 / 35)
            height: audio.width * (7 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 35)
            anchors.leftMargin: audio.width * (1 / 35)

            Image {
                id: _img

                anchors.fill: parent
            }

            color: "white"
        }

        Rectangle {
            id: text

            width: audio.width * (21 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 35)
            anchors.leftMargin: audio.width * (9 / 35)

            color: "white"
        }

        Rectangle {
            id: settings

            width: audio.width * (1 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 35)
            anchors.leftMargin: audio.width * (31 / 35)

            color: "white"
        }

        Rectangle {
            id: offsetStart

            width: audio.width * (2 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 35)
            anchors.leftMargin: audio.width * (9 / 35)

            color: "white"
        }

        Rectangle {
            id: offset

            width: audio.width * (10 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 35)
            anchors.leftMargin: audio.width * (12 / 35)

            color: "white"
        }

        Rectangle {
            id: offsetEnd

            width: audio.width * (2 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 35)
            anchors.leftMargin: audio.width * (23 / 35)

            color: "white"
        }

        Rectangle {
            id: timelineStart

            width: audio.width * (2 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 35)
            anchors.leftMargin: audio.width * (9 / 35)

            color: "white"
        }

        Rectangle {
            id: timeline

            width: audio.width * (10 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 35)
            anchors.leftMargin: audio.width * (12 / 35)

            color: "white"
        }

        Rectangle {
            id: timelineEnd

            width: audio.width * (2 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 35)
            anchors.leftMargin: audio.width * (23 / 35)

            color: "white"
        }

        Rectangle {
            id: levelVolumeCurrent

            width: audio.width * (2 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (7 / 35)
            anchors.leftMargin: audio.width * (9 / 35)

            color: "white"
        }

        Rectangle {
            id: levelVolumeLine

            width: audio.width * (13 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (7 / 35)
            anchors.leftMargin: audio.width * (12 / 35)

            color: "white"
        }

        Rectangle {
            id: repeatType

            width: audio.width * (2 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 35)
            anchors.leftMargin: audio.width * (26 / 35)

            color: "white"
        }

        Rectangle {
            id: repeatCount

            width: audio.width * (3 / 35)
            height: audio.width * (1 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 35)
            anchors.leftMargin: audio.width * (29 / 35)

            color: "white"
        }

        Rectangle {
            id: runAndStopAudio

            width: audio.width * (6 / 35)
            height: audio.width * (3 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 35)
            anchors.leftMargin: audio.width * (26 / 35)

            color: "white"
        }

        Rectangle {
            id: spoiler

            width: audio.width * (1 / 35)
            height: audio.width * (7 / 35)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 35)
            anchors.leftMargin: audio.width * (33 / 35)

            color: "white"
        }
    }
}
