{/***************************************************************************
                          uWeapon.pas  -  description
                             -------------------
    begin                : Wed Jan 28 2014
    copyright            : (C) 2014 by Enrique Fuentes
    email                : deejaykike@gmail.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 }
unit uWeapon;

interface

uses
  uInventoryType,
  uDice;

type
  TWeapon = class(TInventoryItem)
    private
      fNumdice,fDicesides,fPlusminus,fSpeed: Integer;
      fDamageType: TDamageTypes;
      FEquipped: Boolean;
    public
      constructor Create; overload;
      constructor Create(Speed, Dice, Sides, bonus: Integer; DT: TDamageTypes; Name: string; Weight: Integer); overload;
      constructor Create(Model: TWeapon); overload;
      property Speed: Integer read fspeed;
      property DT: TDamageTypes read fDamageType;
      function isMagic: Boolean;
      function returnDamage: Integer;
      function getType: TInventoryType;
      function getPluses: Integer;
    end;

implementation

constructor TWeapon.Create;
begin
  inherited Create('Fists',0,True,False,False);
  fSpeed:=2;
  fDamageType:=TDamageTypes.Blundgeon;
  fNumdice:=1;
  fDicesides:=2;
  fPlusminus:=0;
  fInventoryType:=TInventoryType.Weapon;
end;

constructor TWeapon.Create(Speed: Integer; Dice: Integer; Sides: Integer; bonus: Integer; DT: TDamageTypes; Name: string; Weight: Integer);
begin
  inherited Create(name, Weight, True,False,False);
  fSpeed:=Speed;
  fDamageType:=DT;
  fNumdice:=Dice;
  fDicesides:=sides;
  fPlusminus:=bonus;
  fInventoryType:=TInventoryType.Weapon;
end;

constructor TWeapon.Create(Model: TWeapon);
begin
  inherited Create(Model.Name, model.Weight,True,False,False);
  fSpeed:=Model.Speed;
  fDamageType:=model.fDamageType;
  fNumdice:=model.fNumdice;
  fDicesides:=model.fDicesides;
  fPlusminus:=model.fPlusminus;
  fInventoryType:=fInventoryType;
end;

function TWeapon.isMagic: Boolean;
begin
  Result:=False;
end;

function TWeapon.getPluses: Integer;
begin
  Result:=fPlusminus;
end;

function TWeapon.returnDamage;
begin
  Result:=TDice.Dice(fNumdice,fDicesides,fPlusminus);
end;

function TWeapon.getType;
begin
  Result:=fInventoryType;
end;

end.
