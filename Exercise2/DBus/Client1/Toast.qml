import QtQuick 2.3

Item {
    id: toast
    visible: false
    width: txt.width + 50
    height: txt.height + 10

    Timer {
        id: tim
        repeat: false
        onTriggered: toast.visible = false
    }

    Rectangle {
        anchors.fill: parent
        color: "red"
        opacity: 0.5
        radius: 20
    }
    Text {
        id: txt
        anchors.centerIn: parent
        font.pixelSize: 15
        font.bold: true
        color: "white"
    }

    function show(msg, time) {
        if (tim.running)
            tim.stop()
        txt.text = msg
        toast.visible = true
        tim.interval = time
        tim.start()
    }
}

