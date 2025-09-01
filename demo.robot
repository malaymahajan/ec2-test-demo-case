*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Chrome
${URL}            https://www.google.com
${SEARCH_TERM}    OpenAI ChatGPT

*** Test Cases ***
Google Search and Log First 5 Results
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    Open Browser    ${URL}    ${browser}    options=${options}
    Sleep    2s

    Handle Consent Popup If Present

    Input Text    name:q    ${SEARCH_TERM}
    Press Keys    name:q    RETURN
    Sleep    3s

    Log First 5 Google Search Results
    Close Browser

*** Keywords ***
Handle Consent Popup If Present
    ${exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath://button[text()="I agree" or text()="Accept all"]
    Run Keyword If    ${exists}    Click Element    xpath://button[text()="I agree" or text()="Accept all"]
    Sleep    1s

Log First 5 Google Search Results
    @{results}=    Get WebElements    css:div.g
    FOR    ${index}    IN RANGE    0    5
        ${title}=    Get Text    xpath=(//div[@class="g"]//h3)[${index}+1]
        ${url}=      Get Element Attribute    xpath=(//div[@class="g"]//a)[${index}+1]    href
        Log    ${index}+1. ${title}
        Log    URL: ${url}
    END
