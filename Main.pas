unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Cat, CatRepository;

type

  { TMainForm }

  TMainForm = class(TForm)
    ImageList1: TImageList;
    ListViewCats: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCatRepository: TCatRepository;
    procedure ResetListViewCats;
    procedure InvalidateListViewCats;
  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCatRepository := TCatRepository.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ResetListViewCats;
  FreeAndNil(FCatRepository);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  InvalidateListViewCats;
end;

procedure TMainForm.ResetListViewCats;
var
  item: TListItem;
begin
  while ListViewCats.Items.Count > 0 do begin
    item := ListViewCats.Items[0];
    TCat(item.Data).Free;
    ListViewCats.Items.Delete(0);
  end;
end;

procedure TMainForm.InvalidateListViewCats;
var
  catList: TList;
  cat: TCat;
  i: Integer;
  item: TListItem;
begin
  ResetListViewCats;
  catList := FCatRepository.FindAll;
  for i := 0 to catList.Count - 1 do begin
    cat := TCat(catList[i]);
    item := ListViewCats.Items.Add;
    item.Data := cat;
    item.ImageIndex := 0;
    item.Caption := cat.Name;
  end;
  catList.Free;
end;

end.

