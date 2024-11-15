*** Settings ***
Resource    ../requests/connector/api.robot
Resource    ../requests/docplanner/api.robot
Resource    ../requests/feegow_rest/api.robot
Resource    ../../resources/global/variables.robot
Resource    ../../resources/keywords/payloads.robot
Resource    ../../resources/requests/callbacks/docplanner/api.robot
Resource    ../../resources/requests/callbacks/feegow/api.robot
Library     ../utils/CustomDateTime.py
Library     JSONLibrary
Library     Collections
Library     RequestsLibrary
Library     String
Library     DateTime
Library     FakerLibrary