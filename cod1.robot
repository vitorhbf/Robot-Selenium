*** Settings ***
Library    SeleniumLibrary
*** Variables ***
*** Keywords ***
*** Test Cases ***
TC001 - Realizar login com usuário válido
    Open Browser    url=https://www.saucedemo.com/v1/    browser=chrome
    Maximize Browser Window
    Input Text    id:user-name    standard_user
    Input Text    id:password     secret_sauce
    Click Element    id:login-button
    #Close Browser
    