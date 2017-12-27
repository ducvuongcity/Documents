import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2

Window {
    id: root
    width: Screen.width/5
    height: Screen.height/2
    visible: true

    property bool isConnected: false

    Connections {
        target: Client
        onSgn_revReply:
            toast.show(reply, 2000)

        onSgn_updateStatus: {
            txtConnectStatus.text = "Status: " + status
            isConnected = (status == "Disconnected") ? false : true
        }
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

            Text {
                id: txtConnectStatus
                anchors.left: txtIP.left
                text: qsTr("Disconnect")
            }

            TextField {
                id: txtIP
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width / 2
                placeholderText: "HOST IP"
                text: "127.0.0.1"
                Keys.onReturnPressed: btnSend.clicked()
            }

            TextField {
                id: txtPORT
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width / 2
                placeholderText: "PORT"
                text: "8888"
                Keys.onReturnPressed: btnSend.clicked()
            }

            Button {
                id: btnConnect
                anchors.horizontalCenter: parent.horizontalCenter
                text: isConnected ? "Disconnect" : "Connect"
                onClicked: {
                    if(!isConnected)
                        Client.connectToServer(txtIP.text, txtPORT.text)
                    else
                        Client.disconnectToServer()
                }
            }

            Rectangle {
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width/1.5
                color: "black"
            }



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
                    if(isConnected) {
                        if(txtName.text != "" || txtNumber.text != "") {
                            Client.sendContactToServer(txtName.text, txtNumber.text)
                            txtName.text = ""
                            txtNumber.text = ""
                            toast.show("Sending...", 2000)
                        }
                        else {
                            toast.show("Name or Number null", 2000)
                        }
                    }
                    else {
                        toast.show("Must connect to host before send", 3000)
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
