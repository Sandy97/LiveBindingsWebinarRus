unit TadapterSourceSampleUnit01;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.Bind.Controls, FMX.Layouts, FMX.Bind.Navigator,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, Data.Bind.ObjectScope,
  Data.Bind.Components, EmployeeModel, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid,
  Data.Bind.GenData, Fmx.Bind.GenData, FMX.Edit;

type
  TForm3 = class(TForm)
    AdapterBindSource1: TAdapterBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    Grid1: TGrid;
    BindNavigator1: TBindNavigator;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceAdapterBindSource1: TLinkGridToDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
var
  LEmployee: TEmployee;
begin
  LEmployee := TEmployee.Create('John', 'Anders', 26, StrToDate('10.10.2011'),
     'Developer', 'Adrian Hermann');
  ABindSourceAdapter := TObjectBindSourceAdapter<TEmployee>.Create(Self, LEmployee);
end;

end.
