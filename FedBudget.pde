class FedBudget {
  int income;// in billions
  int expense;// in billions
  int proposedExpense;
  float debtIntRate;// interest rate of the national debt
  boolean shutdown;// if there is a gov shutdown
  Table budget;
  int[] funding;
  int[] proposedFunding;

  FedBudget() {
    budget = loadTable("startingbudget.csv", "header");
    expense = 0;
    funding = new int[budget.getRowCount()];
    proposedFunding = new int[budget.getRowCount()];
    for (int i = 0; i < budget.getRowCount(); i++) {
      funding[i] = Utils.convertInt(budget.getRow(i).getString(1));
      proposedFunding[i] = Utils.convertInt(budget.getRow(i).getString(1));
    }
    for (TableRow row : budget.rows())
      expense += Utils.convertInt(row.getString(1));
  }

  /* I needed a place to put info on this and stuff, it's good to separate all of it.
     How it goes:
       - Pres submits a budget between first Monday of September and first Monday of February
       - Houses of Congress then suggest their own budgets and meet to create a budget resolution.
       - This bill goes to the President who signs or vetos. Veto leads to shutdown unless temp. deal is reached.
       - Appropriations bills happen occasionally and will be put in 'ideas', and military appropriations can only be yearly
       - Budget goes into effect October 1st, or gov shutdown.
  */

  // updates the expenses of the budget
  // Precondition: proposedFunding is an array of all of the expenses of departments updated, proposedExpense is total
  // Postcondition: proposedExpense is the new total of the proposedFunding
  void updatePropExpense() {
    proposedExpense = 0;
    for (int i = 0; i < proposedFunding.length; i++)
      proposedExpense += proposedFunding[i];
  }



}
