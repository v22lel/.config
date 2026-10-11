import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import "."
import "../../."
import "../."


RowLayout {
    id: root
    readonly property UPowerDevice battery: UPower.devices.values.find(d => d.type === UPowerDeviceType.Battery)
    readonly property bool isPresent: battery !== null && battery.isPresent
    readonly property real percentage: battery ? battery.percentage : 0

    visible: isPresent

    BatteryIcon {
        percentage: root.percentage
        isCharging: root.battery ? root.battery.state === UPowerDeviceState.Charging : false
    }
}