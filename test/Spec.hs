import           Test.Hspec

import           Parser

import           TestDatas
import           TestUtils

main :: IO ()
main = hspec $ do
  describe "CssSelectors.element" $ do
    runTests element testElement

  describe "CssSelectors.combinator" $ do
    runTests combinator testCombinator

