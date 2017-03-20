unit EmployeeModel;

interface

type
  { An Employee model object that will be adapted and enabled for LiveBindings usage. }
  TEmployee = class(TObject)
  private
    FFirstName: String;
    FLastName: String;
    FAge: Byte;
    FStartDate: TDate;
    FPosition: String;
    FManager: String;
  public
    constructor Create(const AFirstName, ALastName: String; const AAge: Byte;
      const AStartDate: TDate; const APosition, AManager: String); overload;
    property FirstName: String read FFirstName write FFirstName;
    property LastName: String read FLastName write FLastName;
    property Age: Byte read FAge write FAge;
    property StartDate: TDate read FStartDate write FStartDate;
    property Position: String read FPosition write FPosition;
    property Manager: String read FManager write FManager;
  end;

implementation

{ TEmployee }

constructor TEmployee.Create(const AFirstName, ALastName: String; const AAge: Byte;
  const AStartDate: TDate; const APosition, AManager: String);
begin
  inherited Create;
  FFirstName := AFirstName;
  FLastName := ALastName;
  FAge := AAge;
  FStartDate := AStartDate;
  FPosition := APosition;
  FManager := AManager;

end;

end.
