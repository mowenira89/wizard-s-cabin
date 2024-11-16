class_name InvPreview extends TextureRect

var item:Item

func create_preview(i:Item):
	item=i
	texture=load("res://Assets/Art/Items/"+item.data_name+".png")
	z_index=2
	mouse_filter=Control.MOUSE_FILTER_IGNORE
