import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2

Window {
    id: root
    width: Screen.width / 5
    height: Screen.height / 2
    minimumWidth: Screen.width / 5
    minimumHeight: Screen.height / 2
    visible: true

    Connections {
        target: AppModel
        onSgn_requestUpdateListView: {
            lvListContact.highlightMoveDuration = 0
            lvListContact.currentIndex = reloadContactList()
            lvListContact.highlightMoveDuration = 200
        }
    }

    Image {
        id: bgr
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/resource/bgr.png"
    }

    ListView {
        id: lvListContact
        anchors.fill: parent
        anchors.bottomMargin: 100
        model: AppModel.list
        delegate: ContactDelegate {
            anchors.left: parent.left
            anchors.right: parent.right
            width: parent.width
            height: 70
            name: contactName
            number: contactNumber
            onEditClicked: {
                AppModel.modify(index, c_name, c_number)
                lvListContact.highlightMoveDuration = 0
                lvListContact.currentIndex = reloadContactList()

            }
            onDeleteClicked: {
                dlgDelete.open()
            }
        }
        highlight: Rectangle { color: "lightsteelblue"; radius: 10 }
        highlightResizeDuration: 100
        highlightMoveDuration: 300
        focus: true

        Component.onCompleted: {
            lvListContact.highlightMoveDuration = 200
            currentIndex = 10
        }

    }

    Text {
        id: txtSign
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

    Dialog {
        id: dlgDelete
        title: "Warring"
        Text {
            text: "Delete This Contact"
        }
        standardButtons: StandardButton.Cancel | StandardButton.Yes
        onButtonClicked: {
            if (clickedButton === StandardButton.Yes) {
                console.debug(lvListContact.currentIndex)
                AppModel.remove(lvListContact.currentIndex)
                reloadContactList()
                toast.show("Deleted", 2000)
            }
            else {
                console.debug("Cancel")
            }
        }
    }

    function reloadContactList() {
        var indexBackup = lvListContact.currentIndex
        lvListContact.model = AppModel.list
        return indexBackup
    }
}
