import QtQuick
import Quickshell
import Quickshell.Wayland


PanelWindow {
    id: wallpaper_clock

    WlrLayershell.layer: WlrLayer.Background
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Item {
        width: 300
        height: 300
        
        anchors.centerIn: parent
        transform: Translate { y: -400 }

        Item {
            id: clockRoot
            width: 300
            height: 300

            anchors.fill: parent

            property color clockColor: "black"

            property real rimWidth: 4
            property bool showRim: true

            property real hourHandWidth: 6
            property real minuteHandWidth: 4
            property real secondHandWidth: 2

            property real hourHandLength: 0.28
            property real minuteHandLength: 0.40
            property real secondHandLength: 0.44

            property bool showSecondHand: true
            property real centerPinSize: 5
            property real tickWidthMajor: 4
            property real tickWidthMinor: 2

            SystemClock {
                id: time
                precision: clockRoot.showSecondHand ? SystemClock.Seconds : SystemClock.Minutes
            }

            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: "transparent"
                border.color: clockRoot.clockColor
                border.width: clockRoot.rimWidth
                visible: clockRoot.showRim
            }

            Repeater {
                model: 12
                Item {
                    anchors.centerIn: parent
                    width: clockRoot.width
                    height: clockRoot.height
                    rotation: index * 30

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: index % 3 === 0 ? clockRoot.tickWidthMajor : clockRoot.tickWidthMinor
                        height: index % 3 === 0 ? 16 : 10
                        color: clockRoot.clockColor
                    }
                }
            }

            Rectangle {
                id: hourHand
                width: clockRoot.hourHandWidth
                height: clockRoot.height * clockRoot.hourHandLength
                color: clockRoot.clockColor
                radius: width / 2
                
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.verticalCenter

                transform: Rotation {
                    origin.x: hourHand.width / 2
                    origin.y: hourHand.height
                    angle: ((time.date.getHours() % 12) * 30) + (time.date.getMinutes() * 0.5)
                }
            }

            Rectangle {
                id: minuteHand
                width: clockRoot.minuteHandWidth
                height: clockRoot.height * clockRoot.minuteHandLength
                color: clockRoot.clockColor
                radius: width / 2
                
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.verticalCenter

                transform: Rotation {
                    origin.x: minuteHand.width / 2
                    origin.y: minuteHand.height
                    angle: (time.date.getMinutes() * 6) + (time.date.getSeconds() * 0.1)
                }
            }

            Rectangle {
                id: secondHand
                width: clockRoot.secondHandWidth
                height: clockRoot.height * clockRoot.secondHandLength
                color: clockRoot.clockColor
                visible: clockRoot.showSecondHand
                
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.verticalCenter

                transform: Rotation {
                    origin.x: secondHand.width / 2
                    origin.y: secondHand.height
                    angle: time.date.getSeconds() * 6
                }
            }

            Rectangle {
                anchors.centerIn: parent
                width: clockRoot.centerPinSize
                height: clockRoot.centerPinSize
                radius: width / 2
                color: clockRoot.clockColor
            }
        }
    }
}