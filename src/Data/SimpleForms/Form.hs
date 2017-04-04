{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ViewPatterns #-}
module Data.SimpleForms.Form where

import Protolude
import Text.Digestive
import Control.Lens hiding ((&))

data Validation = NotEmpty
                | Equals Text
              deriving (Show, Eq)

data FormType = InputText
              | InputTextArea
              | Radio [Text]
              | CheckBox [Text]
            deriving (Show, Eq)

data FormField = FormField
               { formFieldFormType    :: FormType
               , formFieldDescription :: Text
               , formFieldValidations :: [Validation]
               } deriving (Show, Eq)
makeFields ''FormField

type SimpleForm = [FormField]

type FormResult = [(FormField, Text)]

validateResult :: FormResult -> Bool
validateResult [] = True
validateResult ((f,x):xs) = validateField (f ^. validations) && validateResult xs
  where
    validateField :: [Validation] -> Bool
    validateField []     = True
    validateField (v:vs) = validateField vs &&
      case v of
        NotEmpty -> True -- not $ null x
        Equals y -> x == y
