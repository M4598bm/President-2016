class Country {

  String name;
  ArrayList<String> relationships;//Country's relationships
  ArrayList<Integer> relations;//Parallel to relationships array. 0 = Bad relations, 100 = good relations
  int militarism;//Feeling towards military action.
  boolean isSecurity;//Is part of security counsel
  ArrayList<String> proidea;//Ideas they have approved of
  ArrayList<String> conidea;//Ideas they are against

  //Constructor
  //Precondition:
  //Postcondition:Creates an empty country
  void Country() {

  }

  //Constructor
  //Precondition:Name,militarism rating,isSecurity boolean
  //Postcondition:Creates an country with name,militarism, and isSecurity
  void setCountry(String n, int mil, boolean iss) {
    name = n;
    militarism = mil;
    isSecurity = iss;
  }

  //Constructor
  //Precondition:Countries that host country has relations with and their relationship ratings
  //Postcondition:Initializes relationships and relations array
  void setRelations(String rel) {

    relationships.add(rel);
    relations.add(int(random(100)));

  }
  void setRelations(String rel, int relation) {
    for (int i = -1; i < relationships.size(); i++) {
      if (rel.equals(relationships.get(i))) {
        relations.set(i,relation);
      }
    }

  }

}
