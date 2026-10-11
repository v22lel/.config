import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import "."
import "../."
import "../../."

PanelWindow {
    id: bar
    
    anchors {
        top: true
        left: true
        right: true
    }

    height: Theme.barHeight + (Theme.barMargin * 2)
    color: Theme.transparent

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.barMargin
        anchors.rightMargin: Theme.barMargin
        anchors.topMargin: Theme.barMargin
        anchors.bottomMargin: Theme.barMargin
        spacing: Theme.barMargin

        //left
        BarContainer {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            Workspaces {}
        }

        BarContainer {
            anchors.centerIn: parent
            visible: !tray.isEmpty

            Tray { id: tray }
        }

        //right
        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            spacing: Theme.barMargin

            BarContainer {
                spacing: 10

                MicrophoneIcon {}
                AudioIcon {}
            }

            BarContainer {
                spacing: 10

                BluetoothIcon {}
                NetworkIcon {}
                Battery {
                    id: battery
                }
            }

            BarContainer {
                Clock {}
            }
        }
    }
}