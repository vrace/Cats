unit CatRepository;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cat;

type
  TCatRepository = class
  private
    FCats: TList;
    function FindNextId: Integer;
    function NewCatInternal(AName: String): TCat;
  public
    constructor Create;
    destructor Destroy; override;
    function FindAll: TList;
    function NewCat(AName: String): TCat;
  end;

implementation

constructor TCatRepository.Create;
begin
  inherited;
  FCats := TList.Create;
  // Default cat to play with
  NewCatInternal('MiMi');
  NewCatInternal('Potato');
end;

destructor TCatRepository.Destroy;
var
  cat: TCat;
begin
  while FCats.Count > 0 do begin
    cat := TCat(FCats[0]);
    cat.Free;
    FCats.Delete(0);
  end;
  FreeAndNil(FCats);
  inherited;
end;

function TCatRepository.FindAll: TList;
var
  i: Integer;
  cat: TCat;
begin
  Result := TList.Create;
  for i := 0 to FCats.Count - 1 do begin
    cat := TCat(FCats[i]);
    Result.Add(cat.Clone);
  end;
end;

function TCatRepository.NewCat(AName: String): TCat;
begin
  Result := NewCatInternal(AName).Clone;
end;

function TCatRepository.FindNextId: Integer;
var
  i: Integer;
  cat: TCat;
begin
  Result := 0;
  for i := 0 to FCats.Count - 1 do begin
    cat := TCat(FCats[i]);
    if Result < cat.Id then Result := cat.Id;
  end;
  Inc(Result);
end;

function TCatRepository.NewCatInternal(AName: String): TCat;
begin
  Result := TCat.Create;
  Result.Init(FindNextId, AName);
  FCats.Add(Result);
end;

end.

