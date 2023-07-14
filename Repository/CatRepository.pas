unit CatRepository;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Cat;

type
  TCatRepository = class
  private
    FCatList: TList;
    function FindNextId: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function FindAll(ACatList: TList): TList;
    function FindById(AId: Integer): TCat;
    function Save(ACat: TCat): TCat;
  end;

var
  CatRepo: TCatRepository;

implementation

constructor TCatRepository.Create;
var
  cat: TCat;
begin
  FCatList := TList.Create;

  try
    cat := TCat.Create;

    cat.Name := 'MiMi';
    Save(cat);

    cat.Name := 'Potato';
    Save(cat);
  finally
    cat.Free;
  end;
end;

destructor TCatRepository.Destroy;
var
  p: Pointer;
begin
  for p in FCatList do TCat(p).Free;
  FreeAndNil(FCatList);
  inherited;
end;

function TCatRepository.FindAll(ACatList: TList): TList;
begin
  ACatList.AddList(FCatList);
  Result := ACatList;
end;

function TCatRepository.FindById(AId: Integer): TCat;
var
  p: Pointer;
begin
  Result := nil;
  for p in FCatList do begin
    if TCat(p).Id = AId then begin
      Result := TCat(p);
      Exit;
    end;
  end;
end;

function TCatRepository.Save(ACat: TCat): TCat;
begin
  Result := FindById(ACat.Id);
  if not Assigned(Result) then begin
    Result := TCat.Create;
    Result.Id := FindNextId;
    FCatList.Add(Result);
  end;
  ACat.CopyValuesTo(Result);
end;

function TCatRepository.FindNextId: Integer;
var
  p: Pointer;
  cat: TCat;
begin
  Result := 0;
  for p in FCatList do begin
    cat := TCat(p);
    if Result < cat.Id then Result := cat.Id;
  end;
  Inc(Result);
end;

end.

