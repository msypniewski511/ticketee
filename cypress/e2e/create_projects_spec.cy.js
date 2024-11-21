describe('Users can create new projects', () => {
  it('with valid attributes', () => {
    // Visit the root path
    cy.visit('/');

    // Click the "New Project" link
    cy.contains('New Project').click();

    // Fill in the form fields
    cy.get('input[name="Name"]').type('Visual Studio Code');
    cy.get('textarea[name="Description"]').type('Code Editing. Redefined');

    // Submit the form
    cy.contains('Create Project').click();

    // Assert that the success message appears
    cy.contains('Project has been created.').should('be.visible');
  });
});