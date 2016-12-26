unit Unit1;

interface

uses System,
System.Drawing,
System.Windows.Forms,
System.ComponentModel;

uses EV3Communication,
SmallBasicEV3Extension,
Microsoft.SmallBasic.&Library;

const
    //Ширина области вывода
    DrawWidth = 470;
    //Высота области вывода
    DrawHeight = 360;
    //Масштаб области вывода
    DrawScale = 5;

var
    //Порт каретки
    PortMotorScan := Primitive.Create('C');
    //Скорость каретки
    SpeedScan := 0;
    //Направление каретки
    SpeedScanTurn := 1;
    //Порт вращателя болванки
    PortMotorTurn := Primitive.Create('B');
    //Порт сенсора
    PortSensor: Primitive := 1;
    //Ширина области распознавания (длина болванки)
    WidthScan := DrawWidth;
    //Высота области распознавания (градус болванки)(TODO совместить с DrawWidth и DrawHeight)
    HeightScan := DrawHeight;
    //Угол поворота сканера
    GradTurn := 30;

var
    Scaner: BackgroundWorker := new System.ComponentModel.BackgroundWorker();
    ScanerResult: array[0..DrawHeight - 1, 0..DrawWidth - 1] of integer;


procedure FillArrayGradRow(y: integer; x1: integer; x2: integer);
procedure FillArrayGradCol(x: integer; y1: integer; y2: integer);
function ToColor(Value: integer): Color;
function ToInt(value: Primitive): integer;
procedure FillArrayGradRowToEnd(y: integer);


type
    Form1 = class(Form)
        procedure StartButton_Click(sender: Object; e: EventArgs);
        procedure StopButton_Click(sender: Object; e: EventArgs);
        
        procedure Scaner_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
        procedure Scaner_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure Scaner_DoWork(sender: Object; e: DoWorkEventArgs);
        
        procedure pictureBoxMap_MouseLeave(sender: Object; e: EventArgs);
        procedure pictureBoxMap_MouseMove(sender: Object; e: MouseEventArgs);
        
        procedure Form1_Load(sender: Object; e: EventArgs);
        procedure trackBarSpeedScan_Scroll(sender: Object; e: EventArgs);
        procedure checkBoxTurn_CheckedChanged(sender: Object; e: EventArgs);
        procedure trackBarGradScan_Scroll(sender: Object; e: EventArgs);
        
        procedure Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
        procedure buttonSave_Click(sender: Object; e: EventArgs);
    {$region FormDesigner}
  private
    {$resource Unit1.Form1.resources}
    StartButton: Button;
    StopButton: Button;
    InfoLabel: &Label;
    panelControls: Panel;
    labelSpeedScan: &Label;
    trackBarSpeedScan: TrackBar;
    labelLog: &Label;
    trackBarGradScan: TrackBar;
    labelGradTurn: &Label;
    buttonSave: Button;
    saveFileDialog1: SaveFileDialog;
    pictureBoxMap: PictureBox;
    {$include Unit1.Form1.inc}
        {$endregion FormDesigner}
    
    public 
        constructor;
        begin
            Scaner.DoWork += Scaner_Dowork;
            Scaner.RunWorkerCompleted += Scaner_RunWorkerCompleted;
            Scaner.ProgressChanged += Scaner_ProgressChanged;
            Scaner.WorkerReportsProgress := true;
            Scaner.WorkerSupportsCancellation := true;
            //TODO
            InitializeComponent;
        end;
    end;

implementation


procedure FillArrayGradRow(y: integer; x1: integer; x2: integer);
begin
    if x2 < x1 then FillArrayGradRow(y, x2, x1); 
    if x2 - x1 < 2 then exit;
    var Grow: real := 
    (ScanerResult[y, x2] - ScanerResult[y, x1]) / (x2 - x1);
    for var i := x1 + 1 to x2 - 1 do
        ScanerResult[y, i] := ScanerResult[y, x1] + Round(Grow * (i - x1));
end;

procedure FillArrayGradRowToEnd(y: integer);
begin
    try
        var i: integer := 0;
        while ScanerResult[y, i] = 0 do
            i += 1;
        for var j := 0 to i do
            ScanerResult[y, j] := ScanerResult[y, i];
        while (ScanerResult[y, i] <> 0) and (i < WidthScan - 1) do
            i += 1;   
        for var j := i to WidthScan - 1 do
            ScanerResult[y, j] := ScanerResult[y, i - 1];
    except
        on ex: Exception do Console.WriteLine(ex.Tostring);
    end;
