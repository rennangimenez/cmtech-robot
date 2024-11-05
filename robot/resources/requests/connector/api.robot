*** Settings ***
Resource          ../../../resources/global/settings.robot

*** Keywords ***
Connector API - Doctor Full Reset
    ${fullReset}=           Load JSON From File     file_name=${ROBOT_DIR}${/}data${/}connector_api${/}doctor_reset${/}body.json
    Create Session           alias=connector-api-reset    url=${CONNECTOR_API_BASE_URL}     verify=true
    POST On Session          connector-api-reset    /internal/reset        json=${fullReset}        headers=&{connectorApi_headers}  