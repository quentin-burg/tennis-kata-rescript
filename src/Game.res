// Types

type player =
  | Player_one
  | Player_two

type point =
  | Love
  | Fifteen
  | Thirty

type point_data = {
  playerOne: point,
  playerTwo: point,
}

type forty = {
  player: player,
  other_point: point,
}

type score =
  | Points(point_data)
  | Forty(forty)
  | Deuce
  | Advantage(player)
  | Game(player)

// Transitions

let stringOfPlayer = player =>
  switch player {
  | Player_one => "Player 1"
  | Player_two => "Player 2"
  }

let stringOfPoint = point =>
  switch point {
  | Love => "zero"
  | Fifteen => "quinze"
  | Thirty => "trente"
  }

let score_when_deuce = winner => Advantage(winner)

let score_when_advantage = (winner, advantagedPlayer) =>
  winner === advantagedPlayer ? Game(winner) : Deuce

let score_when_forty = (currentForty: forty, winner) => {
  currentForty.player === winner ? Game(winner) : Deuce
}
