import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

MouseArea {
    id: delegate
    property alias name: txtName.text
    property alias number: txtNumber.text
    property bool held: false
    height: content.height

    drag.target: held ? content : undefined
    drag.axis: Drag.YAxis

    onPressAndHold: held = true
    onReleased: held = false

    Rectangle {
        id: content
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        width: delegate.width; height: recInfo.implicitHeight + 4

        color: delegate.held ? "lightsteelblue" : "white"
        Behavior on color { ColorAnimation { duration: 100 } }

        radius: 2
        Drag.active: delegate.held
        Drag.source: delegate
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: height / 2
        states: State {
            when: delegate.held

            ParentChange { target: content }
            AnchorChanges {
                target: content
                anchors { horizontalCenter: undefined; verticalCenter: undefined }
            }
        }

        Rectangle{
            id: root
            anchors.fill: parent
            color: "red"
            radius: 10

            MouseArea {
                anchors.fill: parent
    //            hoverEnabled: true
                onPressed: delegate.ListView.view.currentIndex = index
                onPressAndHold:{
                    imgMove.visible = true
                    root.color = "red"
                    reorderRequest()
                }
                onReleased: {
                    imgMove.visible = false
                    root.color = "transparent"
                }
            }

            Image {
                id: imgMove
                visible: false
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
                            visible: true
                            font.pixelSize: 20
                            font.weight: Font.Black
                            font.family: "Helvetica"
                            MouseArea {
                                anchors.fill: parent
                                onPressed: {
                                    delegate.ListView.view.currentIndex = index
                                }
                                onDoubleClicked: {
                                    delegate.ListView.view.currentIndex = index
                                    isViewMode = false
//                                    doubleClick(true)
                                }
                                onPressAndHold:{
                                    imgMove.visible = true
                                    root.color = "red"
//                                    reorderRequest()
                                }
                                onReleased: {
                                    imgMove.visible = false
                                    root.color = "transparent"
                                }
                            }
                        }

                        TextField {
                            id: edtName
                            visible: false
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
                            visible: true
                            font.pixelSize: 15
                            MouseArea {
                                anchors.fill: parent
                                onPressed: {
                                    delegate.ListView.view.currentIndex = index
                                }
                                onDoubleClicked: {
                                    delegate.ListView.view.currentIndex = index

                                    isViewMode = false
                                    doubleClick(false)
                                }
                                onPressAndHold:{
                                    imgMove.visible = true
                                    root.color = "red"
                                    reorderRequest()
                                }
                                onReleased: {
                                    imgMove.visible = false
                                    root.color = "transparent"
                                }
                            }
                        }

                        TextField {
                            id: edtNumber
                            visible: false
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
                    source: "qrc:/resource/modify.png"
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
        }

        Rectangle {
            id: recUnderLine
            height: 2
            anchors.left: delegate.left
            anchors.right: delegate.right
            anchors.bottom: delegate.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            border.color: "gray"
            border.width: 1
        }
    }
    DropArea {
        anchors { fill: parent; margins: 10 }

        onEntered: {
            delegate.ListView.view.items.move(
                        drag.source.DelegateModel.itemsIndex,
                        delegate.DelegateModel.itemsIndex)
        }
    }
}
