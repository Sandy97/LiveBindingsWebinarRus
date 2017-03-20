program SB_LB03_Create_LB_in_Code;

uses
  Vcl.Forms,
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
