import QtQuick
import "../."

Item {
    id: root

    property alias text: iconText.text
    property alias font: iconText.font

    implicitWidth: iconText.implicitWidth
    implicitHeight: iconText.implicitHeight

    Text {
        id: iconText
        anchors.fill: parent

        font.pixelSize: Theme.fontSize
        color: Theme.text

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}