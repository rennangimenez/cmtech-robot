*** Settings ***
Resource          ../requests/connector/api.robot
Resource          ../requests/docplanner/api.robot
Resource          ../requests/feegow_rest/api.robot
Resource          ../../resources/global/variables.robot
Resource          ../../resources/keywords/payloads.robot
Resource          ../../resources/requests/callbacks/doctoralia/api.robot
Resource          ../../resources/requests/callbacks/feegow/api.robot
Library           JSONLibrary
Library           Collections
Library           RequestsLibrary
Library           ../utils/CustomDateTime.py
Library           String
