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
                            trimmingIndicatorLeftTimeLeftText.updateIndicatorX()
                            trimmingIndicatorRightTimeRightText.updateIndicatorX()
                        }

                        onYChanged: {
                            trimmingIndicatorLeftTimeLeftText.updateIndicatorX()
                            trimmingIndicatorRightTimeRightText.updateIndicatorX()
                        }

                        onWidthChanged: {
                            trimmingIndicatorLeftTimeLeftText.updateIndicatorX()
                            trimmingIndicatorRightTimeRightText.updateIndicatorX()
                        }

                        onHeightChanged: {
                            trimmingIndicatorLeftTimeLeftText.updateIndicatorX()
                            trimmingIndicatorRightTimeRightText.updateIndicatorX()
                        }
                    }

                    Rectangle {
                        id: trimmingLineLeft

                        width: trimmingIndicatorLeft.x
                        height: audio.width * (3 / 223)

                        anchors.top: trimmingLine.top
                        anchors.left: trimmingLine.left

                        anchors.topMargin: audio.width * (1 / 223)
                        anchors.leftMargin: audio.width * (1 / 223)

                        color: "red"
                    }

                    Rectangle {
                        id: trimmingLineRight

                        width: trimmingLineBackground.width - (audio.width * (1 / 223)) - trimmingIndicatorRight.x
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
                    id: trimmingIndicatorLeft

                    anchors.top: trimming.top

                    width: audio.width * (9 / 223)
                    height: audio.width * (11 / 223)

                    color: "transparent"

                    focus: false

                    Keys.onLeftPressed: {
                        if (trimmingIndicatorLeftTimeLeftText.parseMicroseconds(trimmingIndicatorLeftTimeLeftText.text) > 0) {
                            trimmingIndicatorLeftTimeLeftText.text = trimmingIndicatorLeftTimeLeftText.formatMicroseconds(trimmingIndicatorLeftTimeLeftText.parseMicroseconds(trimmingIndicatorLeftTimeLeftText.text) - 1)
                        }
                    }
                    Keys.onRightPressed: {
                        if (trimmingIndicatorLeftTimeLeftText.parseMicroseconds(trimmingIndicatorLeftTimeLeftText.text) < mixer.maximumTime) {
                            trimmingIndicatorLeftTimeLeftText.text = trimmingIndicatorLeftTimeLeftText.formatMicroseconds(trimmingIndicatorLeftTimeLeftText.parseMicroseconds(trimmingIndicatorLeftTimeLeftText.text) + 1)
                        }
                    }

                    Rectangle {
                        id: trimmingIndicatorLeftHead

                        width: audio.width * (9 / 223)
                        height: audio.width * (5 / 223)

                        anchors.top: trimmingIndicatorLeft.top
                        anchors.left: trimmingIndicatorLeft.left

                        color: "black"

                        Rectangle {
                            id: trimmingIndicatorLeftHeadIn

                            width: audio.width * (7 / 223)
                            height: audio.width * (3 / 223)

                            anchors.top: trimmingIndicatorLeftHead.top
                            anchors.left: trimmingIndicatorLeftHead.left

                            anchors.topMargin: audio.width * (1 / 223)
                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "red"
                        }
                    }

                    Rectangle {
                        id: trimmingIndicatorLeftLeg

                        width: audio.width * (3 / 223)
                        height: audio.width * (7 / 223)

                        anchors.top: trimmingIndicatorLeft.top
                        anchors.left: trimmingIndicatorLeft.left

                        anchors.topMargin: audio.width * (4 / 223)
                        anchors.leftMargin: audio.width * (3 / 223)

                        color: "black"

                        Rectangle {
                            id: trimmingIndicatorLeftLegIn

                            width: audio.width * (1 / 223)
                            height: audio.width * (6 / 223)

                            anchors.top: trimmingIndicatorLeftLeg.top
                            anchors.left: trimmingIndicatorLeftLeg.left

                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "red"
                        }
                    }

                    MouseArea {
                        id: trimmingIndicatorLeftMouseArea
                        anchors.fill: trimmingIndicatorLeft
                        drag.target: trimmingIndicatorLeft
                        drag.axis: Drag.XAxis
                        cursorShape: Qt.SizeHorCursor
                        drag.minimumX: 0
                        drag.maximumX: (trimmingLineBackground.width - audio.width * (1 / 223)) - trimmingLineRight.width

                        onPositionChanged: function(mouse) {
                            trimmingIndicatorLeftTimeLeftText.text = trimmingIndicatorLeftTimeLeftText.formatMicroseconds((trimmingLineLeft.width / (trimmingLineBackground.width - audio.width * (1 / 223))) * mixer.maximumTime)
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
                        if ((trimmingIndicatorLeftTimeLeftText.parseMicroseconds(trimmingIndicatorLeftTimeLeftText.text)) / mixer.maximumTime <= 0.5) {
                            trimmingIndicatorLeftTimeLeft.anchors.top = trimmingIndicatorLeft.top
                            trimmingIndicatorLeftTimeLeft.anchors.bottom = trimmingIndicatorLeft.bottom
                            trimmingIndicatorLeftTimeLeft.anchors.right = trimming.right
                            trimmingIndicatorLeftTimeLeft.anchors.left = trimmingIndicatorLeft.right
                            trimmingIndicatorLeftTimeLeft.anchors.rightMargin = 0
                            trimmingIndicatorLeftTimeLeft.anchors.leftMargin = audio.width * (1 / 223)
                            trimmingIndicatorLeftTimeLeftText.horizontalAlignment = Text.AlignLeft
                        } else {
                            trimmingIndicatorLeftTimeLeft.anchors.top = trimmingIndicatorLeft.top
                            trimmingIndicatorLeftTimeLeft.anchors.bottom = trimmingIndicatorLeft.bottom
                            trimmingIndicatorLeftTimeLeft.anchors.right = trimmingIndicatorLeft.left
                            trimmingIndicatorLeftTimeLeft.anchors.left = trimming.left
                            trimmingIndicatorLeftTimeLeft.anchors.rightMargin = audio.width * (1 / 223)
                            trimmingIndicatorLeftTimeLeft.anchors.leftMargin = 0
                            trimmingIndicatorLeftTimeLeftText.horizontalAlignment = Text.AlignRight
                        }
                    }
                }

                Rectangle {
                    id: trimmingIndicatorRight

                    anchors.bottom: trimming.bottom

                    width: audio.width * (9 / 223)
                    height: audio.width * (11 / 223)

                    color: "transparent"

                    focus: true

                    Keys.onLeftPressed: {
                        if (trimmingIndicatorRightTimeRightText.parseMicroseconds(trimmingIndicatorRightTimeRightText.text) > 0) {
                            trimmingIndicatorRightTimeRightText.text = trimmingIndicatorRightTimeRightText.formatMicroseconds(trimmingIndicatorRightTimeRightText.parseMicroseconds(trimmingIndicatorRightTimeRightText.text) - 1)
                        }
                    }
                    Keys.onRightPressed: {
                        if (trimmingIndicatorRightTimeRightText.parseMicroseconds(trimmingIndicatorRightTimeRightText.text) < mixer.maximumTime) {
                            trimmingIndicatorRightTimeRightText.text = trimmingIndicatorRightTimeRightText.formatMicroseconds(trimmingIndicatorRightTimeRightText.parseMicroseconds(trimmingIndicatorRightTimeRightText.text) + 1)
                        }
                    }

                    Rectangle {
                        id: trimmingIndicatorRightHead

                        width: audio.width * (9 / 223)
                        height: audio.width * (5 / 223)

                        anchors.bottom: trimmingIndicatorRight.bottom
                        anchors.left: trimmingIndicatorRight.left

                        color: "black"

                        Rectangle {
                            id: trimmingIndicatorRightHeadIn

                            width: audio.width * (7 / 223)
                            height: audio.width * (3 / 223)

                            anchors.bottom: trimmingIndicatorRightHead.bottom
                            anchors.left: trimmingIndicatorRightHead.left

                            anchors.bottomMargin: audio.width * (1 / 223)
                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "blue"
                        }
                    }

                    Rectangle {
                        id: trimmingIndicatorRightLeg

                        width: audio.width * (3 / 223)
                        height: audio.width * (7 / 223)

                        anchors.bottom: trimmingIndicatorRight.bottom
                        anchors.left: trimmingIndicatorRight.left

                        anchors.bottomMargin: audio.width * (4 / 223)
                        anchors.leftMargin: audio.width * (3 / 223)

                        color: "black"

                        Rectangle {
                            id: trimmingIndicatorRightLegIn

                            width: audio.width * (1 / 223)
                            height: audio.width * (6 / 223)

                            anchors.bottom: trimmingIndicatorRightLeg.bottom
                            anchors.left: trimmingIndicatorRightLeg.left

                            anchors.leftMargin: audio.width * (1 / 223)

                            color: "blue"
                        }
                    }

                    MouseArea {
                        id: trimmingIndicatorRightMouseArea
                        anchors.fill: trimmingIndicatorRight
                        drag.target: trimmingIndicatorRight
                        drag.axis: Drag.XAxis
                        cursorShape: Qt.SizeHorCursor
                        drag.minimumX: trimmingLineLeft.width
                        drag.maximumX: trimmingLineBackground.width - audio.width * (1 / 223)

                        onPositionChanged: function(mouse) {
                            trimmingIndicatorRightTimeRightText.text = trimmingIndicatorRightTimeRightText.formatMicroseconds((1 - (trimmingLineRight.width / (trimmingLineBackground.width - audio.width * (1 / 223)))) * mixer.maximumTime)
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
                        if ((trimmingIndicatorRightTimeRightText.parseMicroseconds(trimmingIndicatorRightTimeRightText.text)) / mixer.maximumTime <= 0.5) {
                            trimmingIndicatorRightTimeRight.anchors.top = trimmingIndicatorRight.top
                            trimmingIndicatorRightTimeRight.anchors.bottom = trimmingIndicatorRight.bottom
                            trimmingIndicatorRightTimeRight.anchors.right = trimming.right
                            trimmingIndicatorRightTimeRight.anchors.left = trimmingIndicatorRight.right
                            trimmingIndicatorRightTimeRight.anchors.rightMargin = 0
                            trimmingIndicatorRightTimeRight.anchors.leftMargin = audio.width * (1 / 223)
                            trimmingIndicatorRightTimeRightText.horizontalAlignment = Text.AlignLeft
                        } else {
                            trimmingIndicatorRightTimeRight.anchors.top = trimmingIndicatorRight.top
                            trimmingIndicatorRightTimeRight.anchors.bottom = trimmingIndicatorRight.bottom
                            trimmingIndicatorRightTimeRight.anchors.right = trimmingIndicatorRight.left
                            trimmingIndicatorRightTimeRight.anchors.left = trimming.left
                            trimmingIndicatorRightTimeRight.anchors.rightMargin = audio.width * (1 / 223)
                            trimmingIndicatorRightTimeRight.anchors.leftMargin = 0
                            trimmingIndicatorRightTimeRightText.horizontalAlignment = Text.AlignRight
                        }
                    }
                }

                Rectangle {
                    id: trimmingIndicatorLeftTimeLeft

                    anchors.bottomMargin: audio.width * (7 / 223)

                    color: "transparent"

                    Text {
                        id: trimmingIndicatorLeftTimeLeftText

                        anchors.fill: trimmingIndicatorLeftTimeLeft

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
                            trimmingIndicatorLeft.x = ((trimmingIndicatorLeftTimeLeftText.parseMicroseconds(trimmingIndicatorLeftTimeLeftText.text)) / mixer.maximumTime) * (trimmingLineBackground.width - audio.width * (1 / 223))
                        }

                        Component.onCompleted: {
                            updateIndicatorX()
                            adjustFontSize()
                        }
                    }
                }

                Rectangle {
                    id: trimmingIndicatorRightTimeRight

                    anchors.topMargin: audio.width * (7 / 223)

                    color: "transparent"

                    Text {
                        id: trimmingIndicatorRightTimeRightText

                        anchors.fill: trimmingIndicatorRightTimeRight

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
                            trimmingIndicatorRight.x = ((trimmingIndicatorRightTimeRightText.parseMicroseconds(trimmingIndicatorRightTimeRightText.text)) / mixer.maximumTime) * (trimmingLineBackground.width - audio.width * (1 / 223))
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
