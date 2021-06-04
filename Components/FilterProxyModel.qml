import QtQuick 2.12
import QtQml.Models 2.12

DelegateModel {
    id: modelRoot
    onFilterRuleChanged: {
        filter()
    }

    property var filterRule: function(item) {
        return true
    }

    function filter() {
        refilter()
        while (items.count > 0) {
            if (filterRule(items.get(0).model)) {
                items.setGroups(0, 1, "shown")
            } else {
                items.setGroups(0, 1, "hidden")
            }
        }
    }

    function refilter() {
        if (shown.count > 0)
            shown.setGroups(0, shown.count, "items")
        if (hidden.count > 0)
            hidden.setGroups(0, hidden.count, "items")
    }
    filterOnGroup: "shown"

    items.includeByDefault: true
    groups: [
        DelegateModelGroup {
            id: shown
            name: "shown"
        },
        DelegateModelGroup {
            id: hidden
            name: "hidden"
        }
    ]
}