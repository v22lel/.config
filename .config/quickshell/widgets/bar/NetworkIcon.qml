import QtQuick
import Quickshell
import Quickshell.Networking
import "../../."
import "../."
import "bar"

StatusIcon {
    id: root

    // "ethernet" | "wifi" | "disconnected"
    readonly property string networkType: {
        for (let i = 0; i < Networking.devices.length; i++) {
            let dev = Networking.devices[i];
            
            if (dev.type === DeviceType.Wired) {
                return "ethernet";
            }
            if (dev.type === DeviceType.Wifi && dev.connected) {
                return "wifi";
            }
        }

        if (Networking.connectivity === NetworkConnectivity.Full) {
            return "ethernet";
        }

        return "disconnected";
    }

    readonly property bool isConnected: Networking.connectivity === NetworkConnectivity.Full 
                                     || Networking.connectivity === NetworkConnectivity.Limited

    property real strength: 1

    icon: {
        if (!isConnected) {
            return networkType === "network-offline-symbolic"
        }

        if (networkType === "disconnected") {
            return "network-error-symbolic";
        }

        if (networkType === "ethernet") {
            return "network-wired-symbolic";
        }

        return "network-wireless-symbolic"
    }
}