end;

procedure FillArrayGradCol(x: integer; y1: integer; y2: integer);
begin
    if y2 < y1 then FillArrayGradCol(x, y2, y1); 
    if y2 - y1 < 2 then exit;
    var Grow: real := 
    (ScanerResult[y2, x] - ScanerResult[y1, x]) / (y2 - y1);
    for var i := y1 + 1 to y2 - 1 do
        ScanerResult[i, x] := ScanerResult[y1, x] + Round(Grow * (i - y1));
end;

function ToInt(value: Primitive): integer;
begin
    result := integer.Parse(value.ToString());
    if result < 0 then result := 0; 
end;

function ToColor(Value: integer): Color;
begin
    //TODO
    if Value = 0 then
        result := SystemColors.Control
    else
    begin
        result := Color.FromArgb(255 - Value * 3, 0, Value * 3);
        exit;
        case Value of 
            1: result := Color.FromArgb(0, 0, 0);
            2: result := Color.FromArgb(0, 0, 0);
            3: result := Color.FromArgb(0, 0, 0);
            4: result := Color.FromArgb(0, 0, 0);
            5: result := Color.FromArgb(0, 0, 0);
            6: result := Color.FromArgb(0, 0, 0);
            7: result := Color.FromArgb(0, 0, 0);
            8: result := Color.FromArgb(0, 0, 0);
            9: result := Color.FromArgb(0, 0, 0);
            10: result := Color.FromArgb(0, 0, 0);
            11: result := Color.FromArgb(0, 0, 0);
            12: result := Color.FromArgb(0, 0, 0);
            13: result := Color.FromArgb(0, 0, 0);
            14: result := Color.FromArgb(0, 0, 0);
            15: result := Color.FromArgb(0, 0, 0);
            16: result := Color.FromArgb(0, 0, 0);
            17: result := Color.FromArgb(0, 0, 0);
            18: result := Color.FromArgb(0, 0, 0);
            19: result := Color.FromArgb(0, 0, 0);
            20: result := Color.FromArgb(0, 0, 0);
            21: result := Color.FromArgb(0, 0, 0);
            22: result := Color.FromArgb(0, 0, 0);
            23: result := Color.FromArgb(0, 0, 0);
            24: result := Color.FromArgb(0, 0, 0);
            25: result := Color.FromArgb(0, 0, 0);
            26: result := Color.FromArgb(0, 0, 0);
            27: result := Color.FromArgb(0, 0, 0);
            28: result := Color.FromArgb(0, 0, 0);
            29: result := Color.FromArgb(0, 0, 0);
            30: result := Color.FromArgb(0, 0, 0);
            31: result := Color.FromArgb(0, 0, 0);
            32: result := Color.FromArgb(0, 0, 0);
            33: result := Color.FromArgb(0, 0, 0);
            34: result := Color.FromArgb(0, 0, 0);
            35: result := Color.FromArgb(0, 0, 0);
            36: result := Color.FromArgb(0, 0, 0);
            37: result := Color.FromArgb(0, 0, 0);
            38: result := Color.FromArgb(0, 0, 0);
            39: result := Color.FromArgb(0, 0, 0);
            40: result := Color.FromArgb(0, 0, 0);
            41: result := Color.FromArgb(0, 0, 0);
            42: result := Color.FromArgb(0, 0, 0);
            43: result := Color.FromArgb(0, 0, 0);
            44: result := Color.FromArgb(0, 0, 0);
            45: result := Color.FromArgb(0, 0, 0);
            46: result := Color.FromArgb(0, 0, 0);
            47: result := Color.FromArgb(0, 0, 0);
            48: result := Color.FromArgb(0, 0, 0);
            49: result := Color.FromArgb(0, 0, 0);
            51: result := Color.FromArgb(0, 0, 0);
            52: result := Color.FromArgb(0, 0, 0);
            53: result := Color.FromArgb(0, 0, 0);
            54: result := Color.FromArgb(0, 0, 0);
            55: result := Color.FromArgb(0, 0, 0);
            56: result := Color.FromArgb(0, 0, 0);
            57: result := Color.FromArgb(0, 0, 0);
            58: result := Color.FromArgb(0, 0, 0);
            59: result := Color.FromArgb(0, 0, 0);
            61: result := Color.FromArgb(0, 0, 0);
            62: result := Color.FromArgb(0, 0, 0);
            63: result := Color.FromArgb(0, 0, 0);
            64: result := Color.FromArgb(0, 0, 0);
            65: result := Color.FromArgb(0, 0, 0);
            66: result := Color.FromArgb(0, 0, 0);
            67: result := Color.FromArgb(0, 0, 0);
            68: result := Color.FromArgb(0, 0, 0);
            69: result := Color.FromArgb(0, 0, 0);
            70: result := Color.FromArgb(0, 0, 0);
            71: result := Color.FromArgb(0, 0, 0);
            72: result := Color.FromArgb(0, 0, 0);
            73: result := Color.FromArgb(0, 0, 0);
            74: result := Color.FromArgb(0, 0, 0);
            75: result := Color.FromArgb(0, 0, 0);
            76: result := Color.FromArgb(0, 0, 0);
            77: result := Color.FromArgb(0, 0, 0);
            78: result := Color.FromArgb(0, 0, 0);
            79: result := Color.FromArgb(0, 0, 0);
            80: result := Color.FromArgb(0, 0, 0);
            81: result := Color.FromArgb(0, 0, 0);
            82: result := Color.FromArgb(0, 0, 0);
            83: result := Color.FromArgb(0, 0, 0);
            84: result := Color.FromArgb(0, 0, 0);
            85: result := Color.FromArgb(0, 0, 0);
            86: result := Color.FromArgb(0, 0, 0);
            87: result := Color.FromArgb(0, 0, 0);
            88: result := Color.FromArgb(0, 0, 0);
            89: result := Color.FromArgb(0, 0, 0);
            90: result := Color.FromArgb(0, 0, 0);
            91: result := Color.FromArgb(0, 0, 0);
            92: result := Color.FromArgb(0, 0, 0);
            93: result := Color.FromArgb(0, 0, 0);
            94: result := Color.FromArgb(0, 0, 0);
            95: result := Color.FromArgb(0, 0, 0);
            96: result := Color.FromArgb(0, 0, 0);
            97: result := Color.FromArgb(0, 0, 0);
            98: result := Color.FromArgb(0, 0, 0);
            99: result := Color.FromArgb(0, 0, 0);
            100: result := Color.FromArgb(0, 0, 0);
        end;
        
        
    end;
