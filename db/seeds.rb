# Создание команд
team1 = Team.create(name: "Team 1")
team2 = Team.create(name: "Team 2")

# Создание игроков
player1 = Player.create(name: "Player 1", team: team1)
player2 = Player.create(name: "Player 2", team: team1)
player3 = Player.create(name: "Player 3", team: team1)

player4 = Player.create(name: "Player 4", team: team2)
player5 = Player.create(name: "Player 5", team: team2)
player6 = Player.create(name: "Player 6", team: team2)

# Создаем матчи
match1 = Match.create(date: Date.today)
match2 = Match.create(date: Date.today - 1)
match3 = Match.create(date: Date.today - 2)

# Создание показателей
metric1 = Metric.create(name: "Distance covered")
metric2 = Metric.create(name: "Pass accuracy")

# Привязка показателей к матчам
match1.metrics << metric1
match1.metrics << metric2

match2.metrics << metric1
match2.metrics << metric2

match3.metrics << metric1

# Привязываем команды к матчам через связующую таблицу
team1.matches << match1
team1.matches << match2
team2.matches << match1
team2.matches << match3

# Привязка показателей к игрокам
player1.metrics << metric1
player1.metrics << metric2

player2.metrics << metric2

player3.metrics << metric1

player4.metrics << metric1
player4.metrics << metric2

player5.metrics << metric2

player6.metrics << metric1
