*** Settings ***
Library         SeleniumLibrary
Resource        ../loginSwagLabs.robot

*** Variables ***

*** Keywords ***

*** Test Cases ***
ตรวจสอบการดูรายละเอียดของสินค้า
    Login Valid
    Click Element       xpath=//div[text()='Sauce Labs Backpack']
    Wait Until Page Contain     Sauce Labs Backpack
    Capture Page Screenshot     TC_Products_001.png

ตรวจสอบการเพิ่มสินค้าลงในตะกร้า 1 รายการ
    Click Element       xpath=//button[text()='Add to cart']
    Capture Page Screenshot     TC_Products_002.png

ตรวจสอบการเพิ่มสินค้าลงในตะกร้ามากกว่า 1 รายการ
    Click Element       id=back-to-products