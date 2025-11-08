{-# LANGUAGE OverloadedStrings #-}

module LearningJunkie.Codex.Client where

import LearningJunkie.Codex.CodeInput (CodeInput (CodeInput, environment, program))
import LearningJunkie.Codex.Environment (Environment (Node))
import LearningJunkie.Codex.ExecutionResult (ExecutionResult)
import qualified LearningJunkie.Codex.Web.API as Web
import Network.HTTP.Client (defaultManagerSettings, newManager)
import Servant
import Servant.Client

type API = Web.API

api :: Proxy API
api = Proxy

executeClient :: CodeInput -> ClientM ExecutionResult
executeClient = client api

