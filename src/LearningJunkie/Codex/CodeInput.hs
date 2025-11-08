{-# LANGUAGE DeriveGeneric #-}

module LearningJunkie.Codex.CodeInput where

import Data.Aeson (FromJSON, ToJSON)
import Data.OpenApi (ToSchema)
import Data.Text (Text)
import GHC.Generics (Generic)
import LearningJunkie.Codex.Environment (Environment)

data CodeInput = CodeInput
        { program :: Text
        , environment :: Environment
        }
        deriving (Generic)

instance FromJSON CodeInput
instance ToJSON CodeInput
instance ToSchema CodeInput
