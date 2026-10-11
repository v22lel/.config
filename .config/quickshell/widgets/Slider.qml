import QtQuick
import QtQuick.Controls
import "."
import "../."

Item {
    id: root

    property real value: 0.0
    property real min: 0.0
    property real max: 100.0
    property color trackColor: Theme.base
    property color fillColor: Theme.text
    property color handleColor: Theme.text
    property int sliderWidth: 100

    property bool animateValue: false

    signal sliderMoved(real val)

    height: Theme.fontSize
    implicitWidth: root.sliderWidth
    implicitHeight: Theme.fontSize

    readonly property real currentRatio: (root.value - root.min) / (root.max - root.min)

    function forceSet(val) {
        root.animateValue = true
        root.value = val

        Qt.callLater(() => {
            root.animateValue = false
        })
    }

    Behavior on value {
        enabled: root.animateValue
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        id: track

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right

        height: 6
        radius: 3
        color: root.trackColor

        Rectangle {
            width: parent.width * Math.max(0.0, Math.min(1.0, root.currentRatio))
            height: parent.height

            radius: parent.radius
            color: root.fillColor
        }
    }

    Rectangle {
        id: handle
        x: Math.max(0, Math.min(track.width - width, 
            (track.width * root.currentRatio) - (width / 2)))
        anchors.verticalCenter: parent.verticalCenter

        width: mouseArea.pressed || mouseArea.containsMouse ? 16 : 12
        height: width
        radius: width / 2
        color: root.handleColor

        border.width: 2
        border.color: Qt.darker(root.fillColor, 1.2)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        function updateValue(mouseX) {
            let ratio = Math.max(0.0, Math.min(1.0, mouseX / track.width))
            let newValue = root.min + (ratio * (root.max - root.min))
            root.value = newValue
            root.sliderMoved(newValue)
        }

        onPressed: (mouse) => updateValue(mouse.x)
        onPositionChanged: (mouse) => {
            if (pressed) {
                updateValue(mouse.x)
            }
        }
    }
}