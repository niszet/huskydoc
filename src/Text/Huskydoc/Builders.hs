{-
Copyright (c) 2016 Albert Krewinkel

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.
-}

{-|
Module      :  Text.Huskydoc.Types
Copyright   :  © 2016 Albert Krewinkel
License     :  ISC

Maintainer  :  Albert Krewinkel <tarleb@zeitkraut.de>
Stability   :  experimental
Portability :  portable

Builders for Huskydoc elements
-}
module Text.Huskydoc.Builders
    ( emphasis
    , emphasisWith
    , hardBreak
    , softBreak
    , str
    , strong
    , strongWith
    ) where

import Data.Text (Text)
import Text.Huskydoc.Types
 
-- | Create a simple element for emphasized text.
emphasis :: [InlineElement] -> InlineElement
emphasis = plainElement . Emphasis

-- | Create an element for emphasized text with attributes.
emphasisWith :: Attributes -> [InlineElement] -> InlineElement
emphasisWith a es = richElement a (Emphasis es)

-- | Create a hard linebreak element.
hardBreak :: InlineElement
hardBreak = plainElement LineBreak

-- | Create a soft linebreak element.
softBreak :: InlineElement
softBreak = plainElement SoftBreak

-- | Create a simple string element from text.
str :: Text -> InlineElement
str = plainElement . Str

-- | Create a simple element for strong text.
strong :: [InlineElement] -> InlineElement
strong = plainElement . Strong

-- | Create an element for strong text with attributes.
strongWith :: Attributes -> [InlineElement] -> InlineElement
strongWith a es = richElement a (Strong es)
