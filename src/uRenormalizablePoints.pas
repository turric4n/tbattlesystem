
{/***************************************************************************
                          uRenormalizablePoints.pas  -  description
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

{/**A points structure in which there is a current value and a normal value}

unit uRenormalizablePoints;

interface

type

TRenormalizablePoints = class(TObject)
  private
    pCurrent, pNormal: Integer;
    procedure SetCurrent(const val: Integer);
    function GetCurrent: Integer;
    procedure SetNormal(const val: Integer);
    function GetNormal: Integer;
  public
    constructor Create(const Val: Integer = 0); overload;
    procedure MakeNormal;
    property Current: Integer read GetCurrent write SetCurrent;
    property Normal: Integer read GetNormal write SetNormal;
    procedure Incr(const value: Integer); overload;
    procedure Decr(const value: Integer); overload;
    procedure Incr; overload;
    procedure Decr; overload;
    function Multiply(const value: Integer): Integer;
    function Divisor(const value: Integer): Integer;
    function Percentile(const value: Integer): Integer;
    function LessOrEqual(const value: Integer): Boolean; overload;
    function LessOrEqual(RenormalizablePoints: TRenormalizablePoints): Boolean; overload;
    function LessThan(const value: Integer): Boolean; overload;
    function LessThan(RenormalizablePoints: TRenormalizablePoints): Boolean; overload;
    function Equal(const value: Integer): Boolean; overload;
    function Equal(RenormalizablePoints: TRenormalizablePoints): Boolean; overload;
    function notEqual(const value: Integer): Boolean; overload;
    function notEqual(RenormalizablePoints: TRenormalizablePoints): Boolean; overload;
    function GreaterOrEqual(const value: Integer): Boolean; overload;
    function GreaterOrEqual(RenormalizablePoints: TRenormalizablePoints): Boolean; overload;
end;

implementation

constructor TRenormalizablePoints.Create(const Val: Integer = 0);
begin
  pCurrent:=val;
  pNormal:=val;
end;

procedure TRenormalizablePoints.SetCurrent(const val: Integer);
begin
  pCurrent:=val;
end;

procedure TRenormalizablePoints.SetNormal(const val: Integer);
begin
  pNormal:=val;
end;

function TRenormalizablePoints.GetCurrent: Integer;
begin
  Result:=pCurrent;
end;

procedure TRenormalizablePoints.MakeNormal;
begin
  pNormal:=pCurrent;
end;

function TRenormalizablePoints.LessOrEqual(const value: Integer): Boolean;
begin
  Result:=pCurrent <= value;
end;

function TRenormalizablePoints.LessOrEqual(RenormalizablePoints: TRenormalizablePoints): Boolean;
begin
  Result:=pCurrent <= RenormalizablePoints.pCurrent;
end;

function TRenormalizablePoints.LessThan(const value: Integer): Boolean;
begin
  Result:=pCurrent < value;
end;

function TRenormalizablePoints.LessThan(RenormalizablePoints: TRenormalizablePoints): Boolean;
begin
  Result:=pCurrent < RenormalizablePoints.pCurrent;
end;

function TRenormalizablePoints.Equal(const value: Integer): Boolean;
begin
  Result:=pCurrent = value;
end;

function TRenormalizablePoints.Equal(RenormalizablePoints: TRenormalizablePoints): Boolean;
begin
  Result:=pCurrent = RenormalizablePoints.pCurrent;
end;

function TRenormalizablePoints.notEqual(const value: Integer): Boolean;
begin
  Result:=pCurrent <> value;
end;

function TRenormalizablePoints.notEqual(RenormalizablePoints: TRenormalizablePoints): Boolean;
begin
  Result:=pCurrent <> RenormalizablePoints.pCurrent;
end;

function TRenormalizablePoints.GreaterOrEqual(const value: Integer): Boolean;
begin
  Result:=pCurrent >= value;
end;

function TRenormalizablePoints.GreaterOrEqual(RenormalizablePoints: TRenormalizablePoints): Boolean;
begin
  Result:=pCurrent >= RenormalizablePoints.pCurrent;
end;

procedure TRenormalizablePoints.Incr(const value: Integer);
begin
  Inc(pCurrent,value);
end;

procedure TRenormalizablePoints.Decr(const value: Integer);
begin
  Dec(pCurrent,value);
end;

procedure TRenormalizablePoints.Incr;
begin
  Inc(pCurrent);
end;

procedure TRenormalizablePoints.Decr;
begin
  Dec(pCurrent);
end;

function TRenormalizablePoints.GetNormal;
begin
  Result:=pNormal;
end;

function TRenormalizablePoints.Multiply(const value: Integer): Integer;
begin
  Result:=Current * value;
end;

function TRenormalizablePoints.Divisor(const value: Integer): Integer;
begin
  Result:=Current div value;

end;

function TRenormalizablePoints.Percentile(const value: Integer): Integer;
begin
  Current:=Current mod value;

end;

end.
