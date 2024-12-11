Feature: Product Store Service Back-End
  As a Product Store Owner
  I need a RESTful catalog service
  So that I can keep track of all my products

Background:
  Given the following products exist:
    | name    | description     | price  | available | category   |
    | Hat     | A red fedora    | 59.95  | True      | CLOTHS     |
    | Shoes   | Blue shoes      | 120.50 | False     | CLOTHS     |
    | Big Mac | 1/4 lb burger   | 5.99   | True      | FOOD       |
    | Sheets  | Full bed sheets | 87.00  | True      | HOUSEWARES |

Scenario: Verify the server is running
  When I visit the "Home Page"
  Then the page title should be "Product Catalog Administration"
  And I should not see "404 Not Found"

Scenario: Create a Product
  When I visit the "Home Page"
  And I set the "Name" to "Hammer"
  And I set the "Description" to "Claw hammer"
  And I select "True" in the "Available" dropdown
  And I select "Tools" in the "Category" dropdown
  And I set the "Price" to "34.95"
  And I press the "Create" button
  Then I should see the message "Success"
  When I retrieve the product by ID
  Then the product details should be:
    | name       | description  | price  | available | category |
    | Hammer     | Claw hammer  | 34.95  | True      | Tools    |

Scenario: Update a Product
  When I visit the "Home Page"
  And I search for "Hat" by Name
  And I update the "Name" to "Fedora"
  And I press the "Update" button
  Then I should see the message "Success"
  When I retrieve the product by ID
  Then the product name should be "Fedora"

Scenario: Delete a Product
  When I search for "Hat" by Name
  And I delete the product by ID
  Then I should see the message "Product has been Deleted!"
  And the product should no longer appear in search results

Scenario: List all products
  When I visit the "Home Page"
  And I retrieve all products
  Then the following products should be listed:
    | name    | description     | price  | available | category   |
    | Hat     | A red fedora    | 59.95  | True      | CLOTHS     |
    | Shoes   | Blue shoes      | 120.50 | False     | CLOTHS     |
    | Big Mac | 1/4 lb burger   | 5.99   | True      | FOOD       |
    | Sheets  | Full bed sheets | 87.00  | True      | HOUSEWARES |

Scenario: Search by category
  When I select "Food" in the "Category" dropdown
  And I press the "Search" button
  Then I should see the following products:
    | name    | description   | price  | available | category |
    | Big Mac | 1/4 lb burger | 5.99   | True      | FOOD     |

Scenario: Search by available status
  When I select "True" in the "Available" dropdown
  And I press the "Search" button
  Then the following products should appear:
    | name    | description     | price  | available | category   |
    | Hat     | A red fedora    | 59.95  | True      | CLOTHS     |
    | Big Mac | 1/4 lb burger   | 5.99   | True      | FOOD       |
    | Sheets  | Full bed sheets | 87.00  | True      | HOUSEWARES |

Scenario: Search by name
  When I search for "Hat" by Name
  Then the product details should be:
    | name    | description  | price  | available | category |
    | Hat     | A red fedora | 59.95  | True      | CLOTHS   |
