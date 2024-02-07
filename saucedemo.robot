*** Settings ***

Documentation    IQS - Automação FrontEnd (WEB)
...
...              Exemplo de automação com Robot Framework e Selenium.

Library    SeleniumLibrary

Test Setup       Run Keywords
...              Open Browser    url=${URL}    browser=${BROWSER}    AND
...              Maximize Browser Window    
#Test Teardown    Close BrowserAND   

*** Variables ***

${mensagem_email_incorreto}     Erro ao realizar o login - E-mail incorreto
${mensagem_senha_incorreta}     Erro ao realizar o login - Senha incorreta

### Dados de configuração ###

${URL}        http://sistemas.t2mlab.com:3008
${BROWSER}    chrome

### Massa de teste ###

${USUARIO_VALIDO}       BNViana
${USUARIO_BLOQUEADO}    BNViana2
&{SENHA}
...    VALIDA=123
...    INVALIDA=1234

### Page Object Model (POM) ###

&{LOGIN_PAGE}
...    UsernameInput=id:formBasicEmail
...    PassowordInput=id:formBasicPassword
...    LoginButton=xpath://*[@id="root"]/div[1]/div/div[2]/div[3]/div/div/form/div[3]/div/div/button/span
...    EntrarImg=css:div[title="Sistema de Biblioteca"]
...    ErrorMessage=xpath://*[@id="1"]



*** Keywords ***

### Ações ###

Realizar login com ${username} e ${password}
    Input Text       ${LOGIN_PAGE.UsernameInput}    ${username}
    Input Text       ${LOGIN_PAGE.PassowordInput}    ${password}
    Click Element    ${LOGIN_PAGE.LoginButton}
    
    

Acessar Page   
    Wait Until Element Is Visible   ${LOGIN_PAGE.EntrarImg} 
    Clicar no botao ${LOGIN_PAGE.EntrarImg} 

Digitar No Input ${field} o texto ${texto}
    Wait Until Element Is Enabled    ${field}
    Input Text    ${field}    ${texto}

Clicar no botao ${field}
    Wait Until Element Is Visible    ${field}
    Wait Until Element Is Enabled    ${field}
    Click Element   ${field}

### Verificações ###

Verificar se conseguiu realizar o login corretamente
    ${url}=    Get Location
    Should Contain    ${url}    /sistema-biblioteca

Verificar se não foi possivel realizar o login com ${texto}
    Wait Until Element Is Visible   ${LOGIN_PAGE.UsernameInput} 
    Wait Until Element Is Visible   ${LOGIN_PAGE.ErrorMessage} 
     ${mensagem_obtida}=    Get Text    locator=${LOGIN_PAGE.ErrorMessage}
     IF  "${texto}" == "email"  
         Should Be Equal    ${mensagem_obtida}    ${mensagem_email_incorreto} 

    ELSE IF   "${texto}" == "senha"  
        Should Be Equal        ${mensagem_obtida}    ${mensagem_senha_incorreta} 
    END

*** Test Cases ***

TC001 - Realizar login com usuário válido
    [Tags]    FLUXO-POSITIVO    REQ001
    Realizar login com ${USUARIO_VALIDO} e ${SENHA.VALIDA}
    Acessar Page
    Verificar se conseguiu realizar o login corretamente

TC002 - Realizar login com usuário bloqueado e email incorreto
    [Tags]    FLUXO-NEGATIVO    REQ002
    
    Realizar login com ${USUARIO_BLOQUEADO} e ${SENHA.VALIDA}
    Verificar se não foi possivel realizar o login com email


TC002 - Realizar login com usuário bloqueado e senha incorreta
    [Tags]    FLUXO-NEGATIVO    REQ002
    
    Realizar login com ${USUARIO_VALIDO} e ${SENHA.INVALIDA}
    Verificar se não foi possivel realizar o login com senha
    



