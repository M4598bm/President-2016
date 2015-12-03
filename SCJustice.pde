class SCJustice {
  String name;
  int socialism;// 0 capitalist, 100 socialist
  int liberalism;// 0 conservative, 100 liberal
  char party;
  boolean chief;
  
  SCJustice(String n,int s, int l, char p,boolean leader) {
    socialism = s;
    liberalism = l;
    party = p;
    name = n;
    chief=leader;
  }
  
  
  
}
