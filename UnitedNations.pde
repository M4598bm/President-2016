class UnitedNations{
  String name;//Country name
  ArrayList<String> relationships;//Countries that host country has relations with
  ArrayList<Integer> approval;//Relations with said countries(Both arrays will be parallel)(0-100)
  int militarism;//Support for military action(0-100)
  int relations;//Support of the U.S(-100---100)
  boolean isSecurity;//Is part of security counsel
  ArrayList<String> proidea;//Ideas they have approved of
  ArrayList<String> conidea;//Ideas they are against
  static ArrayList<String> Security;//Security Council
  UnitedNations(String n,ArrayList<String> r,ArrayList<Integer> a,int m,int rus,boolean sec,ArrayList<String> pro,ArrayList<String> con)
    {
    name=n;
    relationships=r;
    approval=a;
    militarism=m;
    relations=rus;
    isSecurity=sec;
    proidea=pro;
    conidea=con;
    if (sec=true)
      {Security.add(this);
      }
  //Constructs the nation and adds the nation to the security council if part of it.  
    }
  











}
