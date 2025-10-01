*** Settings ***
Library         SeleniumLibrary
Resource        ../loginSwagLabs.robot

*** Variables ***
${VALIDATE_FIRST_NAME}              Error: First Name is required
${VALIDATE_LAST_NAME}               Error: Last Name is required
${VALIDATE_Zip/Postal_Code}         Error: Postal Code is required
${COMPLETE}                         Thank you for your order!

*** Keywords ***
Wait Data Web
    Wait Until Page Contain     Sauce Labs Backpack     timeout=10s
    Wait Until Page Contain     Sauce Labs Sauce Labs Bike Light        timeout=10s
    Wait Until Page Contain     Sauce Labs Bolt T-Shirt     timeout=10s
    Wait Until Page Contain     Sauce Labs Fleece Jacket        timeout=10s
    Wait Until Page Contain     Sauce Labs Onesie     timeout=10s
    Wait Until Page Contain     Test.allTheThings() T-Shirt (Red)        timeout=10s

*** Test Cases ***
ตรวจสอบการดูรายละเอียดของสินค้า
    Login Valid
    Wait Data Web
    Click Element       xpath=//div[text()='Sauce Labs Backpack']
    Wait Until Page Contain     Sauce Labs Backpack     timeout=10s
    Capture Page Screenshot     TC_Products_001.png

ตรวจสอบการเพิ่มสินค้าลงในตะกร้า 1 รายการ
    Click Element       xpath=//button[text()='Add to cart']
    Capture Page Screenshot     TC_Products_002.png

ตรวจสอบการเพิ่มสินค้าลงในตะกร้ามากกว่า 1 รายการ
    Click Element       id=back-to-products
    Sleep       0.2s
    Click Element       xpath=//button[@data-test="add-to-cart-sauce-labs-bike-light"]
    Click Element       xpath=//button[@data-test="add-to-cart-sauce-labs-bolt-t-shirt"]
    Sleep       0.5s
    Capture Page Screenshot     TC_Products_003.png

ตรวจสอบการลบสินค้าออกจากตะกร้า
    Click Element       xpath=//button[@data-test="remove-sauce-labs-bolt-t-shirt"]
    Sleep       0.5s
    Capture Page Screenshot     TC_Products_004.png

ตรวจสอบการดูข้อมูลสินค้าในตะกร้า
    Click Element       id=shopping_cart_container
    Wait Until Page Contain     Sauce Labs Backpack     timeout=10s
    Wait Until Page Contain     Sauce Labs Sauce Labs Bike Light        timeout=10s
    Capture Page Screenshot     TC_Products_005.png

ตรวจสอบการลบสินค้าในตะกร้า
    Click Element       id=remove-sauce-labs-bike-light
    Wait Until Page Does Not Contain        Sauce Labs Sauce Labs Bike Light        timeout=10s
    Capture Page Screenshot     TC_Products_006.png

ตรวจสอบการย้อนกลับไปยังหน้าสินค้า
    Click Element       id=continue-shopping
    Wait Data Web
    Capture Page Screenshot     TC_Products_007.png

ตรวจสอบการชำระเงิน
    Click Element       id=shopping_cart_container
    Wait Until Page Contain     Sauce Labs Backpack     timeout=10s
    Wait Until Page Contain     Sauce Labs Sauce Labs Bike Light        timeout=10s
    Click Element       id=checkout
    Wait Until Element Is Visible       xpath=//input[@placeholder="First Name"]        timeout=10s
    Wait Until Element Is Visible       xpath=//input[@placeholder="Last Name"]        timeout=10s
    Wait Until Element Is Visible       xpath=//input[@placeholder="Zip/Postal Code"]        timeout=10s
    Capture Page Screenshot     TC_Products_008.png

ตรวจสอบการกเลิกการชำระเงิน
    Click Element       id=cancel
    Wait Data Web
    Capture Page Screenshot     TC_Products_009.png

ตรวจสอบการกรอกรายละเอียดการชำระเงิน กรณีไม่กรอกรายละเอียด
    Click Element       id=continue
    Page Should Contain     ${VALIDATE_FIRST_NAME}
    Capture Page Screenshot     TC_Products_010.png

ตรวจสอบการกรอกรายละเอียดการชำระเงิน กรณีกรอกรายละเอียดบางส่วน
    Input Text      id=first-name       test
    Click Element       id=continue
    Capture Page Screenshot     TC_Products_011.png

ตรวจสอบการกรอกรายละเอียดการชำระเงิน กรณีกรอกถูกต้องครบถ้วน
    Input Text      id=last-name        Automate
    Input Text      id=postal-code      1234567890
    Page Should Contain     ${VALIDATE_Zip/Postal_Code}
    Click Element       id=continue
    Wait Until Page Contain     Sauce Labs Backpack     timeout=10s
    Wait Until Page Contain     Sauce Labs Sauce Labs Bike Light        timeout=10s
    Capture Page Screenshot     TC_Products_012.png

ตรวจสอบการยกเลิกคำสั่งซื้อในหน้าภาพรวมคำสั่งซื้อ
    Click Element       id=cancel
    Wait Data Web
    Capture Page Screenshot     TC_Products_013.png

ตรวจสอบการซื้อสินค้าสำเร็จ
    Click Element       id=shopping_cart_container
    Wait Until Page Contain     Sauce Labs Backpack     timeout=10s
    Wait Until Page Contain     Sauce Labs Sauce Labs Bike Light        timeout=10s
    Click Element       xpath=//button[text()='Checkout']
    Input Text      id=first-name       test
    Input Text      id=last-name        Automate
    Input Text      id=postal-code      1234567890
    Click Element       id=continue
    Click Element       xpath=//button[text()='Finish']
    Page Should Contain     ${COMPLETE}
    Capture Page Screenshot     TC_Products_014.png

ตรวจสอบการออกจากระบบ
    Click Element       xpath=/button[text()='Back Home']
    Wait Data Web
    Click Element       xpath=//button[text()='Open Menu']
    Click Element       id=logout_sidebar_link
    ${url}=     Get Location
    Should Start With       ${url}      https://www.saucedemo.com
    Capture Page Screenshot     TC_Products_015.png