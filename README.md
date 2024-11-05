To use Allure Report you need to execute the command bellow to run your test cases with the listener of allure-robotframework:

1. python -m robot --listener allure_robotframework ./robot/tests/docplanner-callbacks.robot

After this execution, run the second command to generate the report:

2. allure serve output/allure