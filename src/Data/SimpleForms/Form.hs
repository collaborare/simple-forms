module Data.SimpleForms.Form where

import Protolude
import Text.Digestive

data Validation = NotEmpty
                | Equals Text

data FormType = InputText
              | InputTextArea
              | Radio [Text]
              | CheckBox [Text]

data FormField = FormField
               { formFieldType        :: FormType
               , formFieldDescription :: Text
               , formFieldValidations :: [Validation]
               }
-- makeFields'' FormField
