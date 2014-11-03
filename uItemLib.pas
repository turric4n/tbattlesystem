unit uItemLib;

interface

uses
  uInventoryList,
  uInventoryType,
  uArmour,
  fgl,
  uWeapon;

type
  TItemLibrary = class(TObject)
    private
      //Delphi Compatibility
      //fWeaponDB : TObjectList<TWeapon>;
      //fArmorDB : TObjectList<TArmour>;
      fWeaponDB : TFPGObjectList<TWeapon>;
      fArmorDB : TFPGObjectList<TArmour>;
      function fForgeArmor(ArmorType: TArmorType): TArmour; 
    public
      constructor Create; overload;
      function NewArmor(Model: TArmorType): TArmour;
      function RandomArmor: TArmour;      
    end;

implementation

constructor TItemLibrary.Create;
var
  ArmorType: TArmorType;
begin
  //Delphi Compatibility
  //fWeaponDB:=TObjectList<TWeapon>.Create(True);
  //fArmorDB:=TObjectList<TArmour>.Create(True);
  fWeaponDB:=TFPGObjectList<TWeapon>.Create(True);
  fArmorDB:=TFPGObjectList<TArmour>.Create(True);
  for ArmorType := Low(TArmorType) to High(TArmorType) do
  begin
    fArmorDB.Add(fForgeArmor(ArmorType));
  end;    
end;

function TItemLibrary.fForgeArmor(ArmorType: TArmorType): TArmour;
begin
  case ArmorType of 
    TArmorType.None: Result:=TArmour.Create(10,0,0,0,0,'None',0,ArmorType);
    TArmorType.Leather: Result:=TArmour.Create(8,0,-2,0,0,'Leather Armour',150,ArmorType);
    TArmorType.StLeather: Result:=TArmour.Create(7,2,1,0,0,'Studded Leather Armour',250,ArmorType);
    TArmorType.Brigandine: Result:=TArmour.Create(6,1,1,0,0,'Brigandine Armour',350, ArmorType);
    TArmorType.ChainMail: Result:=TArmour.Create(5,2,0,-2,0,'Chain Mail',400, ArmorType);
    TArmorType.Banded: Result:=TArmour.Create(4,2,0,2,0,'Banded Mail',350, ArmorType);
    TArmorType.PlateMail: Result:=TArmour.Create(3,3,0,0,0,'Plate Mail',500, ArmorType);
    TArmorType.FieldPlate: Result:=TArmour.Create(2,3,1,0,0,'Field Plate Armour',600, ArmorType);
    TArmorType.FullPlate: Result:=TArmour.Create(1,4,3,0,0,'Full Plate Armour',700, ArmorType);
  end;
end;

function TItemLibrary.NewArmor(Model: TArmorType): TArmour;
begin
  Result:=fForgeArmor(Model);  
end;

function TItemLibrary.RandomArmor: TArmour;
begin
  Result:=TArmour.Create(Random(10),Random(4),Random(3),0,0, 'Randomized Armor',Random(800),TArmorType.Leather);
end;

end.
