import QtQuick
import Nemo.Controls

Page {

    property string addUrl: ""
    property string addTitle: ""
    property string addIcon: ""
    property variant bookmarksModel

    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Bookmarks")
        showBackButton: true
        tools: [
            ToolButton {
                iconSource: "image://theme/plus"
                onClicked: {
                    console.log("add bookmark: " + addUrl + " " + bookmarksModel + " " + addIcon)
                    bookmarksModel.insertToBookmarks(addUrl, addTitle, addIcon)
                }
            }
        ]
    }


    ListView{
        id: bookmarksView
        model: bookmarksModel

        width: parent.width
        height: parent.height

        delegate: ListViewItemWithActions {
            label: title
            description: url
            showNext: true
            iconVisible: true
            iconColorized: false
            icon: favicon
            width: (parent != null) ? parent.width : 0
            height: Theme.itemHeightLarge

            onClicked: {
                console.log("Bookmarks - load web page: " + title + " " + url);

//                if (tabModel.rowCount === 0) {
                    tabModel.addTab(url)
//                } else {
//                    tabModel.changeTab(tabModel.currentIndex, url)
//                }

                if (stackView) {
                    stackView.pop()
                }

            }

            actions:[
                ActionButton {
                    iconSource: "image://theme/times"
                    onClicked: {
                        bookmarksModel.removeFromBookmarks(url)
                    }
                }
            ]

        }
    }

}
