object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 438
  ClientWidth = 969
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gridpnlMain: TGridPanel
    Left = 0
    Top = 0
    Width = 969
    Height = 438
    Align = alClient
    Caption = 'gridpnlMain'
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = strGridTransaction
        Row = 0
      end
      item
        Column = 0
        Control = memDisplay
        Row = 1
      end
      item
        Column = 1
        Control = pnlMain
        Row = 0
      end>
    RowCollection = <
      item
        Value = 36.571428571428570000
      end
      item
        Value = 27.428571428571430000
      end
      item
        SizeStyle = ssAuto
        Value = 25.000000000000000000
      end
      item
        Value = 16.000000000000000000
      end
      item
        Value = 20.000000000000000000
      end>
    TabOrder = 0
    object strGridTransaction: TStringGrid
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 473
      Height = 149
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Anchors = []
      ColCount = 7
      RowCount = 2
      FixedRows = 0
      TabOrder = 0
      RowHeights = (
        24
        24)
    end
    object memDisplay: TMemo
      AlignWithMargins = True
      Left = 6
      Top = 165
      Width = 473
      Height = 109
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Anchors = []
      Lines.Strings = (
        'memDisplay')
      TabOrder = 1
    end
    object pnlMain: TPanel
      AlignWithMargins = True
      Left = 489
      Top = 6
      Width = 474
      Height = 149
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'pnlMain'
      TabOrder = 2
      DesignSize = (
        474
        149)
      object lblnbTransaction: TLabel
        Left = 14
        Top = 14
        Width = 111
        Height = 13
        Caption = 'Number Of Transaction'
      end
      object Bevel1: TBevel
        Left = -2
        Top = 0
        Width = 226
        Height = 50
      end
      object btnResult: TButton
        AlignWithMargins = True
        Left = 344
        Top = 112
        Width = 121
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Anchors = [akRight, akBottom]
        Caption = 'Result'
        TabOrder = 0
        OnClick = btnResultClick
      end
      object SpedtTransaction: TSpinEdit
        Left = 135
        Top = 11
        Width = 81
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
  end
  object ActionList1: TActionList
    Left = 113
    Top = 72
    object actClear: TAction
      Category = 'Action'
      Caption = 'Clear'
      ShortCut = 16451
    end
    object actSolution: TAction
      Category = 'Action'
      Caption = 'Solution'
      ShortCut = 16452
    end
    object actOpenFile: TAction
      Category = 'File'
      Caption = 'Open File(s)...'
    end
    object actShowInExplorer: TAction
      Caption = 'Show in Explorer'
    end
    object actOpenFolder: TAction
      Category = 'File'
      Caption = 'Open Folder(s)...'
    end
    object actExit: TAction
      Category = 'File'
      Caption = 'Exit'
      OnExecute = actExitExecute
    end
    object actCopyToClipboard: TAction
      Category = 'Edit'
      Caption = 'Copy to Clipboard'
      ShortCut = 16451
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = 'Refresh'
      ShortCut = 116
    end
    object actOption: TAction
      Category = 'Option'
      Caption = 'Option'
      ShortCut = 16463
    end
    object actAbout: TAction
      Category = 'About'
      Caption = 'Info'
      ShortCut = 16457
      OnExecute = actAboutExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 48
    object File1: TMenuItem
      Caption = 'File'
      object OpenFiles1: TMenuItem
        Action = actOpenFile
      end
      object OpenFolders1: TMenuItem
        Action = actOpenFolder
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actExit
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object CopytoClipboard1: TMenuItem
        Action = actCopyToClipboard
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Refresh1: TMenuItem
        Action = actRefresh
      end
    end
    object A1: TMenuItem
      Caption = 'Action'
      object C1: TMenuItem
        Action = actClear
      end
      object miSolution: TMenuItem
        Action = actSolution
        Enabled = False
        ShortCut = 16467
      end
    end
    object Option1: TMenuItem
      Caption = 'Option'
      object actOption1: TMenuItem
        Action = actOption
      end
    end
    object A2: TMenuItem
      Caption = 'About'
      object actAbout1: TMenuItem
        Action = actAbout
      end
    end
  end
end
