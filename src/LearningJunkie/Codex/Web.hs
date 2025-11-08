{-# LANGUAGE TypeOperators #-}

module LearningJunkie.Codex.Web where

import LearningJunkie.Codex.Initialize (initializeDockerfiles)
import qualified LearningJunkie.Codex.Web.API as Web
import LearningJunkie.Codex.Web.Cors (myCors)
import qualified LearningJunkie.Codex.Web.OpenApi as OpenApi
import Network.Wai.Handler.Warp (defaultSettings, runSettings, setLogger, setPort)
import Network.Wai.Logger (withStdoutLogger)
import Servant

type API = Web.API :<|> OpenApi.API

api :: Proxy API
api = Proxy

server :: Server API
server = Web.server :<|> OpenApi.server

makeApp :: IO Application
makeApp = return $ myCors $ serve api server

startApp :: IO ()
startApp = do
        initializeDockerfiles

        app <- makeApp
        withStdoutLogger $ \aplogger -> do
                let settings =
                        setPort 3001 $
                                setLogger aplogger defaultSettings

                runSettings settings app
