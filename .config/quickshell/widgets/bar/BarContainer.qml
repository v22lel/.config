import QtQuick
import QtQuick.Layouts
import "../../."
import "../."

Rectangle {
    id: root

    color: Theme.base
    radius: Theme.containerRadius
    border.color: Qt.rgba(1, 1, 1, 0.08)
    border.width: 0

    default property alias content: contentLayout.children
    property alias spacing: contentLayout.spacing

    implicitWidth: contentLayout.implicitWidth + (Theme.containerPadding * 2)
    implicitHeight: Theme.barHeight
    height: Theme.barHeight

    RowLayout {
        id: contentLayout
        anchors.centerIn: parent
        spacing: 8
    }
}