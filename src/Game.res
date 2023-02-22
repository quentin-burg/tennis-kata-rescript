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

let other_player = player =>
  switch player {
  | Player_one => Player_two
  | Player_two => Player_one
  }

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

let incrementPoint = point => {
  switch point {
  | Love => Some(Fifteen)
  | Fifteen => Some(Thirty)
  | Thirty => None
  }
}

let score_when_forty = (currentForty, winner) => {
  switch currentForty {
  | Forty(fortydata) =>
    fortydata.player === winner
      ? Game(winner)
      : switch incrementPoint(fortydata.other_point) {
        | Some(a) => Forty({...fortydata, other_point: a})
        | None => Deuce
        }

  | score => score
  }
}
