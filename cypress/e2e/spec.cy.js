const { count, Console } = require("console")

describe('Resume JS tests', () => {
  it('Tests me visiting the site', () => {
    cy.visit('https://www.jazmresume.com')
  })
  
})

describe('API Test', () => {
  it('Tests the POST API Call', () => {
    cy.request('POST', 'https://a39k36sm6e.execute-api.us-east-2.amazonaws.com/default/UpdateVisitors', ).then(
  (response) => {
    // response.body is automatically serialized into JSON
    expect(response.status).to.eq(200)

    var dataInt = parseInt(response.body.Visitors);
    expect(response.body.Visitors).to.not.be.oneOf([null, "", undefined])
    expect(parseInt(response.body.Visitors)).equal(dataInt);
  }
  )
})
})

/*describe('Page Reload', () => {
  it('Tests Visitor Counter incrementing after page refresh', () => {
    cy.visit('https://www.jazmresume.com')
    cy.request('GET', 'https://a39k36sm6e.execute-api.us-east-2.amazonaws.com/default/UpdateVisitors', ).then(
      (response) => {
        // response.body is automatically serialized into JSON
        expect(response.status).to.eq(200)
    
        var dataInt = parseInt(response.body.Visitors);
        expect(response.body.Visitors).to.not.be.oneOf([null, "", undefined]);
      

        cy.get("[id=counter]").as("counter");

        cy.get("@counter").should("contain", dataInt + 1);


      }
    
    )

  })
  
})
*/

  
