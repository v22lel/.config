import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Qt5Compat.GraphicalEffects
import "../../."
import "../."

RowLayout {
    id: trayLayout
    spacing: 6

    property bool isEmpty: {
        return SystemTray.items.values.length == 0
    }

    Repeater {
        model: SystemTray.items.values

        delegate: Item {
            id: trayItemWrapper

            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter

            required property SystemTrayItem modelData

            Image {
                id: image
                anchors.fill: parent
                source: trayItemWrapper.modelData.icon ?? ""
                fillMode: Image.PreserveAspectFit
                visible: false
            }

            Desaturate {
                anchors.fill: image
                source: image
                desaturation: 1
            }

            QsMenuAnchor {
                id: menuAnchor
                anchor.window: panelWindow 
                anchor.item: trayItemWrapper
                menu: trayItemWrapper.modelData.menu
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: (event) => {
                    if (event.button === Qt.RightButton || trayItemWrapper.modelData.onlyMenu) {
                        menuAnchor.open();
                    } else {
                        trayItemWrapper.modelData.activate();
                    }
                }
            }
        }
    }
}