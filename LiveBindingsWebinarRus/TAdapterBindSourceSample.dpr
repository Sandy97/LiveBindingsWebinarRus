program TAdapterBindSourceSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  TadapterSourceSampleUnit01 in 'TadapterSourceSampleUnit01.pas' {Form3},
  EmployeeModel in 'EmployeeModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
