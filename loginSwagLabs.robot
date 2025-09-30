*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}          https://www.saucedemo.com
${BROWSER}      Firefox
${USER}         standard_user
${PASSWORD}     secret_sauce

*** Keywords ***
Login Valid
    Open Browser        ${URL}              ${BROWSER}
    Maximize Browser Window
    Input Text          id=user-name        ${USER}
    Input Text          id=password         ${PASSWORD}
    Click Element       id=login-button

Login Invalid
    [Arguments]     ${User}=     ${Password}=
    Open Browser        ${URL}              ${BROWSER}
    Maximize Browser Window
    IF      '${User}' != ''
        Input Text          id=user-name        ${User}
    END
    IF      '${Password}' != ''
        Input Text    id=password         ${Password}
    END 
    Click Element       id=login-button
    Wait Until Element Contains     xpath=//span[@data-test="title"]        Products        timeout=10s

Login SQLInjection
    Open Browser        ${URL}              ${BROWSER}
    Maximize Browser Window
    Input Text          id=user-name        ${USER}
    Input Text          id=password         ' OR 1=1--
    Click Element       id=login-button