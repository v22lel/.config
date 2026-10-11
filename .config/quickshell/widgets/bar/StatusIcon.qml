import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../../."
import "../."

Item {
    id: root

    required property string icon

    implicitWidth: Theme.fontSize * Theme.iconFac
    implicitHeight: Theme.fontSize * Theme.iconFac

    IconImage {
        id: icon

        anchors.fill: parent
        source: Quickshell.iconPath(root.icon)
        visible: false
    }

    Colorize {
        anchors.fill: icon
        source: icon
        hue: 0.0
        saturation: 0
        lightness: 1
    }
}