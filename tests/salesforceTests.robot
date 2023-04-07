*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                String
Library                DateTime
Library                FakerLibrary

*** Test Cases ***
Create an account
    [Documentation]    This is creating a unique account to ensure account creation is working properly.
    Appstate           Home
    Create Account     Customer


Create Account with Faker Library
    Generate Account Data
    Login
    ClickText         Accounts
    ClickText         New
    TypeText          *Account Name    ${first_name}
