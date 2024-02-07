*** Settings ***
Library    SeleniumLibrary

Test Setup       Run Keywords
...              Open Browser    url=${URL}    browser=${BROWSER}    AND
...              Maximize Browser Window
#Test Teardown    Close Browser
*** Variables ***
### Dados de configuração ###
${URL}        https://www.saucedemo.com/v1/
${BROWSER}    chrome
### Page Object Model (POM) ###
&{LOGIN_PAGE}
...    UsernameInput=id:user-name
...    PassowordInput=xpath://input[@name='password']
...    LoginButton=css:[class=btn_action]
*** Keywords ***
Realizar Login
     Wait Until Element Is Visible   ${LOGIN_PAGE.UsernameInput} 
    Input Text       ${LOGIN_PAGE.UsernameInput}    standard_user
     Wait Until Element Is Visible   ${LOGIN_PAGE.PassowordInput}
    Input Text       ${LOGIN_PAGE.PassowordInput}    secret_sauce
    Click Element    ${LOGIN_PAGE.LoginButton}
    
Validar que o login foi feito com sucesso
    ${url}= Get Location
    ${first}- Set Variable  


*** Test Cases ***
TC001 - Realizar login com usuário válido
    Maximize Browser Window
    Realizar Login
    #Close Browser