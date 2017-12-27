import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2

Window {
    id: root
    width: Screen.width/5
    height: Screen.height/2
    visible: true

    Connections {
        target: Client1
        onSgn_revReply:
            toast.show(reply, 2000)
    }

    Rectangle {
        anchors.fill: parent
        anchors.centerIn: parent
        color: "transparent"

        Image {
            id: bgr
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/resource/bgr.png"
        }

        Column {
            anchors.fill: parent
            anchors.topMargin: 50
            spacing: 10

            TextField {
                id: txtName
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width / 2
                placeholderText: "Name"
                Keys.onReturnPressed: btnSend.clicked()
            }

            TextField {
                id: txtNumber
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width / 2
                placeholderText: "Number"
                Keys.onReturnPressed: btnSend.clicked()
            }

            Button {
                id: btnSend
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Send"
                onClicked: {
                    if(txtName.text != "" || txtNumber.text != "") {
                        Client1.sendContactToDbus(txtName.text, txtNumber.text)
                        txtName.text = ""
                        txtNumber.text = ""
                        toast.show("Sending...", 2000)
                    }
                    else {
                        toast.show("Name or Number null", 2000)
                    }
                }
            }
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
        text: qsTr("2017 © Vuong Nguyen ™")
        color: "black"
        font.pixelSize: 15
    }

    Toast{
        id: toast
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 50
    }
}
