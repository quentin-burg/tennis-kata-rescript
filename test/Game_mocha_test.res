open RescriptMocha
open Mocha
open Game
open Assert

describe("Tooling functions", () => {
  it("Given PlayerOne when stringOfPlayer", () => stringOfPlayer(Player_one)->equal("Player 1"))
})

// TEST PBT WITH MOCHA
open FastCheck
open Arbitrary
open Property.Sync

// Code under test
let contains = (text, pattern) => text->Js.String2.indexOf(pattern) >= 0

// Properties
describe("properties", () => {
  // string text always contains itself
  it("should always contain itself", () => assertProperty1(string(), text => contains(text, text)))
  // string a + b + c always contains b, whatever the values of a, b and c
  it("should always contain its substrings", () =>
    assertProperty3(string(), string(), string(), (a, b, c) => contains(a ++ b ++ c, b))
  )
})
