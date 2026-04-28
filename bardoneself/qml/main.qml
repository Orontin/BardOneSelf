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

        color: "red"

        Rectangle {
            id: img

            height: audio.height;
            width: audio.height;

            color: "yellow"
        }

        Rectangle {
            id: name

            anchors.left: img.right

            height: parent.height * 0.1;
            width: parent.width - parent.height;

            color: "blue"
        }
    }
}
