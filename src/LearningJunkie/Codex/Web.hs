{-# LANGUAGE TypeOperators #-}

module LearningJunkie.Codex.Web where

import qualified LearningJunkie.Codex.Web.API as Web
import LearningJunkie.Codex.Web.Cors (myCors)
import qualified LearningJunkie.Codex.Web.OpenApi as OpenApi
import Network.Wai.Handler.Warp (defaultSettings, runSettings, setLogger, setPort)
import Network.Wai.Logger (withStdoutLogger)
import Servant
import System.Directory (createDirectoryIfMissing)

type API = Web.API :<|> OpenApi.API

api :: Proxy API
api = Proxy

server :: Server API
server = Web.server :<|> OpenApi.server

makeApp :: IO Application
makeApp = return $ myCors $ serve api server

startApp :: IO ()
startApp = do
        createDirectoryIfMissing True "codex/haskell"
        createDirectoryIfMissing True "codex/python"
        createDirectoryIfMissing True "codex/node"

        app <- makeApp
        withStdoutLogger $ \aplogger -> do
                let settings =
                        setPort 3001 $
                                setLogger aplogger defaultSettings

                runSettings settings app
