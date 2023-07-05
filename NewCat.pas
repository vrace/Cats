unit NewCat;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TNewCatForm }

  TNewCatForm = class(TForm)
    ButtonCancel: TButton;
    ButtonOK: TButton;
    EditNewCatName: TEdit;
    Label1: TLabel;
    procedure EditNewCatNameChange(Sender: TObject);
  private

  public

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

end.

