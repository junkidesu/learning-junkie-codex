{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module LearningJunkie.Codex.Web.API where

import qualified LearningJunkie.Codex.Web.Execute as Execute
import Servant

type API = "codex" :> Execute.API

server :: Server API
server = Execute.handler
