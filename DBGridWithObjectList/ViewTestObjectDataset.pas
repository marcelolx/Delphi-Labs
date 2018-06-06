unit ViewTestObjectDataSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, DB, StdCtrls, ComCtrls
  ,Spring.Data.ObjectDataSet
  ;

type
  TfrmObjectDataSetTest = class(TForm)
    dsList: TDataSource;
    dbgList: TDBGrid;
    DBNavigator1: TDBNavigator;
    edFilter: TEdit;
    cbFiltered: TCheckBox;
    sbTotal: TStatusBar;
    dbgClone: TDBGrid;
    Splitter1: TSplitter;
    dsClone: TDataSource;
    procedure edFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgListTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure cbFilteredClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgListColEnter(Sender: TObject);
    procedure dbgListColExit(Sender: TObject);
    procedure dbgListEnter(Sender: TObject);
    procedure dbgListExit(Sender: TObject);
    procedure dbgListEditButtonClick(Sender: TObject);
    procedure dsListDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FIndex: Integer;
    FDataset: TObjectDataSet;
  protected
    procedure DoAfterScroll(ADataset: TDataSet);
  public
    { Public declarations }

    property Dataset: TObjectDataSet read FDataset write FDataset;
  end;

var
  frmObjectDataSetTest: TfrmObjectDataSetTest;

implementation


{$R *.dfm}

procedure TfrmObjectDataSetTest.cbFilteredClick(Sender: TObject);
begin
  (dsList.DataSet as TObjectDataSet).Filtered := TCheckBox(Sender).Checked;
end;

procedure TfrmObjectDataSetTest.dbgListColEnter(Sender: TObject);
begin
  if Sender = dbgList.Columns.Items[0] then
    dsList.DataSet.FieldByName('Name').Value := dbgList.Columns.Items[0].Field.Value;
end;

procedure TfrmObjectDataSetTest.dbgListColExit(Sender: TObject);
begin
  if Sender = dbgList.Columns.Items[0] then
    dsList.DataSet.FieldByName('Name').Value := dbgList.Columns.Items[0].Field.Value;
end;

procedure TfrmObjectDataSetTest.dbgListEditButtonClick(Sender: TObject);
begin
 if Sender = dbgList.Columns.Items[0] then
    dsList.DataSet.FieldByName('Name').Value := dbgList.Columns.Items[0].Field.Value;
end;

procedure TfrmObjectDataSetTest.dbgListEnter(Sender: TObject);
begin
 if Sender = dbgList.Columns.Items[0] then
    dsList.DataSet.FieldByName('Name').Value := dbgList.Columns.Items[0].Field.Value;
end;

procedure TfrmObjectDataSetTest.dbgListExit(Sender: TObject);
begin
 if Sender = dbgList.Columns.Items[0] then
    dsList.DataSet.FieldByName('Name').Value := dbgList.Columns.Items[0].Field.Value;
end;

procedure TfrmObjectDataSetTest.dbgListTitleClick(Column: TColumn);
var
  sDir: string;
begin
  if FIndex mod 2 = 0 then
    sDir := ' ASC'
  else
    sDir := ' DESC';

  (dsList.DataSet as TObjectDataSet).Sort := Column.FieldName + sDir;
  Inc(FIndex);
end;

procedure TfrmObjectDataSetTest.DoAfterScroll(ADataset: TDataSet);
begin
  if ADataset.Active and not (ADataset.Eof or ADataset.Bof) then
  begin
    sbTotal.SimpleText := Format('%d from %d records. Filter: %d', [ADataset.RecNo, ADataset.RecordCount, FDataset.FilterCount]);
  end;
end;

procedure TfrmObjectDataSetTest.dsListDataChange(Sender: TObject; Field: TField);
begin
   //Nesse cara podem ser feitas verificações, tipo um "ControlCheck do que pode inserir

   if Sender = dbgList.Columns.Items[0] then
    dsList.DataSet.FieldByName('Name').Value := dbgList.Columns.Items[0].Field.Value;
end;

procedure TfrmObjectDataSetTest.edFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    dsList.DataSet.Filter := edFilter.Text;
  end;
end;

procedure TfrmObjectDataSetTest.FormCreate(Sender: TObject);
begin
  FIndex := 0;
end;

procedure TfrmObjectDataSetTest.FormShow(Sender: TObject);
begin
  Dataset.AfterScroll := DoAfterScroll;
end;

end.
