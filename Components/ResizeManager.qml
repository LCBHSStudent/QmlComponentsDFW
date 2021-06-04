import QtQuick 2.14

Item {
	id: resizer

	property var resizeSource: parent

	property rect minimumGeometry: Qt.rect(0, 0, 0, 0)
	property rect maximumGeometry: Qt.rect(16777215, 16777215, 16777215, 16777215) // from QtWidgets

	property int enabledEdges: e_ALL_EDGES
	property int enabledCorners: e_ALL_CORNERS

	readonly property int e_NO_EDGES: 0x00
	readonly property int e_TOP_EDGE: 0x01
	readonly property int e_BOTTOM_EDGE: 0x02
	readonly property int e_LEFT_EDGE: 0x04
	readonly property int e_RIGHT_EDGE: 0x08
	readonly property int e_ALL_EDGES: 0x0f

	readonly property int e_NO_CORNERS: 0x00
	readonly property int e_TOP_LEFT_CORNER: 0x01
	readonly property int e_TOP_RIGHT_CORNER: 0x02
	readonly property int e_BOTTOM_LEFT_CORNER: 0x04
	readonly property int e_BOTTOM_RIGHT_CORNER: 0x08
	readonly property int e_ALL_CORNERS: 0x0f

	property var __original_point: { "x": 0, "y": 0 }
	property rect __original_geometry: Qt.rect(0, 0, 0, 0)
	property real __grip_size: 3

	signal resize(var new_x, var new_y, var new_width, var new_height)

	function __prepareResize(area, mouse) {
		__original_point = area.mapToItem(null, mouse.x, mouse.y);
		__original_geometry = Qt.rect(resizeSource.x, resizeSource.y, resizeSource.width, resizeSource.height);
	}

	function __newX(delta) {
		var new_x = Math.max(__original_geometry.x + delta,
							 __original_geometry.x + __original_geometry.width - maximumGeometry.width);
		new_x = Math.min(new_x, __original_geometry.x + __original_geometry.width - minimumGeometry.width);
		new_x = Math.max(new_x, minimumGeometry.x);

		return new_x;
	}

	function __newY(delta) {
		var new_y = Math.max(__original_geometry.y + delta,
							 __original_geometry.y + __original_geometry.height - maximumGeometry.height);
		new_y = Math.min(new_y, __original_geometry.y + __original_geometry.height - minimumGeometry.height);
		new_y = Math.max(new_y, minimumGeometry.y);

		return new_y;
	}

	function __newWidth(delta) {
		var new_width = Math.max(minimumGeometry.width, __original_geometry.width + delta);
		new_width = Math.min(new_width, maximumGeometry.width);

		return new_width;
	}

	function __newHeight(delta) {
		var new_height = Math.max(minimumGeometry.height, __original_geometry.height + delta);
		new_height = Math.min(new_height, maximumGeometry.height);

		return new_height;
	}

	x: parent === resizeSource ? 0 : resizeSource.x
	y: parent === resizeSource ? 0 : resizeSource.y
	z: 1

	width: resizeSource.width
	height: resizeSource.height

	MouseArea {
		id: left_edge_area

		anchors {
			left: parent.left
			top: parent.top
			bottom: parent.bottom

			topMargin: __grip_size
			bottomMargin: __grip_size
		}

		width: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeHorCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledEdges & e_LEFT_EDGE

		onPressed: __prepareResize(left_edge_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = left_edge_area.mapToItem(null, mouse.x, mouse.y);
				var x_delta = global_point.x - __original_point.x;

				var new_x = __newX(x_delta);
				var new_width = __original_geometry.x + __original_geometry.width - new_x;
				var new_y = __original_geometry.y;
				var new_height = __original_geometry.height;

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: right_edge_area

		anchors {
			right: parent.right
			top: parent.top
			bottom: parent.bottom

			topMargin: __grip_size
			bottomMargin: __grip_size
		}

		width: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeHorCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledEdges & e_RIGHT_EDGE

		onPressed: __prepareResize(right_edge_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = right_edge_area.mapToItem(null, mouse.x, mouse.y);
				var x_delta = global_point.x - __original_point.x;

				var new_x = __original_geometry.x;
				var new_width = __newWidth(x_delta);
				var new_y = __original_geometry.y;
				var new_height = __original_geometry.height;

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: top_edge_area

		anchors {
			left: parent.left
			right: parent.right
			top: parent.top

			leftMargin: __grip_size
			rightMargin: __grip_size
		}

		height: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeVerCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledEdges & e_TOP_EDGE

		onPressed: __prepareResize(top_edge_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = top_edge_area.mapToItem(null, mouse.x, mouse.y);
				var y_delta = global_point.y - __original_point.y;

				var new_x = __original_geometry.x;
				var new_width = __original_geometry.width;
				var new_y = __newY(y_delta);
				var new_height = __original_geometry.y + __original_geometry.height - new_y;

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: bottom_edge_area

		anchors {
			left: parent.left
			right: parent.right
			bottom: parent.bottom

			leftMargin: __grip_size
			rightMargin: __grip_size
		}

		height: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeVerCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledEdges & e_BOTTOM_EDGE

		onPressed: __prepareResize(bottom_edge_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = bottom_edge_area.mapToItem(null, mouse.x, mouse.y);
				var y_delta = global_point.y - __original_point.y;

				var new_x = __original_geometry.x;
				var new_width = __original_geometry.width;
				var new_y = __original_geometry.y;
				var new_height = __newHeight(y_delta);

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: top_left_corner_area

		anchors {
			left: parent.left
			top: parent.top
		}

		width: __grip_size
		height: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeFDiagCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledCorners & e_TOP_LEFT_CORNER

		onPressed: __prepareResize(top_left_corner_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = top_left_corner_area.mapToItem(null, mouse.x, mouse.y);
				var x_delta = global_point.x - __original_point.x;
				var y_delta = global_point.y - __original_point.y;

				var new_x = __newX(x_delta);
				var new_width = __original_geometry.x + __original_geometry.width - new_x;
				var new_y = __newY(y_delta);
				var new_height = __original_geometry.y + __original_geometry.height - new_y;

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: top_right_corner_area

		anchors {
			right: parent.right
			top: parent.top
		}

		width: __grip_size
		height: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeBDiagCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledCorners & e_TOP_RIGHT_CORNER

		onPressed: __prepareResize(top_right_corner_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = top_right_corner_area.mapToItem(null, mouse.x, mouse.y);
				var x_delta = global_point.x - __original_point.x;
				var y_delta = global_point.y - __original_point.y;

				var new_x = __original_geometry.x;
				var new_width = __newWidth(x_delta);
				var new_y = __newY(y_delta);
				var new_height = __original_geometry.y + __original_geometry.height - new_y;

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: bottom_left_corner_area

		anchors {
			left: parent.left
			bottom: parent.bottom
		}

		width: __grip_size
		height: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeBDiagCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledCorners & e_BOTTOM_LEFT_CORNER

		onPressed: __prepareResize(bottom_left_corner_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = bottom_left_corner_area.mapToItem(null, mouse.x, mouse.y);
				var x_delta = global_point.x - __original_point.x;
				var y_delta = global_point.y - __original_point.y;

				var new_x = __newX(x_delta);
				var new_width = __original_geometry.x + __original_geometry.width - new_x;
				var new_y = __original_geometry.y;
				var new_height = __newHeight(y_delta);

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}

	MouseArea {
		id: bottom_right_corner_area

		anchors {
			right: parent.right
			bottom: parent.bottom
		}

		width: __grip_size
		height: __grip_size

		acceptedButtons: Qt.LeftButton
		cursorShape: enabled ? Qt.SizeFDiagCursor : Qt.ArrowCursor
		hoverEnabled: enabled

		enabled: resizer.enabledCorners & e_BOTTOM_RIGHT_CORNER

		onPressed: __prepareResize(bottom_right_corner_area, mouse)

		onPositionChanged: {
			if (pressedButtons === Qt.LeftButton) {
				var global_point = bottom_right_corner_area.mapToItem(null, mouse.x, mouse.y);
				var x_delta = global_point.x - __original_point.x;
				var y_delta = global_point.y - __original_point.y;

				var new_x = __original_geometry.x;
				var new_width = __newWidth(x_delta);
				var new_y = __original_geometry.y;
				var new_height = __newHeight(y_delta);

				resizer.resize(new_x, new_y, new_width, new_height);
			}
		}
	}
}