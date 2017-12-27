import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

FocusScope {
    id: delegate
    property alias name: txtName.text
    property alias number: txtNumber.text
    property bool isViewMode: true
    property bool held: false

    signal moveFocus(int c_index)
    signal editClicked(string c_name, string c_number)
    signal deleteClicked()
    signal reorderRequest()

    focus: true
    Rectangle{
        id: root
        anchors.fill: parent
        color: held ? "red" : "transparent"
        radius: 10

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: delegate.ListView.view.currentIndex = index
            onPressAndHold: held = true
            onReleased: held = false
        }

        Image {
            id: imgMove
            visible: held
            anchors.margins: 15
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: height
            source: "qrc:/resource/reorder.png"
        }


        RowLayout {
            anchors.top: parent.top
            anchors.bottom: recUnderLine.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin:  imgMove.visible ? (imgMove.width + 20) : 20
            Rectangle {
                id: recInfo
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: btnEdit.left
                color: "transparent"

                Column {
                    id: colContent
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: txtName
                        visible: isViewMode
                        font.pixelSize: 20
                        font.weight: Font.Black
                        font.family: "Helvetica"
                        MouseArea {
                            anchors.fill: parent
                            onPressed: delegate.ListView.view.currentIndex = index
                            onDoubleClicked: {
                                delegate.ListView.view.currentIndex = index
                                isViewMode = false
                                doubleClick(true)
                            }
                            onPressAndHold:{
                                held = true
                                reorderRequest()
                            }
                            onReleased: held = false
                        }
                    }

                    TextField {
                        id: edtName
                        visible: !txtName.visible
                        text: txtName.text
                        font.pixelSize: 20
                        placeholderText: "Name"
                        Keys.onReturnPressed: {
                            isViewMode = true
                            switchModifyMode()
                        }
                    }

                    Text {
                        id: txtNumber
                        visible: isViewMode
                        font.pixelSize: 15
                        MouseArea {
                            anchors.fill: parent
                            onPressed: delegate.ListView.view.currentIndex = index
                            onDoubleClicked: {
                                delegate.ListView.view.currentIndex = index
                                isViewMode = false
                                doubleClick(false)
                            }
                            onPressAndHold:{
                                held = true
                                reorderRequest()
                            }
                            onReleased: held = false
                        }
                    }

                    TextField {
                        id: edtNumber
                        visible: !txtNumber.visible
                        text: txtNumber.text
                        font.pixelSize: 15
                        placeholderText: "Number"
                        Keys.onReturnPressed: {
                            isViewMode = true
                            switchModifyMode()
                        }
                    }
                }
            }

            Image {
                id: btnEdit
                source: isViewMode ? "qrc:/resource/modify.png" : "qrc:/resource/save.png"
                anchors.right: btnDelete.left
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                focus: true
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        delegate.ListView.view.currentIndex = index
                        console.debug("Modify");
                        isViewMode = !isViewMode
                        switchModifyMode()
                    }
                }
            }

            Image {
                id: btnDelete
                source: "qrc:/resource/trash.png"
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                focus: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        delegate.ListView.view.currentIndex = index
                        console.debug("Deleted")
                        deleteClicked()
                    }
                }
            }
        }

        Rectangle {
            id: recUnderLine
            height: 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            border.color: "gray"
            border.width: 1
        }
    }

    function switchModifyMode() {
        if(isViewMode) {
            txtName.text = edtName.text
            txtNumber.text = edtNumber.text
            editClicked(name, number)
        }
        else {
            edtName.text = txtName.text
            edtNumber.text = txtNumber.text
        }
    }

    function doubleClick(element) {
        edtName.visible = element
        edtNumber.visible = !edtName.visible
        txtName.visible = !edtName.visible
        txtNumber.visible = !edtNumber.visible
    }
}
