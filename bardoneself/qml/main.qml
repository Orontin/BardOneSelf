import QtQuick
import QtQuick.Window
import QtQuick.Effects
import QtQuick.Controls
import Qt.labs.platform

Window {
    width: 800
    height: 600

    visible: true

    title: "Сам себе Бард"

    Rectangle {
        id: audio

        property bool status: true;

        anchors.fill: parent

        color: "black"

        Rectangle {
            id: img

            width: audio.width * (7 / 37)
            height: audio.width * (7 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 37)
            anchors.leftMargin: audio.width * (1 / 37)

            Image {
                id: _img
                anchors.fill: img
                fillMode: Image.PreserveAspectFit
                source: ""

                MouseArea {
                    anchors.fill: _img
                    cursorShape: Qt.PointingHandCursor
                    onClicked: fileDialog.open()
                }

                FileDialog {
                    id: fileDialog
                    title: "Выберите изображение"
                    onAccepted: {
                        _img.source = fileDialog.file.toString()
                    }
                }
            }

            color: "white"
        }

        Rectangle {
            id: text

            visible: audio.status

            width: audio.width * (23 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 37)
            anchors.leftMargin: audio.width * (9 / 37)

            TextEdit {
                id: _text

                anchors.fill: text

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.NoWrap

                font.family: "Monospace"

                function adjustFontSize() {
                    var maxWidth = width - (anchors.margins * 2)
                    var maxHeight = height - (anchors.margins * 2)

                    if (maxWidth <= 0 || maxHeight <= 0) {
                        return
                    }

                    var low = 1
                    var high = maxHeight
                    var best = low

                    while (low <= high) {
                        var mid = Math.floor((low + high) / 2)
                        font.pixelSize = mid

                        if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                            best = mid
                            low = mid + 1
                        } else {
                            high = mid - 1
                        }
                    }

                    font.pixelSize = best
                }

                onTextChanged: adjustFontSize()
                onWidthChanged: adjustFontSize()
                onHeightChanged: adjustFontSize()
                Component.onCompleted: adjustFontSize()
            }

            color: "white"
        }

        Rectangle {
            id: settings

            visible: audio.status

            width: audio.width * (1 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 37)
            anchors.leftMargin: audio.width * (33 / 37)

            color: "white"
        }

        Rectangle {
            id: offsetStart

            visible: audio.status

            width: audio.width * (4 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 37)
            anchors.leftMargin: audio.width * (9 / 37)

            color: "white"

            Text {
                id: _offsetStart

                anchors.fill: offsetStart

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.NoWrap

                font.family: "Monospace"

                text: "000:00:000"

                function adjustFontSize() {
                    var maxWidth = width - (anchors.margins * 2)
                    var maxHeight = height - (anchors.margins * 2)

                    if (maxWidth <= 0 || maxHeight <= 0) {
                        return
                    }

                    var low = 1
                    var high = maxHeight
                    var best = low

                    while (low <= high) {
                        var mid = Math.floor((low + high) / 2)
                        font.pixelSize = mid

                        if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                            best = mid
                            low = mid + 1
                        } else {
                            high = mid - 1
                        }
                    }

                    font.pixelSize = best
                }

                onTextChanged: adjustFontSize()
                onWidthChanged: adjustFontSize()
                onHeightChanged: adjustFontSize()
                Component.onCompleted: adjustFontSize()
            }
        }

        Rectangle {
            id: offset

            visible: audio.status

            width: audio.width * (8 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 37)
            anchors.leftMargin: audio.width * (14 / 37)

            color: "white"

            RangeSlider {
                id: _offset

                anchors.fill: offset

                anchors.leftMargin: _offset.height
                anchors.rightMargin: _offset.height

                from: 0
                to: 100
                first.value: 0
                second.value: 100

                background: Rectangle {
                    implicitWidth: _offset.width
                    implicitHeight: _offset.height
                    color: "green"
                }

                first.handle: Rectangle {
                    x: _offset.first.visualPosition * _offset.width
                    width: _offset.height
                    height: _offset.height
                    color: "blue"
                }

                second.handle: Rectangle {
                    x: _offset.second.visualPosition * _offset.width
                    width: _offset.height
                    height: _offset.height
                    color: "red"
                }
            }
        }

        Rectangle {
            id: offsetEnd

            visible: audio.status

            width: audio.width * (4 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 37)
            anchors.leftMargin: audio.width * (23 / 37)

            color: "white"

            Text {
                id: _offsetEnd

                anchors.fill: offsetEnd

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.NoWrap

                font.family: "Monospace"

                text: "000:00:000"

                function adjustFontSize() {
                    var maxWidth = width - (anchors.margins * 2)
                    var maxHeight = height - (anchors.margins * 2)

                    if (maxWidth <= 0 || maxHeight <= 0) {
                        return
                    }

                    var low = 1
                    var high = maxHeight
                    var best = low

                    while (low <= high) {
                        var mid = Math.floor((low + high) / 2)
                        font.pixelSize = mid

                        if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                            best = mid
                            low = mid + 1
                        } else {
                            high = mid - 1
                        }
                    }

                    font.pixelSize = best
                }

                onTextChanged: adjustFontSize()
                onWidthChanged: adjustFontSize()
                onHeightChanged: adjustFontSize()
                Component.onCompleted: adjustFontSize()
            }
        }

        Rectangle {
            id: timelineStart

            visible: audio.status

            width: audio.width * (4 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 37)
            anchors.leftMargin: audio.width * (9 / 37)

            color: "white"

            Text {
                id: _timelineStart

                anchors.fill: timelineStart

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.NoWrap

                font.family: "Monospace"

                text: "000:00:000"

                function adjustFontSize() {
                    var maxWidth = width - (anchors.margins * 2)
                    var maxHeight = height - (anchors.margins * 2)

                    if (maxWidth <= 0 || maxHeight <= 0) {
                        return
                    }

                    var low = 1
                    var high = maxHeight
                    var best = low

                    while (low <= high) {
                        var mid = Math.floor((low + high) / 2)
                        font.pixelSize = mid

                        if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                            best = mid
                            low = mid + 1
                        } else {
                            high = mid - 1
                        }
                    }

                    font.pixelSize = best
                }

                onTextChanged: adjustFontSize()
                onWidthChanged: adjustFontSize()
                onHeightChanged: adjustFontSize()
                Component.onCompleted: adjustFontSize()
            }
        }

        Rectangle {
            id: timeline

            visible: audio.status

            width: audio.width * (8 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 37)
            anchors.leftMargin: audio.width * (14 / 37)

            color: "white"
        }

        Rectangle {
            id: timelineEnd

            visible: audio.status

            width: audio.width * (4 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 37)
            anchors.leftMargin: audio.width * (23 / 37)

            color: "white"

            Text {
                id: _timelineEnd

                anchors.fill: timelineEnd

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.NoWrap

                font.family: "Monospace"

                text: "000:00:000"

                function adjustFontSize() {
                    var maxWidth = width - (anchors.margins * 2)
                    var maxHeight = height - (anchors.margins * 2)

                    if (maxWidth <= 0 || maxHeight <= 0) {
                        return
                    }

                    var low = 1
                    var high = maxHeight
                    var best = low

                    while (low <= high) {
                        var mid = Math.floor((low + high) / 2)
                        font.pixelSize = mid

                        if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                            best = mid
                            low = mid + 1
                        } else {
                            high = mid - 1
                        }
                    }

                    font.pixelSize = best
                }

                onTextChanged: adjustFontSize()
                onWidthChanged: adjustFontSize()
                onHeightChanged: adjustFontSize()
                Component.onCompleted: adjustFontSize()
            }
        }

        Rectangle {
            id: levelVolumeCurrent

            visible: audio.status

            width: audio.width * (2 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (7 / 37)
            anchors.leftMargin: audio.width * (9 / 37)

            color: "white"

            Text {
                id: _levelVolumeLine

                anchors.fill: levelVolumeCurrent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.NoWrap

                font.family: "Monospace"

                text: "100%"

                function adjustFontSize() {
                    var maxWidth = width - (anchors.margins * 2)
                    var maxHeight = height - (anchors.margins * 2)

                    if (maxWidth <= 0 || maxHeight <= 0) {
                        return
                    }

                    var low = 1
                    var high = maxHeight
                    var best = low

                    while (low <= high) {
                        var mid = Math.floor((low + high) / 2)
                        font.pixelSize = mid

                        if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                            best = mid
                            low = mid + 1
                        } else {
                            high = mid - 1
                        }
                    }

                    font.pixelSize = best
                }

                onTextChanged: adjustFontSize()
                onWidthChanged: adjustFontSize()
                onHeightChanged: adjustFontSize()
                Component.onCompleted: adjustFontSize()
            }
        }

        Rectangle {
            id: levelVolumeLine

            visible: audio.status

            width: audio.width * (15 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (7 / 37)
            anchors.leftMargin: audio.width * (12 / 37)

            color: "white"
        }

        Rectangle {
            id: repeatType

            visible: audio.status

            width: audio.width * (2 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 37)
            anchors.leftMargin: audio.width * (28 / 37)

            color: "white"

            Switch {
                id: repeatOneOrMany
                anchors.fill: repeatType

                background: Rectangle {
                    id: repeatOneOrManyBackground

                    implicitWidth: repeatType.width
                    implicitHeight: repeatType.height
                    color: "white"
                    border.width: 0

                    Row {
                        id: repeatOneOrManyBackgroundRow

                        Text {
                            id: repeatOneOrManyBackgroundRowTextOne

                            width: repeatType.width / 2
                            height: repeatType.height

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            wrapMode: Text.NoWrap

                            font.family: "Monospace"

                            text: "1"

                            function adjustFontSize() {
                                var maxWidth = width - (anchors.margins * 2)
                                var maxHeight = height - (anchors.margins * 2)

                                if (maxWidth <= 0 || maxHeight <= 0) {
                                    return
                                }

                                var low = 1
                                var high = maxHeight
                                var best = low

                                while (low <= high) {
                                    var mid = Math.floor((low + high) / 2)
                                    font.pixelSize = mid

                                    if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                                        best = mid
                                        low = mid + 1
                                    } else {
                                        high = mid - 1
                                    }
                                }

                                font.pixelSize = best
                            }

                            onTextChanged: adjustFontSize()
                            onWidthChanged: adjustFontSize()
                            onHeightChanged: adjustFontSize()
                            Component.onCompleted: adjustFontSize()
                        }

                        Text {
                            id: repeatOneOrManyBackgroundRowTextMany

                            width: repeatType.width / 2
                            height: repeatType.height

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            wrapMode: Text.NoWrap

                            font.family: "Monospace"

                            text: "N"

                            function adjustFontSize() {
                                var maxWidth = width - (anchors.margins * 2)
                                var maxHeight = height - (anchors.margins * 2)

                                if (maxWidth <= 0 || maxHeight <= 0) {
                                    return
                                }

                                var low = 1
                                var high = maxHeight
                                var best = low

                                while (low <= high) {
                                    var mid = Math.floor((low + high) / 2)
                                    font.pixelSize = mid

                                    if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                                        best = mid
                                        low = mid + 1
                                    } else {
                                        high = mid - 1
                                    }
                                }

                                font.pixelSize = best
                            }

                            onTextChanged: adjustFontSize()
                            onWidthChanged: adjustFontSize()
                            onHeightChanged: adjustFontSize()
                            Component.onCompleted: adjustFontSize()
                        }
                    }
                }

                indicator: Rectangle {
                    id: repeatOneOrManyIndicator

                    x: repeatOneOrMany.checked ? (repeatOneOrMany.width - width) : 0
                    y: (repeatOneOrMany.height - height) / 2

                    width: repeatOneOrMany.height
                    height: repeatOneOrMany.height

                    color: "red"

                    Text {
                        anchors.fill: repeatOneOrManyIndicator

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        wrapMode: Text.NoWrap

                        font.family: "Monospace"

                        color: "white"

                        text: repeatOneOrMany.checked ? "N" : "1"

                        function adjustFontSize() {
                            var maxWidth = width - (anchors.margins * 2)
                            var maxHeight = height - (anchors.margins * 2)

                            if (maxWidth <= 0 || maxHeight <= 0) {
                                return
                            }

                            var low = 1
                            var high = maxHeight
                            var best = low

                            while (low <= high) {
                                var mid = Math.floor((low + high) / 2)
                                font.pixelSize = mid

                                if (contentWidth <= maxWidth && contentHeight <= maxHeight) {
                                    best = mid
                                    low = mid + 1
                                } else {
                                    high = mid - 1
                                }
                            }

                            font.pixelSize = best
                        }

                        onTextChanged: adjustFontSize()
                        onWidthChanged: adjustFontSize()
                        onHeightChanged: adjustFontSize()
                        Component.onCompleted: adjustFontSize()
                    }
                }
            }
        }

        Rectangle {
            id: repeatCount

            visible: audio.status

            width: audio.width * (3 / 37)
            height: audio.width * (1 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (3 / 37)
            anchors.leftMargin: audio.width * (31 / 37)

            color: "white"
        }

        Rectangle {
            id: runAndStopAudio

            visible: audio.status

            width: audio.width * (6 / 37)
            height: audio.width * (3 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 37)
            anchors.leftMargin: audio.width * (28 / 37)

            color: "white"
        }

        Rectangle {
            id: spoiler

            width: audio.width * (1 / 37)
            height: audio.width * (7 / 37)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 37)
            anchors.leftMargin: audio.status ? audio.width * (35 / 37) :  audio.width * (9 / 37)

            color: "white"

            Button {
                id: spoilerButton

                anchors.fill: spoiler

                onClicked: {
                    audio.status = !audio.status;
                }
            }
        }
    }
}
