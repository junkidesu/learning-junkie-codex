module LearningJunkie.Codex.Client where

import LearningJunkie.Codex.CodeInput (CodeInput)
import LearningJunkie.Codex.ExecutionResult (ExecutionResult)
import qualified LearningJunkie.Codex.Web.API as Web
import Servant
import Servant.Client

type API = Web.API

api :: Proxy API
api = Proxy

executeClient :: CodeInput -> ClientM ExecutionResult
executeClient = client api
