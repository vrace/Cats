unit Cat;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TCat = class
  private
    FId: Integer;
    FName: String;
  public
    function CopyValuesTo(ACat: TCat): TCat;
  published
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
  end;

implementation

function TCat.CopyValuesTo(ACat: TCat): TCat;
begin
  if ACat <> self then begin
    ACat.FName := FName;
  end;
  Result := ACat;
end;

end.

