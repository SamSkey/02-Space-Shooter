extends Label

func update_score(points_score: int):
	var score = int(text)
	score += points_score
	text = str(score)

func reset():
	text = str(0)