end;

procedure Form1.Scaner_DoWork(sender: Object; e: DoWorkEventArgs);
begin
    var worker := sender as BackgroundWorker;
    //Возвращаем сканер на стартовую позицию
    //Motor.Move(PortMotorScan, 50, 500, Primitive.Create(true));
    //Сбрасываем моторы
    Motor.ResetCount(PortMotorScan);
    Motor.ResetCount(PortMotorTurn);
    
    var LastY, CurY: integer;
    while (ToInt(Motor.GetCount(PortMotorTurn)) < HeightScan) do
    begin
        LastY := CurY;
        CurY := ToInt(Motor.GetCount(PortMotorTurn));
        var LastX, CurX: integer;
        LastX := 0;
        CurX := ToInt(Motor.GetCount(PortMotorScan));
        while (CurX < WidthScan ) do
        begin
            //Проверка остановки    
            if (worker.CancellationPending) then
            begin
                e.Cancel := true;
                Motor.Stop(PortMotorScan, Primitive.Create(false));
                Motor.Stop(PortMotorTurn, Primitive.Create(false));
                exit;
            end;
            //Изменяем скорость
            Motor.Start(PortMotorScan, SpeedScan);
            //Значение яркости TODO перевести в высоту
            var value: integer := Sensor.ReadRawValue(PortSensor, 0);
            
            
            try
                ScanerResult[CurY, CurX] := value;
            except
                Console.WriteLine('CurX = ' + CurX.ToString + NewLine + 'CurY = ' + CurY.ToString);
            end;
            FillArrayGradRow(CurY, LastX, CurX);
            for var i := Min(LastX, CurX) to Max(LastX, Curx) do
                FillArrayGradCol(i, LastY, CurY);
            if PABCSystem.Random(10) = 1 then 
                worker.ReportProgress(0);
            
            LastX := CurX;
            CurX := ToInt(Motor.GetCount(PortMotorScan));
        end;
        FillArrayGradRowToEnd(CurY);
        for var i := 0 to WidthScan - 1 do
            FillArrayGradCol(i, LastY, CurY);
        worker.ReportProgress(0);
        Motor.Start(PortMotorScan, SpeedScan * (-1));
        while(ToInt(Motor.GetCount(PortMotorScan)) > 0 ) do
            Sleep(1);
        Motor.Stop(PortMotorScan, true);
        Motor.Move(PortMotorTurn, 30, GradTurn, Primitive.Create(true));
    end;
    exit;
    
