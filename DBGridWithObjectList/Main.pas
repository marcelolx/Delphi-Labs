unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Spring.Data.ObjectDataSet,
  Customer,
  Spring.Collections,
  Spring.Persistence.Mapping.Attributes;

type
  TFrmMain = class(TForm)
    btnGridTests: TButton;
    procedure btnGridTestsClick(Sender: TObject);
  private
    FDataset: TObjectDataSet;

    function CreateCustomersList(ASize: Integer = 10): IList<TCustomer>; virtual;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  ViewTestObjectDataSet;

{$R *.dfm}


procedure TFrmMain.btnGridTestsClick(Sender: TObject);
var
  LView: TfrmObjectDataSetTest;
  LCustomers: IList<TCustomer>;
  LClonedDataset: TObjectDataSet;
begin
  LCustomers := CreateCustomersList(1000);
  LCustomers.First.Age := 2;
  LCustomers.First.Name := 'Bob';
  FDataset := TObjectDataSet.Create(nil);
  FDataset.ColumnAttributeClass := ColumnAttribute;
  FDataset.DataList := LCustomers as IObjectList;
  FDataset.Open;
  LView := TfrmObjectDataSetTest.Create(nil);
  LClonedDataset := TObjectDataSet.Create(nil);
  LClonedDataset.ColumnAttributeClass := ColumnAttribute;
  try
    LView.Dataset := FDataset;
    LView.dsList.DataSet := FDataset;

  //  FDataset.Sort := 'Age Desc, NAME';
    FDataset.Filtered := True;

    LClonedDataset.Clone(FDataset);
    LView.dsClone.DataSet := LClonedDataset;

    LView.ShowModal;
  finally
    LView.Free;
    LClonedDataset.Free;
  end;
end;



function TFrmMain.CreateCustomersList(ASize: Integer): IList<TCustomer>;
var
  LCustomer: TCustomer;
  i: Integer;
begin
  Result := TCollections.CreateObjectList<TCustomer>(True);
  for i := 1 to ASize do
  begin
    LCustomer := TCustomer.Create;
    LCustomer.Name := 'FirstName';
    LCustomer.Age := i;
    LCustomer.EMail := 'aaa@aaa.com';
    LCustomer.Height := 100.5;
    Result.Add(LCustomer);
  end;
end;

end.
