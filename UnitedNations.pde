class UnitedNations{
  
  Country[] Countries;//Countries
  
  
  

  UnitedNations(String name){Country[] c=new Country[193];
  Table security = loadTable("Countryrelations.csv", "header");
  Table countries = loadTable("countries.csv", "header");
  for (int i = 0; i < countries.getRowCount(); i++){
  TableRow r = countries.getRow(i);
  c[i].setCountry(r.getString(0),int(random(100)),false);
  for (int j = 0; j < countries.getRowCount(); j++){TableRow h=countries.getRow(j);
  c[i].setRelations(h.getString(0));
  
  }
  
  
  
  }
  
  
  
  }









}
