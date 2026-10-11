import QtQuick
import Quickshell
import "../../."
import "../."

NormalText {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "dd.MM  hh:mm")
    font.bold: true
}