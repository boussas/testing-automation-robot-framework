*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                    https://www.saucedemo.com/
${BROWSER}                Chrome

# Login
${USERNAME_FIELD}         id=user-name
${PASSWORD_FIELD}         id=password
${LOGIN_BUTTON}           id=login-button

# Product: Sauce Labs Backpack
${BACKPACK_ADD_BTN}       id=add-to-cart-sauce-labs-backpack
${CART_ICON}    css:a[data-test='shopping-cart-link']
${CART_BADGE}             css:.shopping_cart_badge

# Cart Page Elements
${CART_PRODUCT_NAME}      css:.cart_item .inventory_item_name[data-test='inventory-item-name']
${CART_QUANTITY}          css:.cart_quantity[data-test='item-quantity']
${CART_PRICE}             css:.cart_item .inventory_item_price[data-test='inventory-item-price']

*** Test Cases ***
QA-12 Mise à jour du badge du panier après ajout du premier produit
    [Documentation]    Vérifie que le badge devient "1" sur la page d'accueil.
    [Tags]    QA-12
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${USERNAME_FIELD}    standard_user
    Input Text    ${PASSWORD_FIELD}    secret_sauce
    Click Button  ${LOGIN_BUTTON}
    Wait Until Page Contains    Products    timeout=10s

    Click Element    ${BACKPACK_ADD_BTN}
    Wait Until Element Is Visible    ${CART_BADGE}    timeout=10s
    Element Text Should Be    ${CART_BADGE}    1
    [Teardown]    Close Browser

QA-13 Vérification du contenu du panier après ajout
    [Documentation]    Vérifie que le produit apparaît correctement dans la page du panier.
    [Tags]    QA-13
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${USERNAME_FIELD}    standard_user
    Input Text    ${PASSWORD_FIELD}    secret_sauce
    Click Button  ${LOGIN_BUTTON}
    Wait Until Page Contains    Products    timeout=10s

    Click Element    ${BACKPACK_ADD_BTN}
    Click Element    ${CART_ICON}
    Wait Until Page Contains    Your Cart    timeout=15s

    Element Text Should Be    ${CART_PRODUCT_NAME}    Sauce Labs Backpack
    Element Text Should Be    ${CART_QUANTITY}        1
    Element Text Should Be    ${CART_PRICE}           $29.99
    [Teardown]    Close Browser