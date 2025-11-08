{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module LearningJunkie.Codex.Web.OpenApi where

import Control.Lens
import Data.OpenApi (
    HasDescription (description),
    HasInfo (info),
    HasLicense (license),
    HasTitle (title),
    HasVersion (version),
    OpenApi,
    Operation,
    applyTagsFor,
 )
import qualified LearningJunkie.Codex.Web.API as Web
import Servant
import Servant.OpenApi (HasOpenApi (toOpenApi), subOperations)
import Servant.Swagger.UI (SwaggerSchemaUI, swaggerSchemaUIServer)

type API = SwaggerSchemaUI "swagger-ui" "swagger.json"

codexOps :: Traversal' OpenApi Operation
codexOps = subOperations (Proxy :: Proxy Web.API) (Proxy :: Proxy Web.API)

openApiDoc :: OpenApi
openApiDoc =
    toOpenApi (Proxy :: Proxy Web.API)
        & info
            . title
            .~ "Learning Junkie API"
        & info
            . version
            .~ "0.1.0.0"
        & info
            . description
            ?~ "Free Online Education Platform"
        & info
            . license
            ?~ "BSD"
        & applyTagsFor codexOps ["codex" & description ?~ "Code execution utility"]

server :: Server API
server = swaggerSchemaUIServer openApiDoc
