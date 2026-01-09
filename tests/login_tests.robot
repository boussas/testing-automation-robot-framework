*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://www.saucedemo.com/
${BROWSER}            Chrome

# Locators
${USERNAME_FIELD}     id=user-name
${PASSWORD_FIELD}     id=password
${LOGIN_BUTTON}       id=login-button
${FIRST_PRODUCT}      xpath=//div[@class='inventory_item_name' and text()='Sauce Labs Backpack']
${ERROR_MESSAGE}      xpath=//h3[@data-test='error']

*** Test Cases ***
QA-10 Login with Valid Credentials
    [Tags]    QA-10
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Input Text    ${USERNAME_FIELD}    standard_user
    Input Text    ${PASSWORD_FIELD}    secret_sauce
    Click Button  ${LOGIN_BUTTON}

    Wait Until Element Is Visible    id=inventory_container    timeout=10s
    # OU :
    # Page Should Contain    Sauce Labs Backpack

    [Teardown]    Close Browser

QA-11 Login with Invalid Credentials
    [Tags]    QA-11
    [Documentation]    Vérifie qu'un message d'erreur s'affiche pour des identifiants invalides.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Input Text    ${USERNAME_FIELD}    random_user
    Input Text    ${PASSWORD_FIELD}    wrong_password
    Click Button  ${LOGIN_BUTTON}

    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=5s
    Element Should Contain    ${ERROR_MESSAGE}    do not match any user

    [Teardown]    Close Browser

*** Keywords ***
# Aucun keyword personnalisé nécessaire ici — tout est inline pour la clarté