tool
extends WindowDialog


onready var _item_list = get_node("ItemList")

var _analyzer = null
var _count_labels = {}


func set_analyzer(analyzer):
	if _analyzer == analyzer:
		return
	
	if _analyzer != null:
		_analyzer.disconnect("scan_completed", self, "_on_stats_updated")
	
	_analyzer = analyzer
	
	if _analyzer != null:
		_analyzer.connect("scan_completed", self, "_on_stats_updated")
		
		# We can't assume the analyzer is processing or not,
		# so in case it has already finished, we need to refresh
		refresh()


func _on_stats_updated():
	refresh()


func refresh():
	if _analyzer == null:
		print("ERROR: can't refresh, analyzer not set")
		return
	
	_item_list.clear()
	
	var data = _analyzer.get_data()
	
	for name in data:
		var v = data[name]
		if typeof(v) == TYPE_DICTIONARY:
			for k in v:
				_item_list.add_item((name + ": " + str(k)).capitalize())
				_item_list.add_item(str(v[k]))
		else:
			_item_list.add_item(name.capitalize())
			_item_list.add_item(str(data[name]))
		