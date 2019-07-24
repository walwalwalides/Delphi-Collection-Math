object frmMain: TfrmMain
  Left = 902
  Top = 106
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 644
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  DesignSize = (
    746
    644)
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 168
    Width = 721
    Height = 329
    OnMouseDown = PaintBox1MouseDown
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
  end
  object msglabel: TLabel
    Left = 8
    Top = 624
    Width = 721
    Height = 25
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object GrBoxSolve: TGroupBox
    Left = 280
    Top = 503
    Width = 185
    Height = 105
    Caption = 'Number :'
    TabOrder = 0
    object solutionBtn: TSpeedButton
      Left = 55
      Top = 59
      Width = 82
      Height = 38
      Cursor = crHandPoint
      Hint = 'add new digits'
      GroupIndex = 1
      Caption = 'Solution'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = solutionBtnClick
    end
    object edtNumber: TEdit
      AlignWithMargins = True
      Left = 22
      Top = 18
      Width = 141
      Height = 21
      Margins.Left = 20
      Margins.Right = 20
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 2
      ParentFont = False
      TabOrder = 0
      Text = 'edtNumber'
      OnChange = edtNumberChange
      OnKeyDown = edtNumberKeyDown
      ExplicitLeft = 64
      ExplicitWidth = 116
    end
  end
  object GrBoxDimension: TGroupBox
    Left = 227
    Top = 82
    Width = 292
    Height = 80
    Caption = 'Dimension'
    TabOrder = 1
    object hminBtn: TSpeedButton
      Tag = 2
      Left = 112
      Top = 49
      Width = 23
      Height = 22
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnMouseDown = hplusBtnMouseDown
      OnMouseUp = hplusBtnMouseUp
    end
    object hplusBtn: TSpeedButton
      Tag = 1
      Left = 112
      Top = 26
      Width = 23
      Height = 22
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnMouseDown = hplusBtnMouseDown
      OnMouseUp = hplusBtnMouseUp
    end
    object Label1: TLabel
      Left = 33
      Top = 16
      Width = 53
      Height = 15
      Caption = 'horizontal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 167
      Top = 16
      Width = 38
      Height = 15
      Caption = 'vertical'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object vminBtn: TSpeedButton
      Tag = 4
      Left = 231
      Top = 49
      Width = 23
      Height = 22
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnMouseDown = hplusBtnMouseDown
      OnMouseUp = hplusBtnMouseUp
    end
    object vplusBtn: TSpeedButton
      Tag = 3
      Left = 231
      Top = 26
      Width = 23
      Height = 22
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnMouseDown = hplusBtnMouseDown
      OnMouseUp = hplusBtnMouseUp
    end
    object StaticText1: TStaticText
      Left = 33
      Top = 34
      Width = 73
      Height = 25
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = '15'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText2: TStaticText
      Left = 152
      Top = 34
      Width = 73
      Height = 25
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = '10'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object GrBoxIni: TGroupBox
    Left = 544
    Top = 57
    Width = 185
    Height = 105
    Anchors = [akTop, akRight]
    Caption = 'Initialization'
    TabOrder = 2
    object gridBtn: TSpeedButton
      Left = 51
      Top = 12
      Width = 82
      Height = 38
      Cursor = crHandPoint
      Hint = 'draw new grid'
      GroupIndex = 1
      Down = True
      Caption = 'Mark'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = gridBtnClick
    end
    object clearBtn: TBitBtn
      Left = 52
      Top = 56
      Width = 82
      Height = 38
      Cursor = crHandPoint
      Caption = 'clear'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = clearBtnClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 352
    Top = 32
  end
  object SaveDialog1: TSaveDialog
    Left = 216
    Top = 24
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 333
    OnTimer = Timer1Timer
    Left = 88
    Top = 24
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
  object ActionList1: TActionList
    Left = 113
    Top = 72
    object actClear: TAction
      Category = 'Action'
      Caption = 'Clear'
      ShortCut = 16451
      OnExecute = actClearExecute
    end
    object actSolution: TAction
      Category = 'Action'
      Caption = 'Solution'
      ShortCut = 16452
      OnExecute = actSolutionExecute
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
end
