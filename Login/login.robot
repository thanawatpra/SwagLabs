*** Settings ***
Library         SeleniumLibrary
Resource        ../loginSwagLabs.robot

*** Variables ***
${TEXT1}        Epic sadface: Username is required
${TEXT2}        Epic sadface: Password is required
${TEXT3}        Epic sadface: Username and password do not match any user in this service
${TEXT4}        Epic sadface: Sorry, this user has been locked out.

*** Keywords ***


*** Test Cases ***
ตรวจสอบการเข้าสู่ระบบกรณีไม่กรอก Username และ Password
    Login Invalid
    Page Should Contain         ${TEXT1}
    Capture Page Screenshot     TC_Login_001.png
    Close Browser

ตรวจสอบการเข้าสู่ระบบกรณีกรอกข้อมูลบางส่วน
    Login Invalid               standard_user
    Page Should Contain         ${TEXT2}
    Capture Page Screenshot     TC_Login_002.png
    Close Browser


ตรวจสอบการเข้าสู่ระบบกรณีกรอกข้อมูลไม่ถูกต้อง
    Login Invalid               standard_user               12345678
    Page Should Contain         ${TEXT3}
    Capture Page Screenshot     TC_Login_003.png
    Close Browser


ตรวจสอบการเข้าสู่ระบบกรณีกรอกผู้ใช้งานถูกล็อค
    Login Invalid               locked_out_user                  secret_sauce
    Page Should Contain         ${TEXT4}
    Capture Page Screenshot     TC_Login_004.png
    Close Browser

ตรวจสอบการเข้าสู่ระบบกรณีกรอกข้อมูล SQLInjection
    Login SQLInjection
    Page Should Contain         ${TEXT3}
    Capture Page Screenshot     TC_Login_005.png
    Close Browser

ตรวจสอบการเข้าสู่ระบบกรณีกรอกเบอร์โทรหรือที่อยู่อีเมลและรหัสผ่านถูกต้อง
    Login Valid
    Capture Page Screenshot     TC_Login_006.png
    Close Browser