program Cats;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Classes, SysUtils,
  Interfaces, // this includes the LCL widgetset
  Forms, Main, Cat, CatRepository, NewCat, ViewCat;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  CatRepo := TCatRepository.Create;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TNewCatForm, NewCatForm);
  Application.CreateForm(TViewCatForm, ViewCatForm);
  Application.Run;
  FreeAndNil(CatRepo);
end.

