unit ViewCat;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Cat;

type

  { TViewCatForm }

  TViewCatForm = class(TForm)
    Bevel1: TBevel;
    ButtonClose: TButton;
    ImageCatAvatar: TImage;
    LabelCatName: TLabel;
  private

  public
    procedure PrepareViewCat(ACat: TCat);
  end;

var
  ViewCatForm: TViewCatForm;

implementation

{$R *.lfm}

procedure TViewCatForm.PrepareViewCat(ACat: TCat);
begin
  LabelCatName.Caption := ACat.Name;
end;

end.

