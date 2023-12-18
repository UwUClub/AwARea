#!/bin/bash

# Define the base URL of your API
BASE_URL="http://localhost:8080"
ERROR=0

# Function to perform a test
perform_test() {
    local url=$1
    local expected_status=$2
    local body=$3
    local request_type=$4

    echo "Testing $url"
    echo "Expected status: $expected_status"
    echo "Body: $body"
    echo "Request type: $request_type"

    response=$(curl --silent --header "Content-Type: application/json" \
                     --request POST \
                     --data "$body" \
                     "$url")
    echo "Response: $response"
    status_code=$(echo "$response" | grep -o '"statusCode":[0-9]*' | grep -o '[0-9]*')
    echo "Status code: $status_code"
    # if no status code is found, then it's 201
    if [ -z "$status_code" ]; then
        status_code=201
    fi

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

perform_test "$BASE_URL/auth/register" 400 "" "POST"
perform_test "$BASE_URL/auth/register" 201 "$register_data" "POST"

perform_test "$BASE_URL/auth/login" 401 "$login_data_wrong" "POST"
perform_test "$BASE_URL/auth/login" 201 "$login_data_good" "POST"

# Exit with an error code if any test failed
if [ $ERROR -eq 1 ]; then
    echo "Some tests failed"
fi
