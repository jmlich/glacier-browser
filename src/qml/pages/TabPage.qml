import QtQuick
import Nemo.Controls

Page {

    property variant repeaterObject;

    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Tabs")
        showBackButton: tabModel.rowCount === 0; // user should always choose the page he want to go
//        tools: [
//            ToolButton {
//                iconSource: "image://theme/plus"
//                onClicked: {
//                    console.log("add empty tab")
//                    tabModel.addTab("https://nemomobile.net");
//                    if (stackView) {
//                        stackView.pop()
//                    }

//                }
//            }
//        ]
    }


    ListView{
        id: tabsView
        model: tabModel

        width: (parent != null) ? parent.width : 0
        height: parent.height

        delegate: ListViewItemWithActions {
            label: ((repeaterObject !== null) && (repeaterObject.itemAt(index) !== null)) ? repeaterObject.itemAt(index).title : ""
            description: url
            showNext: true
            icon: ((repeaterObject !== null) && (repeaterObject.itemAt(index) !== null)) ? repeaterObject.itemAt(index).icon : ""
            iconVisible: true
            iconColorized: false;
            width: (parent != null) ? parent.width : 0;
            height: Theme.itemHeightLarge

            onClicked: {
                tabModel.currentIndex = index

                if (stackView) {
                    stackView.pop()
                }

            }

            actions:[
                ActionButton {
                    iconSource: "image://theme/times"
                    onClicked: {
                        tabModel.removeTab(index)
                    }
                }
            ]

        }
    }

    Connections {
        target: tabModel;
        onRowCountChanged: {
            if (tabModel.rowCount === 0) {
                if (stackView) {
                    stackView.pop()
                }

            }
        }
    }

}
