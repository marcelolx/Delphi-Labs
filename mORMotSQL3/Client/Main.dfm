object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'mORMot - Cliente ORM com SQLite3'
  ClientHeight = 456
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnConectar: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 0
    OnClick = BtnConectarClick
  end
  object grpPessoa: TGroupBox
    Left = 8
    Top = 39
    Width = 289
    Height = 402
    TabOrder = 1
    object lblId: TLabel
      Left = 16
      Top = 11
      Width = 14
      Height = 13
      Caption = 'Id:'
    end
    object lblNome: TLabel
      Left = 16
      Top = 48
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lblIdade: TLabel
      Left = 15
      Top = 80
      Width = 32
      Height = 13
      Caption = 'Idade:'
    end
    object EdtId: TEdit
      Left = 36
      Top = 8
      Width = 61
      Height = 21
      TabOrder = 0
    end
    object btnBuscar: TButton
      Left = 103
      Top = 8
      Width = 75
      Height = 21
      Caption = 'Buscar'
      TabOrder = 1
      OnClick = btnBuscarClick
    end
    object EdtNome: TEdit
      Left = 53
      Top = 45
      Width = 196
      Height = 21
      TabOrder = 2
    end
    object EdtIdade: TEdit
      Left = 53
      Top = 77
      Width = 60
      Height = 21
      TabOrder = 3
    end
    object btnSalvar: TButton
      Left = 174
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = btnSalvarClick
    end
    object btnDeletar: TButton
      Left = 93
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Deletar'
      TabOrder = 5
      OnClick = btnDeletarClick
    end
    object Pnl1: TPanel
      Left = 3
      Top = 135
      Width = 275
      Height = 258
      TabOrder = 6
      object btnIterar: TButton
        Left = 6
        Top = 4
        Width = 75
        Height = 25
        Caption = 'Iterar'
        TabOrder = 0
        OnClick = btnIterarClick
      end
      object MemPessoas: TMemo
        Left = 6
        Top = 35
        Width = 259
        Height = 214
        TabOrder = 1
      end
    end
  end
  object PnlGrid: TPanel
    Left = 312
    Top = 8
    Width = 361
    Height = 433
    TabOrder = 2
    object GridPessoas: TDrawGrid
      Left = 12
      Top = 42
      Width = 337
      Height = 382
      TabOrder = 0
    end
    object btnAtualizar: TButton
      Left = 12
      Top = 8
      Width = 337
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 1
      OnClick = btnAtualizarClick
    end
  end
end
