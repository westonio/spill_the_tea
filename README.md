# Spilled Tea - Subscription Service API

## Overview
Spilled tea is a quick project done as a technical assessment to create a backend rails API for a tea subscription service based off of minimal details on the requirements.


### JSON Contract
<details>
  <summary> <b>POST api/v0/subscriptions </b></summary><br/>

  Description: Create a new subscription.

  Requirements: Must provide valid data and datatypes as follows:
  - title [String]
  - price [Float]
  - frequency [Integer] (Options: 0 = weekly, 1 = monthly, 2 = qu
  arterly, 3 = annually)
  - customer_id [Integer]
  - tea_id [Integer]
  <br/><br/>

  Request Body:

  ```
  {
    "title": "Monthly Tea is Fundamental",
    "price": 9.99,
    "frequency": 1,
    "customer_id": 1,
    "tea_id": 7
  }
  ```
  <br/>
  <details>
    <summary><i> Successful Response:</i></summary>

    ```
    {
      "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
          "title": "Monthly Tea is Fundamental",
          "price": 9.99,
          "status": "active",
          "frequency": "monthly",
          "tea_id": 7,
          "customer_id": 1
        }
      }
    }
    ```

    **Status Code:** 201 :created

    The subscription has been successfully created. The response contains the newly created subscription's details with the status set to "active" as a default.
  </details>

  <details>
    <summary>Error Response:</summary>

    ```
    {
      "errors":[
        {
          "Validation failed: Title can't be blank"
        }
      ]
    }
    ```

    **Status Code:** 422 :unprocessable_entity

    The subscription has not been successfully created due to invalid ids, invalid data types, or missing values. The response contains the detailed error message.
  </details>
  <br/><br/><br/>
</details>

---

<details>
  <summary> <b>PATCH api/v0/subscriptions/:id </b></summary><br/>

  Description: Update a subscription status (Cancel a subscription).

  Requirements: 
  * *If updating data of the subscription*
    - title [String]
    - price [Float]
    - frequency [Integer] (Options: 0 = weekly, 1 = monthly, 2 = qu
  arterly, 3 = annually)
    - customer_id [Integer]
    - tea_id [Integer]

  * *If cancelling a subscription*
    - status [Integer] (Options: 0 = active, 1 = canceled)

  <br/><br/>
  Cancellation Request Body:

  ```
  {
    "status": 1
  }
  ```

  <br/>
  <details>
    <summary>Successful Response:</summary>

    ```
    {
      "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
          "title": "Monthly Tea is Fundamental",
          "price": 9.99,
          "status": "canceled",
          "frequency": "monthly",
          "tea_id": 7,
          "customer_id": 1
        }
      }
    }
    ```

    **Status Code:** 200 :ok

    The subscription has been successfully updated with a status "canceled".
  </details>

  <details>
    <summary>Cancelation Error Response:</summary>

    ```
    {
      "errors":[
        {
          "details":"'9' is not a valid status"
        }
      ]
    }
    ```

    **Status Code:** 400 :bad_request 

    The subscription has not been updated as an invalid status enums (integer) was used. Only the values 0 (active) and 1 (canceled) are allowed. The response contains the detailed error message.
  </details>
  <br/><br/><br/>
</details>

---

<details>
  <summary> <b>GET api/v0/customers/:id/subscriptions </b></summary><br/>

  Description: Get a list of all subscriptions for a customer.

  Requirements: 
  * *Must pass a valid customer ID*

  Request Body: No request body required

  <br/>
  <details>
    <summary>Successful Response:</summary>

    ```
    {
      "data": [
        {
          "id": "1",
          "type": "subscription",
          "attributes": {
              "title": "Sissy that walk.",
              "price": 60.75,
              "status": "active",
              "frequency": "annually",
              "tea_id": 1,
              "customer_id": 1
          }
        },
        {
          "id": "2",
          "type": "subscription",
          "attributes": {
              "title": "Put the bass in your walk.",
              "price": 57.79,
              "status": "active",
              "frequency": "quarterly",
              "tea_id": 2,
              "customer_id": 1
          }
        },
        {
          "id": "3",
          "type": "subscription",
          "attributes": {
              "title": "She done already done had herses.",
              "price": 51.89,
              "status": "canceled",
              "frequency": "weekly",
              "tea_id": 3,
              "customer_id": 1
          }
        }
      ]
    }
    ```

    **Status Code:** 200 :ok

    The list of the customer's subscriptions has successfully been retrieved.
  </details>

  <details>
    <summary>Successful Response (no subscriptions):</summary>

    ```
    {
      "data": []
    }
    ```

    **Status Code:** 200 :ok

    The customer has no subscriptions, so the data is a blank array.
  </details>
  
  <details>
    <summary>Invalid customer ID Error Response:</summary>

    ```
    {
      "errors": [
        {
            "details": "Couldn't find Customer with 'id'=123123123123"
        }
    ]
}
    ```

    **Status Code:** 404 :not_found 

    The customer ID was not found, so no records could be returned. The response contains the detailed error message.
  </details>
</details>

---