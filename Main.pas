unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus, Cat, CatRepository, NewCat;

type

  { TMainForm }

  TMainForm = class(TForm)
    ImageList1: TImageList;
    ListViewCats: TListView;
    MenuItemCatDispose: TMenuItem;
    Separator2: TMenuItem;
    MenuItemNewCat: TMenuItem;
    MenuItemRefreshSpace: TMenuItem;
    MenuItemCatFeed: TMenuItem;
    MenuItemCatPlay: TMenuItem;
    MenuItemCatCleanse: TMenuItem;
    PopupMenuSpace: TPopupMenu;
    Separator1: TMenuItem;
    MenuItemCatShow: TMenuItem;
    PopupMenuCat: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewCatsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MenuItemCatShowClick(Sender: TObject);
    procedure MenuItemNewCatClick(Sender: TObject);
    procedure MenuItemRefreshSpaceClick(Sender: TObject);
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

procedure TMainForm.ListViewCatsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button = mbRight then begin
    ListViewCats.Selected := ListViewCats.GetItemAt(x, y);
    if Assigned(ListViewCats.Selected) then begin
      PopupMenuCat.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    end else begin
      PopupMenuSpace.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    end;
  end;
end;

procedure TMainForm.MenuItemCatShowClick(Sender: TObject);
var
  cat: TCat;
  msg: String;
begin
  cat := TCat(ListViewCats.Selected.Data);
  msg := Format('Showing cat ''%s''', [cat.Name]);
  ShowMessage(msg);
end;

procedure TMainForm.MenuItemNewCatClick(Sender: TObject);
var
  newCatForm: TNewCatForm;
begin
  try
    newCatForm := TNewCatForm.Create(self);
    if newCatForm.ShowModal = mrOk then begin
      FCatRepository.NewCat(newCatForm.EditNewCatName.Text).Free;
      InvalidateListViewCats;
    end;
  finally
    newCatForm.Free;
  end;
end;

procedure TMainForm.MenuItemRefreshSpaceClick(Sender: TObject);
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

