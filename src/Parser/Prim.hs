module Parser.Prim where

import           Control.Applicative     hiding ( (<|>)
                                                , many
                                                )

import           Text.Parsec

import           Parser.Types

-----------------------------
idAndClasses :: Parser (Attr, Attr)
idAndClasses = idClasses <|> classesIdClasses
-- >>> idAndClasses >>> ".class1.class2#id.class3.class4"
-- Right (("id",["id"]),("class",["class1","class2","class3","class4"]))
--

--                   id    class
idClasses :: Parser (Attr, Attr)
idClasses = liftA2 (\i -> (i, ) . ("class", )) idP classesP

--                          id    class
classesIdClasses :: Parser (Attr, Attr)
classesIdClasses =
  liftA3 (\cs i -> (i, ) . ("class", ) . (cs <>)) classesP idP classesP

--------------------------
tagP :: Parser String
tagP = tagString <|> pure mempty

idP :: Parser Attr
idP = char '#' *> (("id", ) . (: []) <$> idString)

classP :: Parser String
classP = char '.' *> classString

--------------------------

tagString :: Parser String
tagString = many1 alphaNum

idString :: Parser String
idString = liftA2 (:) letter (many alphaNum)

classString :: Parser String
classString = many1 $ choice [alphaNum, oneOf "_-"]

------------------------------

classesP :: Parser [String]
classesP = char '.' *> sepBy1 classString (char '.')
