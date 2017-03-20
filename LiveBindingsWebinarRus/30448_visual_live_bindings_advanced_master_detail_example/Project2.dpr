program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  uVLBDetailAdvHelper in 'uVLBDetailAdvHelper.pas',
  uFoo in 'uFoo.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
