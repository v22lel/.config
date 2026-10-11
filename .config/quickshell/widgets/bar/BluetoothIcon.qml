import QtQuick
import Quickshell
import Quickshell.Bluetooth
import "../../."
import "../."

NerdText {
    id: root

    readonly property bool hasAdapter: Bluetooth.adapters.length > 0

    readonly property bool isConnected: {
        if (!hasAdapter) return false;

        for (let i = 0; i < Bluetooth.devices.length; i++) {
            if (Bluetooth.devices[i].connected) {
                return true;
            }
        }
        return false;
    }

    visible: hasAdapter 

    text: isConnected ? "󰂰" : "󰂯"

    transform: Translate { x: 3 }
}