pragma Singleton
import QtQuick

QtObject {
    readonly property color base: '#aa272727'
    readonly property color good: "#24b535"
    readonly property color bad: "#b5242e"
    readonly property color warn: "#f39c12"
    readonly property color text: "#f2f2f2"
    readonly property color textDark: "#1a1b26"
    readonly property color accent: "#89dde8"
    readonly property color transparent: "#00000000"
    readonly property color inactive: "#3a3a3a"
    readonly property color active: "#ffffff"


    readonly property int wsPillHeight: 20
    readonly property int barHeight: 36
    readonly property int barMargin: 10
    readonly property int containerPadding: 12
    readonly property int containerRadius: (barHeight + containerPadding * 2) / 2
    readonly property int fontSize: 20
    readonly property real iconFac: 1
}