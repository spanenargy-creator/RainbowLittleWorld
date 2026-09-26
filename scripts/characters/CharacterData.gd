class_name CharacterData
extends Resource

@export var id: int
@export var name_fa: String
@export var description: String
@export var accent: Color
@export var portrait_path: String

static func all_characters() -> Array[CharacterData]:
    var raw = [
        ["رها","عاشق طبیعت و گل‌ها",Color("#ff72b6"),""],
        ["نیلا","جادوگر کوچولوی مهربان",Color("#8d79ff"),""],
        ["آوا","دوست حیوانات و پروانه‌ها",Color("#55cfa0"),""],
        ["هانا","ماجراجوی شجاع",Color("#ff9c62"),""],
        ["مائده","دوست کوچولوی رنگین‌کمان",Color("#ff78b7"),"res://assets/art/characters/Maede.png"]
    ]
    var out:Array[CharacterData]=[]
    for i in raw.size():
        var c:=CharacterData.new()
        c.id=i
        c.name_fa=raw[i][0]
        c.description=raw[i][1]
        c.accent=raw[i][2]
        c.portrait_path=raw[i][3]
        out.append(c)
    return out
