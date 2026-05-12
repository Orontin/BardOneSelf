import QtQuick
import QtQuick.Window
import QtQuick.Effects
import QtQuick.Controls
import Qt.labs.platform

Window {
    id: root

    width: 800
    height: 600

    visible: true

    title: "Сам себе Бард"

    color: "white"

    Rectangle {
        id: audio

        property bool status: true

        width: root.width * (223 / 223)
        height: root.width * (55 / 223)

        anchors.top: root.top
        anchors.left: root.left

        color: "black"

        Rectangle {
            id: name

            width: audio.status ? audio.width * (148 / 223) : audio.width * (49 / 223)
            height: audio.width * (3 / 223)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 223)
            anchors.leftMargin: audio.width * (1 / 223)

            color: "white"

            TextEdit {
                id: nameText

                property string fullText: ""

                anchors.fill: name

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "black"

                wrapMode: Text.NoWrap

                font.family: "Courier New"
                font.bold: true

                enabled: audio.status

                onEnabledChanged: {
                    if (enabled) {
                        text = fullText
                    } else {
                        if (fullText.length > 29) {
                            text = fullText.substring(0, 29) + "..."
                        } else {
                            text = fullText
                        }
                    }
                }

                onTextChanged: {
                    if (enabled) {
                        fullText = text
                    }
                    adjustFontSize()
                }

                onWidthChanged: {
                    adjustFontSize()
                }

                onHeightChanged: {
                    adjustFontSize()
                }

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

                Component.onCompleted: {
                    adjustFontSize()
                }
            }
        }

        Rectangle {
            id: img

            width: audio.width * (49 / 223)
            height: audio.width * (49 / 223)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 223)
            anchors.leftMargin: audio.width * (1 / 223)

            enabled: audio.status

            color: "white"

            Image {
                id: imgSet

                anchors.fill: img

                fillMode: Image.Stretch

                MouseArea {
                    id: imgSetMouseArea

                    anchors.fill: imgSet

                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        imgSetFileDialog.open()
                    }
                }

                FileDialog {
                    id: imgSetFileDialog

                    title: "Выберите изображение"

                    onAccepted: {
                        imgSet.source = imgSetFileDialog.file.toString()
                    }
                }
            }
        }

        Rectangle {
            id: mixer

            property real maximumTime: 35999999999

            width: audio.width * (98 / 223)
            height: audio.width * (49 / 223)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (5 / 223)
            anchors.leftMargin: audio.width * (51 / 223)

            visible: audio.status

            color: "white"

            Rectangle {
                id: trimming

                width: audio.width * (96 / 223)
                height: audio.width * (17 / 223)

                anchors.top: mixer.top
                anchors.left: mixer.left

                anchors.topMargin: audio.width * (1 / 223)
                anchors.leftMargin: audio.width * (1 / 223)

                color: "transparent"

                Rectangle {
                    id: trimmingLine

                    width: audio.width * (90 / 223)
                    height: audio.width * (5 / 223)

                    anchors.top: trimming.top
                    anchors.left: trimming.left

                    anchors.topMargin: audio.width * (6 / 223)
                    anchors.leftMargin: audio.width * (3 / 223)

                    color: "black"

                    Rectangle {
                        id: trimmingLineBackground

                        width: audio.width * (88 / 223)
                        height: audio.width * (3 / 223)

                        anchors.top: trimmingLine.top
                        anchors.left: trimmingLine.left

                        anchors.topMargin: audio.width * (1 / 223)
                        anchors.leftMargin: audio.width * (1 / 223)

                        color: "grey"

                        onXChanged: {
                            indicatorLeftTimeLeftText.updateIndicatorX()
                            indicatorRightTimeRightText.updateIndicatorX()
                        }

                        onYChanged: {
                            indicatorLeftTimeLeftText.updateIndicatorX()
                            indicatorRightTimeRightText.updateIndicatorX()
                        }

                        onWidthChanged: {
                            indicatorLeftTimeLeftText.updateIndicatorX()
                            indicatorRightTimeRightText.updateIndicatorX()
                        }

                        onHeightChanged: {
                            indicatorLeftTimeLeftText.updateIndicatorX()
                            indicatorRightTimeRightText.updateIndicatorX()
                        }
                    }

                    Rectangle {
                        id: trimmingLineLeft

                        width: indicatorLeft.x
                        height: audio.width * (3 / 223)

                        anchors.top: trimmingLine.top
                        anchors.left: trimmingLine.left

                        anchors.topMargin: audio.width * (1 / 223)
                        anchors.leftMargin: audio.width * (1 / 223)

                        color: "red"
                    }

                    Rectangle {
                        id: trimmingLineRight

                        width: trimmingLineBackground.width - (audio.width * (1 / 223)) - indicatorRight.x
                        height: audio.width * (3 / 223)

                        anchors.top: trimmingLine.top
                        anchors.right: trimmingLine.right

                        anchors.topMargin: audio.width * (1 / 223)
                        anchors.rightMargin: audio.width * (1 / 223)

                        color: "blue"
                    }

                    Rectangle {
                        id: trimmingLineTopWhite

                        width: audio.width * (84 / 223)
                        height: audio.width * (2 / 223)

                        anchors.top: trimmingLine.top
                        anchors.left: trimmingLine.left

                        anchors.leftMargin: audio.width * (3 / 223)

                        color: "white"

                        Rectangle {
                            id: trimmingLineTopBlack

                            width: audio.width * (86 / 223)
                            height: audio.width * (1 / 223)

                            anchors.bottom: trimmingLineTopWhite.bottom
                            anchors.left: trimmingLineTopWhite.left

                            anchors.leftMargin: audio.width * (-1 / 223)

                            color: "black"
                        }
                    }

                    Rectangle {
                        id: trimmingLineBottomWhite

                        width: audio.width * (84 / 223)
                        height: audio.width * (2 / 223)

                        anchors.bottom: trimmingLine.bottom
                        anchors.left: trimmingLine.left

                        anchors.leftMargin: audio.width * (3 / 223)

                        color: "white"

                        Rectangle {
                            id: trimmingLineBottomBlack

                            width: audio.width * (86 / 223)
                            height: audio.width * (1 / 223)

                            anchors.top: trimmingLineBottomWhite.top
                            anchors.left: trimmingLineBottomWhite.left

                            anchors.leftMargin: audio.width * (-1 / 223)

                            color: "black"
                        }
                    }
                }

                Rectangle {
                    id: indicatorLeft

                    anchors.top: trimming.top

                    width: audio.width * (9 / 223)
                    height: audio.width * (11 / 223)

                    color: "transparent"

                    focus: false

                    Keys.onLeftPressed: {
                        if (indicatorLeftTimeLeftText.parseMicroseconds(indicatorLeftTimeLeftText.text) > 0) {
                            indicatorLeftTimeLeftText.text = indicatorLeftTimeLeftText.formatMicroseconds(indicatorLeftTimeLeftText.parseMicroseconds(indicatorLeftTimeLeftText.text) - 1)
                        }
                    }
                    Keys.onRightPressed: {
                        if (indicatorLeftTimeLeftText.parseMicroseconds(indicatorLeftTimeLeftText.text) < mixer.maximumTime) {
                            indicatorLeftTimeLeftText.text = indicatorLeftTimeLeftText.formatMicroseconds(indicatorLeftTimeLeftText.parseMicroseconds(indicatorLeftTimeLeftText.text) + 1)
                        }
                    }

                    Rectangle {
                        id: indicatorLeftHead

                        width: audio.width * (9 / 223)
                        height: audio.width * (5 / 223)

                        anchors.top: indicatorLeft.top
                        anchors.left: indicatorLeft.left

                        color: "black"

                        Rectangle {
                            id: indicatorLeftHeadIn

                            width: audio.width * (7 / 223)
                            height: audio.width * (3 / 223)

                            anchors.top: indicatorLeftHead.top
                            anchors.left: indicatorLeftHead.left

                            anchors.topMargin: audio.width * (1 / 223)
                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "red"
                        }
                    }

                    Rectangle {
                        id: indicatorLeftLeg

                        width: audio.width * (3 / 223)
                        height: audio.width * (7 / 223)

                        anchors.top: indicatorLeft.top
                        anchors.left: indicatorLeft.left

                        anchors.topMargin: audio.width * (4 / 223)
                        anchors.leftMargin: audio.width * (3 / 223)

                        color: "black"

                        Rectangle {
                            id: indicatorLeftLegIn

                            width: audio.width * (1 / 223)
                            height: audio.width * (6 / 223)

                            anchors.top: indicatorLeftLeg.top
                            anchors.left: indicatorLeftLeg.left

                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "red"
                        }
                    }

                    MouseArea {
                        id: indicatorLeftMouseArea
                        anchors.fill: indicatorLeft
                        drag.target: indicatorLeft
                        drag.axis: Drag.XAxis
                        cursorShape: Qt.SizeHorCursor
                        drag.minimumX: 0
                        drag.maximumX: (trimmingLineBackground.width - audio.width * (1 / 223)) - trimmingLineRight.width

                        onPositionChanged: function(mouse) {
                            indicatorLeftTimeLeftText.text = indicatorLeftTimeLeftText.formatMicroseconds((trimmingLineLeft.width / (trimmingLineBackground.width - audio.width * (1 / 223))) * mixer.maximumTime)
                        }
                    }

                    onXChanged: {
                        adjustSize()
                    }

                    onYChanged: {
                        adjustSize()
                    }

                    onWidthChanged: {
                        adjustSize()
                    }

                    onHeightChanged: {
                        adjustSize()
                    }

                    Component.onCompleted: {
                        adjustSize()
                    }

                    function adjustSize() {
                        if ((indicatorLeftTimeLeftText.parseMicroseconds(indicatorLeftTimeLeftText.text)) / mixer.maximumTime <= 0.5) {
                            indicatorLeftTimeLeft.anchors.top = indicatorLeft.top
                            indicatorLeftTimeLeft.anchors.bottom = indicatorLeft.bottom
                            indicatorLeftTimeLeft.anchors.right = trimming.right
                            indicatorLeftTimeLeft.anchors.left = indicatorLeft.right
                            indicatorLeftTimeLeft.anchors.rightMargin = 0
                            indicatorLeftTimeLeft.anchors.leftMargin = audio.width * (1 / 223)
                            indicatorLeftTimeLeftText.horizontalAlignment = Text.AlignLeft
                        } else {
                            indicatorLeftTimeLeft.anchors.top = indicatorLeft.top
                            indicatorLeftTimeLeft.anchors.bottom = indicatorLeft.bottom
                            indicatorLeftTimeLeft.anchors.right = indicatorLeft.left
                            indicatorLeftTimeLeft.anchors.left = trimming.left
                            indicatorLeftTimeLeft.anchors.rightMargin = audio.width * (1 / 223)
                            indicatorLeftTimeLeft.anchors.leftMargin = 0
                            indicatorLeftTimeLeftText.horizontalAlignment = Text.AlignRight
                        }
                    }
                }

                Rectangle {
                    id: indicatorRight

                    anchors.bottom: trimming.bottom

                    width: audio.width * (9 / 223)
                    height: audio.width * (11 / 223)

                    color: "transparent"

                    focus: true

                    Keys.onLeftPressed: {
                        if (indicatorRightTimeRightText.parseMicroseconds(indicatorRightTimeRightText.text) > 0) {
                            indicatorRightTimeRightText.text = indicatorRightTimeRightText.formatMicroseconds(indicatorRightTimeRightText.parseMicroseconds(indicatorRightTimeRightText.text) - 1)
                        }
                    }
                    Keys.onRightPressed: {
                        if (indicatorRightTimeRightText.parseMicroseconds(indicatorRightTimeRightText.text) < mixer.maximumTime) {
                            indicatorRightTimeRightText.text = indicatorRightTimeRightText.formatMicroseconds(indicatorRightTimeRightText.parseMicroseconds(indicatorRightTimeRightText.text) + 1)
                        }
                    }

                    Rectangle {
                        id: indicatorRightHead

                        width: audio.width * (9 / 223)
                        height: audio.width * (5 / 223)

                        anchors.bottom: indicatorRight.bottom
                        anchors.left: indicatorRight.left

                        color: "black"

                        Rectangle {
                            id: indicatorRightHeadIn

                            width: audio.width * (7 / 223)
                            height: audio.width * (3 / 223)

                            anchors.bottom: indicatorRightHead.bottom
                            anchors.left: indicatorRightHead.left

                            anchors.bottomMargin: audio.width * (1 / 223)
                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "blue"
                        }
                    }

                    Rectangle {
                        id: indicatorRightLeg

                        width: audio.width * (3 / 223)
                        height: audio.width * (7 / 223)

                        anchors.bottom: indicatorRight.bottom
                        anchors.left: indicatorRight.left

                        anchors.bottomMargin: audio.width * (4 / 223)
                        anchors.leftMargin: audio.width * (3 / 223)

                        color: "black"

                        Rectangle {
                            id: indicatorRightLegIn

                            width: audio.width * (1 / 223)
                            height: audio.width * (6 / 223)

                            anchors.bottom: indicatorRightLeg.bottom
                            anchors.left: indicatorRightLeg.left

                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "blue"
                        }
                    }

                    MouseArea {
                        id: indicatorRightMouseArea
                        anchors.fill: indicatorRight
                        drag.target: indicatorRight
                        drag.axis: Drag.XAxis
                        cursorShape: Qt.SizeHorCursor
                        drag.minimumX: trimmingLineLeft.width
                        drag.maximumX: trimmingLineBackground.width - audio.width * (1 / 223)

                        onPositionChanged: function(mouse) {
                            indicatorRightTimeRightText.text = indicatorRightTimeRightText.formatMicroseconds((1 - (trimmingLineRight.width / (trimmingLineBackground.width - audio.width * (1 / 223)))) * mixer.maximumTime)
                        }
                    }

                    onXChanged: {
                        adjustSize()
                    }

                    onYChanged: {
                        adjustSize()
                    }

                    onWidthChanged: {
                        adjustSize()
                    }

                    onHeightChanged: {
                        adjustSize()
                    }

                    Component.onCompleted: {
                        adjustSize()
                    }

                    function adjustSize() {
                        if ((indicatorRightTimeRightText.parseMicroseconds(indicatorRightTimeRightText.text)) / mixer.maximumTime <= 0.5) {
                            indicatorRightTimeRight.anchors.top = indicatorRight.top
                            indicatorRightTimeRight.anchors.bottom = indicatorRight.bottom
                            indicatorRightTimeRight.anchors.right = trimming.right
                            indicatorRightTimeRight.anchors.left = indicatorRight.right
                            indicatorRightTimeRight.anchors.rightMargin = 0
                            indicatorRightTimeRight.anchors.leftMargin = audio.width * (1 / 223)
                            indicatorRightTimeRightText.horizontalAlignment = Text.AlignLeft
                        } else {
                            indicatorRightTimeRight.anchors.top = indicatorRight.top
                            indicatorRightTimeRight.anchors.bottom = indicatorRight.bottom
                            indicatorRightTimeRight.anchors.right = indicatorRight.left
                            indicatorRightTimeRight.anchors.left = trimming.left
                            indicatorRightTimeRight.anchors.rightMargin = audio.width * (1 / 223)
                            indicatorRightTimeRight.anchors.leftMargin = 0
                            indicatorRightTimeRightText.horizontalAlignment = Text.AlignRight
                        }
                    }
                }

                Rectangle {
                    id: indicatorLeftTimeLeft

                    anchors.bottomMargin: audio.width * (7 / 223)

                    color: "transparent"

                    Text {
                        id: indicatorLeftTimeLeftText

                        anchors.fill: indicatorLeftTimeLeft

                        verticalAlignment: Text.AlignVCenter

                        color: "black"

                        wrapMode: Text.NoWrap

                        font.family: "Courier New"
                        font.bold: true

                        text: formatMicroseconds(0)

                        onTextChanged: {
                            updateIndicatorX()
                        }

                        onWidthChanged: {
                            adjustFontSize()
                        }

                        onHeightChanged: {
                            adjustFontSize()
                        }

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

                        function formatMicroseconds(micros) {
                            var totalMicros = Math.floor(micros);

                            var totalSecs = Math.floor(totalMicros / 1000000);
                            var hours   = Math.floor(totalSecs / 3600);
                            var minutes = Math.floor((totalSecs % 3600) / 60);
                            var seconds = totalSecs % 60;

                            var remainingMicros = totalMicros % 1000000;
                            var millis = Math.floor(remainingMicros / 1000);
                            var microsPart = remainingMicros % 1000;

                            function pad2(n) {
                                return n < 10 ? "0" + n : "" + n;
                            }
                            function pad3(n) {
                                if (n < 10) {
                                    return "00" + n;
                                }
                                if (n < 100) {
                                    return "0" + n;
                                }
                                return "" + n;
                            }

                            return hours + ":" + pad2(minutes) + ":" + pad2(seconds) + ":" + pad3(millis) + ":" + pad3(microsPart);
                        }

                        function parseMicroseconds(str) {
                            const parts = str.split(':');

                            const hours = parseInt(parts[0], 10);
                            const minutes = parseInt(parts[1], 10);
                            const seconds = parseInt(parts[2], 10);
                            const millis = parseInt(parts[3], 10);
                            const micros = parseInt(parts[4], 10);

                            const totalMicros = (hours * 3600 + minutes * 60 + seconds) * 1000000 + millis * 1000 + micros;
                            return totalMicros;
                        }

                        function updateIndicatorX() {
                            indicatorLeft.x = ((indicatorLeftTimeLeftText.parseMicroseconds(indicatorLeftTimeLeftText.text)) / mixer.maximumTime) * (trimmingLineBackground.width - audio.width * (1 / 223))
                        }

                        Component.onCompleted: {
                            updateIndicatorX()
                            adjustFontSize()
                        }
                    }
                }

                Rectangle {
                    id: indicatorRightTimeRight

                    anchors.topMargin: audio.width * (7 / 223)

                    color: "transparent"

                    Text {
                        id: indicatorRightTimeRightText

                        anchors.fill: indicatorRightTimeRight

                        verticalAlignment: Text.AlignVCenter

                        color: "black"

                        wrapMode: Text.NoWrap

                        font.family: "Courier New"
                        font.bold: true

                        text: formatMicroseconds(mixer.maximumTime)

                        onTextChanged: {
                            updateIndicatorX()
                        }

                        onWidthChanged: {
                            adjustFontSize()
                        }

                        onHeightChanged: {
                            adjustFontSize()
                        }

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

                        function formatMicroseconds(micros) {
                            var totalMicros = Math.floor(micros);

                            var totalSecs = Math.floor(totalMicros / 1000000);
                            var hours   = Math.floor(totalSecs / 3600);
                            var minutes = Math.floor((totalSecs % 3600) / 60);
                            var seconds = totalSecs % 60;

                            var remainingMicros = totalMicros % 1000000;
                            var millis = Math.floor(remainingMicros / 1000);
                            var microsPart = remainingMicros % 1000;

                            function pad2(n) {
                                return n < 10 ? "0" + n : "" + n;
                            }
                            function pad3(n) {
                                if (n < 10) {
                                    return "00" + n;
                                }
                                if (n < 100) {
                                    return "0" + n;
                                }
                                return "" + n;
                            }

                            return hours + ":" + pad2(minutes) + ":" + pad2(seconds) + ":" + pad3(millis) + ":" + pad3(microsPart);
                        }

                        function parseMicroseconds(str) {
                            const parts = str.split(':');

                            const hours = parseInt(parts[0], 10);
                            const minutes = parseInt(parts[1], 10);
                            const seconds = parseInt(parts[2], 10);
                            const millis = parseInt(parts[3], 10);
                            const micros = parseInt(parts[4], 10);

                            const totalMicros = (hours * 3600 + minutes * 60 + seconds) * 1000000 + millis * 1000 + micros;
                            return totalMicros;
                        }

                        function updateIndicatorX() {
                            indicatorRight.x = ((indicatorRightTimeRightText.parseMicroseconds(indicatorRightTimeRightText.text)) / mixer.maximumTime) * (trimmingLineBackground.width - audio.width * (1 / 223))
                        }

                        Component.onCompleted: {
                            updateIndicatorX()
                            adjustFontSize()
                        }
                    }
                }
            }

            Rectangle {
                id: player

                width: audio.width * (96 / 223)
                height: audio.width * (17 / 223)

                anchors.top: mixer.top
                anchors.left: mixer.left

                anchors.topMargin: audio.width * (19 / 223)
                anchors.leftMargin: audio.width * (1 / 223)

                color: "black"
            }

            Rectangle {
                id: volume

                width: audio.width * (96 / 223)
                height: audio.width * (11 / 223)

                anchors.top: mixer.top
                anchors.left: mixer.left

                anchors.topMargin: audio.width * (37 / 223)
                anchors.leftMargin: audio.width * (1 / 223)

                color: "black"
            }
        }

        Rectangle {
            id: buttons

            width: audio.width * (18 / 223)
            height: audio.width * (53 / 223)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 223)
            anchors.leftMargin: audio.width * (150 / 223)

            visible: audio.status

            color: "white"
        }

        Rectangle {
            id: tegs

            width: audio.width * (49 / 223)
            height: audio.width * (53 / 223)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 223)
            anchors.leftMargin: audio.width * (169 / 223)

            visible: audio.status

            color: "white"
        }

        Rectangle {
            id: spoiler

            width: audio.width * (3 / 223)
            height: audio.width * (53 / 223)

            anchors.top: audio.top
            anchors.left: audio.left

            anchors.topMargin: audio.width * (1 / 223)
            anchors.leftMargin: audio.status ? audio.width * (219 / 223) : audio.width * (51 / 223)

            color: "white"

            Button {
                id: spoilerButton

                anchors.fill: spoiler

                background: Rectangle {
                    id: spoilerButtonBackground

                    anchors.fill: spoilerButton

                    color: "white"
                }

                onClicked: {
                    audio.status = !audio.status;
                }
            }
        }
    }
}
