To install Allure Report you have to follow all the steps on the link bellow:

- 🔗 [INSTALL ALLURE REPORT](https://allurereport.org/docs/install-for-windows/).

After the instalation is done you will need to install the robotframework allure extension. To do that, go to your projects directory on Powershell or Git Bash (or any other prompt) and execute the command bellow:

``` pip install robotframework-allure or pip3 install robotframework-allure ```

After that, you can execute the test you want to get e report, by using the command bellow:

1. python -m robot --listener allure_robotframework ./robot/tests/docplanner-callbacks.robot

To generate the Allure Report use this command:

2. allure serve output/allure