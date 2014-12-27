{/***************************************************************************
                          uMoneyHolder.pas  -  description
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
unit uMoneyHolder;

interface

type

TMoneyHolder = class(TObject)
  public
    constructor Create(gold, silver, cooper: Integer);
    function numGP: Integer;
    function rawAmount: Integer;
    function isEmpty: Boolean;
    procedure insertCoin(gold, silver, cooper: Integer);
    procedure removeCoin(gold, silver, cooper: Integer);
    procedure transferMoney(into: TMoneyHolder; gold, silver, cooper: Integer);
  protected
    fCoins: LongInt;
  private
    function lump(gp, sp, cp: Integer): LongInt;
    procedure add(cp: LongInt);
    function subtract(cp: LongInt): Boolean;

end;

implementation

constructor TMoneyHolder.Create(gold: Integer; silver: Integer; cooper: Integer);
begin
  inherited Create;
  fCoins:=lump(gold,silver,cooper);
end;

function TMoneyHolder.numGP: Integer;
begin
  Result:=fCoins div 100;
end;

function TMoneyHolder.rawAmount: Integer;
begin
  Result:=fCoins;
end;

function TMoneyHolder.isEmpty: Boolean;
begin
  Result:=fCoins = 0;
end;

procedure TMoneyHolder.insertCoin(gold: Integer; silver: Integer; cooper: Integer);
begin
  add(lump(gold,silver,cooper));
end;

procedure TMoneyHolder.removeCoin(gold: Integer; silver: Integer; cooper: Integer);
begin
  subtract(lump(gold,silver,cooper));
end;

procedure TMoneyHolder.transferMoney(into: TMoneyHolder; gold: Integer; silver: Integer; cooper: Integer);
var
  amount: Integer;
begin
  amount:=lump(gold,silver,cooper);
  into.insertCoin(amount,0,0);
  removeCoin(amount,0,0);
end;

procedure TMoneyHolder.add(cp: Integer);
begin
  Inc(fcoins,cp);
end;

function TMoneyHolder.subtract(cp: Integer): Boolean;
begin
  if cp > fCoins then Result:=False
  else
  begin
    Dec(fcoins,cp);
    Result:=True;
  end;
end;

function TMoneyHolder.lump(gp: Integer; sp: Integer; cp: Integer): LongInt;
begin
  Result:=gp*100 + sp*100 + cp;
end;


end.
