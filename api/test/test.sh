#!/bin/bash

# Define the base URL of your API
BASE_URL="http://patatoserv.ddns.net:8085"
ERROR=0

# Function to perform a test
perform_test() {
    local url=$1
    local expected_status=$2
    local body=$3
    local request_type=$4

    response=$(curl --silent --header "Content-Type: application/json" \
                     --request POST \
                     --data "$body" \
                     "$url")
    status_code=$(echo "$response" | grep -o '"statusCode":[0-9]*' | grep -o '[0-9]*')
    # if no status code is found, then it's 201
    if [ -z "$status_code" ]; then
        status_code=201
    fi
    echo "Status code: $status_code"

    # Check if the status code is the expected one or 409
    if [ "$status_code" -ne "$expected_status" ] && [ "$status_code" -ne 409 ]; then
        echo "Test failed: Expected status $expected_status, got $status_code"
        ERROR=1
    else
        echo "Test passed: $url"
    fi
}

# Test the routes : routes code  body request_type
# Example POST data
login_data_wrong='{"usernameOrEmail":"testuser", "password":"testpass"}'
login_data_good='{"usernameOrEmail":"newUser", "password":"JeSuisFou21341!"}'
register_data='{"username":"newUser", "email":"newuser@test-example.com", "password":"JeSuisFou21341!", "fullName":"newUser"}'


echo "Testing routes"
echo "-------------"
echo "Bad register"
perform_test "$BASE_URL/auth/register" 400 "" "POST"
echo "Good register"
perform_test "$BASE_URL/auth/register" 201 "$register_data" "POST"

echo "Bad login"
perform_test "$BASE_URL/auth/login" 401 "$login_data_wrong" "POST"
echo "Good login"
perform_test "$BASE_URL/auth/login" 201 "$login_data_good" "POST"

#connect to the database and exec the script mongosh < area_db.sh
ssh $SSH_HOST -p $SSH_PORT -l $SSH_USER "mongosh < area_db.sh && exit"

# Exit with an error code if any test failed
if [ $ERROR -eq 1 ]; then
    echo "Some tests failed"
    exit 1
else
    echo "All tests passed"
    exit 0
fi
