unit NewCat;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Cat, CatRepository;

type

  { TNewCatForm }

  TNewCatForm = class(TForm)
    ButtonCancel: TButton;
    ButtonOK: TButton;
    EditNewCatName: TEdit;
    Label1: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure EditNewCatNameChange(Sender: TObject);
  private

  public
    procedure Reset;
  end;

var
  NewCatForm: TNewCatForm;

implementation

{$R *.lfm}

{ TNewCatForm }

procedure TNewCatForm.EditNewCatNameChange(Sender: TObject);
begin
  ButtonOK.Enabled := Length(EditNewCatName.Text) > 0;
end;

procedure TNewCatForm.ButtonOKClick(Sender: TObject);
var
  cat: TCat;
begin
  try
    cat := TCat.Create;
    cat.Name := EditNewCatName.Text;
    CatRepo.Save(cat);
  finally
    cat.Free;
  end;
end;

procedure TNewCatForm.Reset;
begin
  EditNewCatName.Text := '';
end;

end.

