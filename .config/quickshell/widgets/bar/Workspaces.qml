import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../."
import "../."

RowLayout {
    id: root
    spacing: 12

    Repeater {
        model: {
            let monitors = Array.from(Hyprland.monitors.values);
            monitors.sort((a, b) => a.x - b.x);
            return monitors;
        }

        delegate: Rectangle {
            id: monitorPill
            required property var modelData

            color: Theme.base
            radius: height / 2
            Layout.preferredHeight: Theme.wsPillHeight + 8
            Layout.preferredWidth: monitorLayout.implicitWidth + 12

            RowLayout {
                id: monitorLayout
                anchors.centerIn: parent
                spacing: 4

                Repeater {
                    model: {
                        let workspaces = Hyprland.workspaces.values;
                        return workspaces.filter(ws => ws.monitor && ws.monitor.name === monitorPill.modelData.name);
                    }

                    delegate: Rectangle {
                        id: pill
                        required property var modelData

                        readonly property bool isActive: modelData.active

                        Layout.preferredWidth: isActive ? textItem.implicitWidth + Theme.wsPillHeight : Theme.wsPillHeight
                        Layout.preferredHeight: Theme.wsPillHeight
                        
                        Behavior on Layout.preferredWidth {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        color: isActive ? Theme.active : Theme.inactive
                        radius: height / 2

                        Text {
                            id: textItem
                            anchors.centerIn: parent
                            text: modelData.name !== "" ? modelData.name : modelData.id
                            color: Theme.textDark
                            font.pixelSize: Theme.fontSize
                            font.bold: true
                            
                            opacity: pill.isActive ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation { duration: 150 }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (modelData.name) {
                                    Hyprland.dispatch("hl.dsp.focus({workspace='" + modelData.name + "'})");
                                } else {
                                    Hyprland.dispatch("hl.dsp.focus({workspace='" + modelData.id + "'})");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}