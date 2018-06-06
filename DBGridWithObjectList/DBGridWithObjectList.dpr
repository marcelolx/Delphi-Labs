program DBGridWithObjectList;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FrmMain},
  ViewTestObjectDataset in 'ViewTestObjectDataset.pas' {frmObjectDataSetTest},
  Customer in 'Customer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmObjectDataSetTest, frmObjectDataSetTest);
  Application.Run;
end.
