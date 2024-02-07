*** Settings ***
Library    SeleniumLibrary
*** Variables ***
### Dados de configuração ###
${URL}        https://www.saucedemo.com/v1/
${BROWSER}    chrome
### Page Object Model (POM) ###
&{LOGIN_PAGE}
...    UsernameInput=id:user-name
...    PassowordInput=xpath://input[@name='password']
...    LoginButton=css:[class=btn_action]

&{ACESS_PAGE}
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

Realizar Logout
        Click Element  ${button}  
    
*** Test Cases ***
TC001 - Realizar login com usuário válido
    Open Browser    url=${URL}    browser=${BROWSER}
    Maximize Browser Window
    Realizar Login
    Realizar Logout
    #Close Browser