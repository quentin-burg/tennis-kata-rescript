open RescriptMocha
open Mocha
open Game
open Assert

open FastCheck
open Arbitrary
open Combinators

open Property
open Sync

let playerOneArb = constant(Player_one)
let playerTwoArb = constant(Player_two)
let playerArb = () => oneOf([playerOneArb, playerTwoArb])
let loveArb = constant(Love)
let fifteenArb = constant(Fifteen)
let thirtyArb = constant(Thirty)
let pointArb = () => oneOf([loveArb, fifteenArb, thirtyArb])
describe("Tooling functions", () => {
  it("Given PlayerOne when stringOfPlayer", () => stringOfPlayer(Player_one)->equal("Player 1"))
  it("Given PlayerTwo when stringOfPlayer", () => stringOfPlayer(Player_two)->equal("Player 2"))
})

describe("Transitions functions", () => {
  it("Given deuce, score is advantage to winner", () => {
    assertProperty1(playerArb(), winner => score_when_deuce(winner) == Advantage(winner))
  })
  it("Given advantage when advantagedPlayer wins, score is Game avantagedPlayer", () => {
    assertProperty1(playerArb(), winner => score_when_advantage(winner, winner) == Game(winner))
  })
  it("Given advantage when otherPlayer wins, score is Deuce", () => {
    assertProperty2(
      playerArb(),
      playerArb(),
      (winner, other) => {
        pre(winner != other)
        score_when_advantage(winner, other) == Deuce
      },
    )
  })
  it("Given a player at 40 when the same player wins, score is Game for this player", () => {
    assertProperty2(
      playerArb(),
      pointArb(),
      (winner, otherPoint) => {
        let currentForty = Forty({player: winner, other_point: otherPoint})
        score_when_forty(currentForty, winner) == Game(winner)
      },
    )
  })
  it("Given player at 40 and other at 30 when other wins, score is Deuce", () => {
    assertProperty2(
      playerArb(),
      pointArb(),
      (winner, otherPoint) => {
        pre(otherPoint == Thirty)
        let currentForty = Forty({player: other_player(winner), other_point: otherPoint})
        score_when_forty(currentForty, winner) == Deuce
      },
    )
  })
  it("Given player at 40 and other at 15 when other wins, score is 40 - 30", () => {
    assertProperty2(
      playerArb(),
      pointArb(),
      (winner, otherPoint) => {
        pre(otherPoint == Fifteen)
        let currentForty = Forty({player: other_player(winner), other_point: otherPoint})
        score_when_forty(currentForty, winner) ==
          Forty({player: other_player(winner), other_point: Thirty})
      },
    )
  })
  it("Given players at 0 or 15 points score kind is still POINTS", () => {
    ()
  })
  it("Given one player at 30 and win, score kind is forty", () => {()})
})
