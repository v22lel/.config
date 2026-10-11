import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import "../../."
import "../."

Item {
    id: root

    property real percentage: 1.0
    property bool isCharging: false

    readonly property color barColor: {
        if (root.isCharging) return Theme.good
        if (root.percentage <= 0.15) return Theme.bad
        if (root.percentage <= 0.30) return Theme.warn
        return Theme.text
    }

    implicitWidth: 32
    implicitHeight: 16

    Rectangle {
        id: body
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - 4
        
        radius: 3
        color: "transparent"
        border.color: Theme.text
        border.width: 2

        Rectangle {
            id: fillLevel
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 3
            }
            width: Math.max(0, (body.width - 6) * Math.min(1.0, Math.max(0.0, root.percentage)))
            radius: 1.5
            color: root.barColor

            Behavior on width {
                NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
            }
        }
    }

    Rectangle {
        anchors {
            left: body.right
            leftMargin: 1
            verticalCenter: body.verticalCenter
        }
        width: 3
        height: 6
        radius: 1
        color: Theme.text
    }
}