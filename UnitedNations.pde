class UnitedNations{
  
  String[] Name;//Country Names
  int[] approval;//countries relations with US(Both arrays will be parallel)(0-100)
  int[] militarism;//Support for military action(0-100)
  
  boolean isSecurity;//Is part of security counsel
  ArrayList<String> proidea;//Ideas they have approved of
  ArrayList<String> conidea;//Ideas they are against
  Boolean issec;

  UnitedNations(String[] Countries, int[] app,int[] mil, boolean sec, ArrayList<String> pro, ArrayList<String> con) {
    Name=Countries;
    approval=app;
    militarism=mil;
    //relations=rus;
    isSecurity=sec;
    proidea=pro;
    conidea=con;
    //if (sec=true)
    //   {Security.add(this);
    //  }
  //Constructs the nation and adds the nation to the security council if part of it.
  }
  
  












}