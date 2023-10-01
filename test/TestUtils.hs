module TestUtils where

import           Test.Hspec

import           Parser.Types
import           Parser.Utils

runTests :: (Show a, Eq a) => Parser a -> [(String, a)] -> SpecWith ()
runTests p = mapM_ (runTest p)

runTest :: (Show a, Eq a) => Parser a -> (String, a) -> SpecWith ()
runTest p (input, correctValue) = do
  it (input <> " == " <> show correctValue) $ do
    (p >>> input) `shouldBe` Right correctValue
