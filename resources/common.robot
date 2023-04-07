*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String
Library                         FakerLibrary


*** Variables ***
${username}                     dkellogg-jjh2@force.com
${login_url}                    https://xyz118.lightning.force.com/                     # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home
${BROWSER}                      chrome
${first_name}
${last_name}
${email}

*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb                        QForce
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow


End suite
    Set Library Search Order    QWeb                        QForce
    Close All Browsers


Login
    [Documentation]             Login to Salesforce instance
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In


Home
    [Documentation]             Navigate to homepage, login if needed
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce

Create Account
    [Arguments]                 ${type}
    ${test}=                    Generate Random String      length=5-10
    ClickText                   Accounts
    ClickText                   New                         delay=10
    UseModal                    On
    VerifyText                  Account Information
    TypeText                    *Account Name               ${test}
    PickList                    Type                        ${type}
    PickList                    Industry                    Banking
    ClickText                   Save                        partial_match=False

Generate Account Data
    ${first_name}=              FakerLibrary.first_name
        Set Suite Variable      ${first_name}
    ${last_name}=               FakerLibrary.last_name
        Set Suite Variable      ${last_name}
    ${email}=                   FakerLibrary.email
        Set Suite Variable      ${email}
    RETURN                      ${first_name}               ${last_name}                ${email}