end;

procedure Form1.StartButton_Click(sender: Object; e: EventArgs);
begin
    if (not Scaner.IsBusy) then
    begin
        labelLog.Text := '';
        // Start the asynchronous operation.
        Scaner.RunWorkerAsync();
        StartButton.Enabled := false;
        StopButton.Enabled := true;
        
    end;
end;

procedure Form1.StopButton_Click(sender: Object; e: EventArgs);
begin
    if Scaner.WorkerSupportsCancellation then
    begin
        // Cancel the asynchronous operation.
        Scaner.CancelAsync();
        StartButton.Enabled := true;
        StopButton.Enabled := false;
    end;
end;

procedure Form1.Scaner_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
begin
    self.StartButton.Enabled := true;
    self.StopButton.Enabled := false;
    
    if pictureBoxMap.Image <> nil then
        pictureBoxMap.Image.Dispose();
    var image := new System.Drawing.Bitmap(DrawWidth, DrawHeight);
    for var i := 0 to DrawHeight - 1 do
        for var j := 0 to DrawWidth - 1 do
        begin
            image.SetPixel(j, i, ToColor(ScanerResult[i, j]));
        end;
    pictureBoxMap.Image := image;
    
    if e.Cancelled then
    begin
        labelLog.Text := 'Выполнение остановлено пользователем';
    end
    else if (e.Error <> nil) then
    begin
        labelLog.Text := 'Ошибка' + NewLine + e.Error.ToString();
    end
    else
    begin
        labelLog.Text := 'Выполнение успешно завершено';
    end
end;

procedure Form1.pictureBoxMap_MouseLeave(sender: Object; e: EventArgs);
begin
    InfoLabel.Text := '';
end;

procedure Form1.pictureBoxMap_MouseMove(sender: Object; e: MouseEventArgs);
begin
    InfoLabel.Text := ScanerResult[e.Y, e.X].ToString();
end;

procedure Form1.Form1_Load(sender: Object; e: EventArgs);
begin
    labelSpeedScan.Text := 'Скорость проверки: ' + trackBarSpeedScan.Value.ToString();
    labelGradTurn.Text := 'Угол поворота: ' + trackBarGradScan.Value.ToString();
    pictureBoxMap.Width := WidthScan;
    pictureBoxMap.Height := HeightScan;
end;

procedure Form1.trackBarSpeedScan_Scroll(sender: Object; e: EventArgs);
begin
    labelSpeedScan.Text := 'Скорость проверки: ' + (sender as TrackBar).Value.ToString();
    SpeedScan := (sender as TrackBar).Value;
end;

procedure Form1.checkBoxTurn_CheckedChanged(sender: Object; e: EventArgs);
begin
    if (sender as CheckBox).Checked then
        SpeedScanTurn := -1
    else
        SpeedScanTurn := 1;
end;

procedure Form1.trackBarGradScan_Scroll(sender: Object; e: EventArgs);
begin
    labelGradTurn.Text := 'Угол поворота: ' + (sender as TrackBar).Value.ToString();
    GradTurn := (sender as TrackBar).Value;
end;

procedure Form1.Scaner_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    if pictureBoxMap.Image <> nil then
        pictureBoxMap.Image.Dispose();
    var image := new System.Drawing.Bitmap(DrawWidth, DrawHeight);
    for var i := 0 to DrawHeight - 1 do
        for var j := 0 to DrawWidth - 1 do
        begin
            image.SetPixel(j, i, ToColor(ScanerResult[i, j]));
        end;
    pictureBoxMap.Image := image;
end;

procedure Form1.Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
begin
end;

procedure Form1.buttonSave_Click(sender: Object; e: EventArgs);
begin
    saveFileDialog1.DefaultExt := '.jpg';
    saveFileDialog1.ShowDialog();
    pictureBoxMap.Image.Save(saveFileDialog1.FileName, System.Drawing.Imaging.ImageFormat.Bmp);
end;

end.