extends PanelContainer
class_name Slot

@export var slotItemResource: Item = null


func set_item(item_resource: Item) -> void:
	slotItemResource = item_resource
	%TextureRect.texture = slotItemResource.texture
	%Label.text = str(slotItemResource.quantity)

func _get_drag_data(_at_position):
	if not slotItemResource:
		return
	
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = %TextureRect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(49, 49)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	
	return self

func _can_drop_data(_at_position, _data):
	return _data is Slot

func _drop_data(_at_position, data):
	if slotItemResource == null:
		set_item(data.slotItemResource)
		data.set_data_empty()
	else:
		var temp := slotItemResource
		set_item(data.slotItemResource)
		data.set_item(temp)


func set_data_empty() -> void:
	%TextureRect.texture = null
	slotItemResource = null
	%Label.text = ""
