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

{-# LANGUAGE RecordWildCards #-}
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
  ( toInlines
  , toBlocks
  -- document
  , document
  , metaData
  , emptyMeta
  -- inline elements
  , emphasis
  , emphasisWith
  , hardBreak
  , softBreak
  , space
  , str
  , strong
  , strongWith
  -- blocks
  , sectionTitle
  , sectionTitleWith
  , sectionTitleWith'
  , paragraph
  , paragraphWith
  , paragraphWith'
  ) where

import           Data.Maybe (fromMaybe)
import qualified Data.Sequence as Seq
import           Data.Text (Text)
import           Text.Huskydoc.Types

--
-- Document
--

-- | A complete document with contents and metadata
document :: MetaData -> Blocks -> Document
document = Document

-- | Empty metadata
emptyMeta :: MetaData
emptyMeta = MetaData emptyInlines

-- | Create a new metadata element
metaData :: Inlines -> MetaData
metaData metaDataTitle = MetaData {..}


--
-- wrappers
--

-- | Turn a list of inline elements to inlines.
toInlines :: [InlineElement] -> Inlines
toInlines = Inlines . Seq.fromList

-- | Empty inlines
emptyInlines :: Inlines
emptyInlines = Inlines Seq.empty

-- | Convert a list of block elements into @Blocks@
toBlocks :: [BlockElement] -> Blocks
toBlocks = Blocks . Seq.fromList


--
-- Inline elements
--

-- | Create a simple element for emphasized text.
emphasis :: Inlines -> InlineElement
emphasis = plainElement . Emphasis . toInlinesList

-- | Create an element for emphasized text with attributes.
emphasisWith :: Attributes -> [InlineElement] -> InlineElement
emphasisWith a es = richElement a (Emphasis es)

-- | Create a hard linebreak element.
hardBreak :: InlineElement
hardBreak = plainElement LineBreak

-- | Create a soft linebreak element.
softBreak :: InlineElement
softBreak = plainElement SoftBreak

-- | Create a space element
space :: InlineElement
space = plainElement Space

-- | Create a simple string element from text.
str :: Text -> InlineElement
str = plainElement . Str

-- | Create a simple element for strong text.
strong :: Inlines -> InlineElement
strong = plainElement . Strong . toInlinesList

-- | Create an element for strong text with attributes.
strongWith :: Attributes -> [InlineElement] -> InlineElement
strongWith a es = richElement a (Strong es)


--
-- Block elements
--
paragraph :: Inlines -> BlockElement
paragraph = plainElement . Paragraph

paragraphWith :: Inlines -> Attributes -> BlockElement
paragraphWith inlns a = richElement a (Paragraph inlns)

paragraphWith' :: Inlines -> Maybe Attributes -> BlockElement
paragraphWith' inlns a = inlns `paragraphWith` fromMaybe nullAttributes a

sectionTitle :: Int -> Inlines -> BlockElement
sectionTitle lvl = plainElement . SectionTitle lvl

sectionTitleWith :: Int -> Inlines -> Attributes -> BlockElement
sectionTitleWith lvl inlns a = richElement a (SectionTitle lvl inlns)

sectionTitleWith' :: Int -> Inlines -> Maybe Attributes -> BlockElement
sectionTitleWith' lvl inlns a =
  sectionTitleWith lvl inlns $ fromMaybe nullAttributes a
