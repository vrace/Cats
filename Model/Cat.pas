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
    procedure Init(AId: Integer; AName: String);
    function Clone: TCat;
  published
    property Id: Integer read FId;
    property Name: String read FName write FName;
  end;

implementation

procedure TCat.Init(AId: Integer; AName: String);
begin
  FId := AId;
  FName := AName;
end;

function TCat.Clone: TCat;
begin
  Result := TCat.Create;
  Result.FId := FId;
  Result.FName := FName;
end;

end.

