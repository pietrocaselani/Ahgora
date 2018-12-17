Ahgora
===

Ahgora is:

* a wrapper arround the unofficial Ahgora's API
* a iOS/macOS app to interact with Ahgora.

## Instructions

Run the following commands

* `cd Ahgora && pod install`

* `Open Ahgora.xcworkspace`

## Roadmap

* Better design (iOS)
* Schedule local notifications to warn the user about the work hours limit (iOS)
* Schedule local notifications to warn the user about the work hours limit (macOS)

# Screenshots

## macOS

<img src="https://raw.githubusercontent.com/pietrocaselani/Ahgora/master/screenshots/macos_punch.png" width="450"/>
<img src="https://raw.githubusercontent.com/pietrocaselani/Ahgora/master/screenshots/macos_mirror.png" width="450"/>
<img src="https://raw.githubusercontent.com/pietrocaselani/Ahgora/master/screenshots/macos_configs2.png" width="450"/>

## iOS
<img src="https://raw.githubusercontent.com/pietrocaselani/Ahgora/master/screenshots/ios_punch.png" height="450"/>
<img src="https://raw.githubusercontent.com/pietrocaselani/Ahgora/master/screenshots/ios_mirror.png" height="450"/>
<img src="https://raw.githubusercontent.com/pietrocaselani/Ahgora/master/screenshots/ios_configs.png" height="450"/>

# API

## Mirror API

* URL: `https://www.ahgora.com.br/externo/getApuracao`
* HTTP Method: `POST`
* Content-Type: `application/x-www-form-urlencoded; charset=utf-8`
* Body: `ano=YEAR&company=COMPANY_ID&matricula=EMPLOYEE_ID&mes=MONTH&senha=EMPLOYEE_PASSWORD`

CURL example:

```
curl --request POST \
  --url https://www.ahgora.com.br/externo/getApuracao \
  --header 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
  --data 'ano=YEAR&company=COMPANY_ID&matricula=EMPLOYEE_ID&mes=MONTH&senha=EMPLOYEE_PASSWORD'
```

## Clock Punch API

* URL: `https://www.ahgora.com.br/externo/getApuracao`
* HTTP Method: `POST`
* Content-Type: `application/x-www-form-urlencoded; charset=utf-8`
* Body: `ano=YEAR&company=COMPANY_ID&matricula=EMPLOYEE_ID&mes=MONTH&senha=EMPLOYEE_PASSWORD`

CURL example:

* URL: `https://www.ahgora.com.br/batidaonline/verifyIdentification`
* HTTP Method: `POST`
* Content-Type: `application/x-www-form-urlencoded; charset=utf-8`
* Body: `account=EMPLOYEE_ID&password=EMPLOYEE_PASSWORD&identity=COMPANY_AUTH_IDENTIFIER&key=`

```
curl --request POST \
  --url https://www.ahgora.com.br/batidaonline/verifyIdentification \
  --header 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
  --data 'account=EMPLOYEE_ID&password=EMPLOYEE_PASSWORD&identity=COMPANY_AUTH_IDENTIFIER&key='
```
