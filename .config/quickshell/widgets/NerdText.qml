import QtQuick
import "../."

Item {
    id: root

    property alias text: iconText.text

    implicitWidth: Theme.fontSize * 1.5
    implicitHeight: Theme.fontSize * 1.5

    Text {
        id: iconText
        anchors.fill: parent
        anchors.centerIn: parent

        font.pixelSize: Theme.fontSize * 1.5
        color: Theme.text

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}