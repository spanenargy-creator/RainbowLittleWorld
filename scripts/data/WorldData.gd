class_name WorldData
extends Resource

@export var id: int
@export var title: String
@export var emoji: String
@export var color: Color
@export var levels: int = 5

static func all_worlds() -> Array[WorldData]:
    var names = [
        ["خانه رنگین‌کمان","🏠",Color("#ff8fc7")],
        ["باغ گل‌ها","🌸",Color("#ffd166")],
        ["جنگل پروانه‌ها","🦋",Color("#73d6b0")],
        ["سرزمین حیوانات","🐰",Color("#82cfff")],
        ["شهر اسباب‌بازی‌ها","🧸",Color("#b69cff")],
        ["جزیره آب‌نبات","🍭",Color("#ff9f80")],
        ["قلعه پری‌ها","🧚",Color("#e7a6ff")],
        ["دنیای زیر آب","🐠",Color("#62c8ee")],
        ["سرزمین ابرها","☁️",Color("#9fb8ff")],
        ["قلعه رنگین‌کمان","🌈",Color("#ff79b7")]
    ]
    var out:Array[WorldData] = []
    for i in names.size():
        var w := WorldData.new()
        w.id=i; w.title=names[i][0]; w.emoji=names[i][1]; w.color=names[i][2]
        out.append(w)
    return out
