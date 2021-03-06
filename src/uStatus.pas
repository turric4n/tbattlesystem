unit uStatus;

interface

type
  TStatusTypes = (VALID = $01, UNCONSCIOUS = $40, DEAD = $80);

  TStatus = class(TObject)
    private
      fFlags: TStatusTypes;
    public
      constructor Create(flags: TStatusTypes = VALID);
      procedure setFlag(flag: TStatusTypes);
      procedure clearFlag(flag: TStatusTypes);
      function checkFlah(flag: TStatusTypes): Boolean;
  end;

implementation

constructor TStatus.Create(flags: TStatusTypes = VALID);
begin
  fFlags:=flags;
end;

procedure TStatus.setFlag(flag: TStatusTypes);
var
  i: TStatusTypes;
begin
  fFlags:=TStatusTypes(Integer(fFlags) or Integer(flag));
end;

procedure TStatus.clearFlag(flag: TStatusTypes);
begin
  fFlags:=TStatusTypes(Integer(fFlags) and not Integer(flag));
end;

function TStatus.checkFlah(flag: TStatusTypes): Boolean;
begin
  Result:=Integer(fFlags) = Integer(flag);
end;

end.
