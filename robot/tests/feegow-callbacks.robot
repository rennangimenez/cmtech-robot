*** Settings ***
Resource          ../resources/global/settings.robot
Suite Setup       API Payload Setup

*** Test Cases ***
Feegow Callbacks
    Feegow Callbacks - Booking - Booking Created
    Feegow Callbacks - Booking - Booking Edit
    Feegow Callbacks - Booking - Booking Moved
    Feegow Callbacks - Booking - Booking Canceled