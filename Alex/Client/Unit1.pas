unit Unit1;

interface

uses
    System,
    System.Drawing,
    //System.Windows.Forms,
    System.ComponentModel,
    System.Net,
    System.Net.Sockets;

uses
    EV3Communication,
    SmallBasicEV3Extension,
    Microsoft.SmallBasic.&Library;

uses
    AForge,
    AForge.Video,
    AForge.Video.DirectShow;

uses
    System.Windows.Forms;
var
    BackServer: BackgroundWorker := new System.ComponentModel.BackgroundWorker();
    BackRobot: BackgroundWorker := new System.ComponentModel.BackgroundWorker();
    BackCamera: BackgroundWorker := new System.ComponentModel.BackgroundWorker();


const
    PortTCP = 5555;


function ToInt(value: Primitive): integer;
function GetValue(port: char): integer;
function GetValue(port: integer): integer;

type
    ByteArr = array of byte;

type
    Form1 = class(Form)
        procedure BackServer_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
        procedure BackServer_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure BackServer_DoWork(sender: Object; e: DoWorkEventArgs);
        
        procedure BackRobot_DoWork(sender: Object; e: DoWorkEventArgs);
        procedure BackRobot_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure BackRobot_RunWorkerCompleted(sender: Object; e: RunWorkerCompletedEventArgs);
        
        procedure BackCamera_DoWork(sender: Object; e: DoWorkEventArgs);
        procedure BackCamera_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
        procedure BackCamera_RunWorkerCompleted(sender: Object; e: RunWorkerCompletedEventArgs);
        
        procedure Form1_Load(sender: Object; e: EventArgs);
        procedure button1_Click(sender: Object; e: EventArgs);
        procedure button2_Click(sender: Object; e: EventArgs);
        procedure buttonCameraStart_Click(sender: Object; e: EventArgs);
        
        procedure VideoSourceNewFrame(sender: object; e: AForge.Video.NewFrameEventArgs);
        procedure buttonCameraStop_Click(sender: Object; e: EventArgs);
        procedure Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
    {$region FormDesigner}
  private
    {$resource Unit1.Form1.resources}
    button1: Button;
    label1: &Label;
    components: System.ComponentModel.IContainer;
    buttonCameraStart: Button;
    comboBox1: ComboBox;
    checkBox1: CheckBox;
    button2: Button;
    {$include Unit1.Form1.inc}
    {$endregion FormDesigner}
    public 
        constructor;
        begin
            BackServer.DoWork += BackServer_Dowork;
            BackServer.RunWorkerCompleted += BackServer_RunWorkerCompleted;
            BackServer.ProgressChanged += BackServer_ProgressChanged;
            BackServer.WorkerReportsProgress := true;
            BackServer.WorkerSupportsCancellation := true;
            
            BackRobot.DoWork += BackRobot_DoWork;
            BackRobot.ProgressChanged += BackRobot_ProgressChanged;
            BackRobot.RunWorkerCompleted += BackRobot_RunWorkerCompleted;
            BackRobot.WorkerReportsProgress := true;
            BackRobot.WorkerSupportsCancellation := true;
            
            BackCamera.DoWork += BackCamera_DoWork;
            BackCamera.ProgressChanged += BackCamera_ProgressChanged;
            BackCamera.RunWorkerCompleted += BackCamera_RunWorkerCompleted;
            BackCamera.WorkerSupportsCancellation := true;
            
            InitializeComponent;
        end;
    end;

var
    videoDevices: FilterInfoCollection;
    videoSource: VideoCaptureDevice;
    videoImage: Image;
    videoImageID: uint64 := 0;

implementation

function ToInt(value: Primitive): integer;
begin
    result := integer.Parse(value.ToString());
end;

procedure Form1.BackServer_RunWorkerCompleted(sender: object; e: RunWorkerCompletedEventArgs );
begin
    BackServer.RunWorkerAsync();
    
    if e.Cancelled then
    begin
    end
    else if (e.Error <> nil) then
    begin
        
    end
    else
    begin
    end
end;

procedure Form1.BackServer_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    
end;

procedure Form1.BackServer_DoWork(sender: Object; e: DoWorkEventArgs);
begin
    //var worker := sender as BackgroundWorker;
            // Data buffer for incoming data.
            //TODO вынести в др. background
        // Establish the local endpoint for the socket.
        // Dns.GetHostName returns the name of the 
        // host running the application.
    
    var localEndPoint := new IPEndPoint(IPAddress.Any, PortTCP);
    
        // Create a TCP/IP socket.
    var listener := new Socket(AddressFamily.InterNetwork,
    SocketType.Stream, ProtocolType.Tcp );
    
        // Bind the socket to the local endpoint and 
        // listen for incoming connections.
    try
        listener.Bind(localEndPoint);
        listener.Listen(10);
        
            // Start listening for connections.
        while (true) do
        begin
            try
                // Program is suspended while waiting for an incoming connection.
                var handler := listener.Accept();
                
                // An incoming connection needs to be processed.
                
                // Echo the data back to the client.
                var message := string.Empty;
                message += 'A ' + GetValue('A').ToString() + ' ';
                message += 'B ' + GetValue('B').ToString() + ' ';
                message += 'C ' + GetValue('C').ToString() + ' ';
                message += 'D ' + GetValue('D').ToString() + ' ';
                message += 'S1 ' + GetValue(1).ToString() + ' ';
                message += 'S2 ' + GetValue(2).ToString() + ' ';
                message += 'S3 ' + GetValue(3).ToString() + ' ';
                message += 'S4 ' + GetValue(4).ToString();
                
                var msg := Encoding.ASCII.GetBytes(message);
                
                handler.Send(msg);
                handler.Shutdown(SocketShutdown.Both);
                handler.Close();
                Sleep(20);
            except
            end;
        end;
    
    except
        end;
    
    
end;

procedure Form1.Form1_Load(sender: Object; e: EventArgs);
begin
    videoDevices := new FilterInfoCollection(FilterCategory.VideoInputDevice);
    for var i := 0 to videoDevices.Count - 1 do
        comboBox1.Items.Add(videoDevices.Item[i].MonikerString);// + ' ' + i.ToString);
    BackServer.RunWorkerAsync();
end;

procedure Form1.button1_Click(sender: Object; e: EventArgs);
begin
    if not BackRobot.IsBusy then
    begin
        BackRobot.RunWorkerAsync();
        button1.Enabled := false;
        button2.Enabled := true;
    end;
end;

procedure Form1.button2_Click(sender: Object; e: EventArgs);
begin
    if BackRobot.WorkerSupportsCancellation then
    begin
        BackRobot.CancelAsync();
        
    end;
end;


procedure Form1.BackRobot_DoWork(sender: Object; e: DoWorkEventArgs);
const
    COLOR_NO = 0;
    COLOR_BLACK = 1;
    COLOR_BLUE = 2;
    COLOR_GREEN = 3;
    COLOR_YELLOW = 4;
    COLOR_RED = 5;
    COLOR_WHITE = 6;
    COLOR_BROWN = 7;
    ///Плохо распознанные цвета
    COLOR_BAD = [COLOR_BLACK, COLOR_WHITE, COLOR_BROWN];
    ///Полный оборот робота вокруг своей оси
    TOTAL_GRAD = 360 * 7;
var
    ///Вверх и вниз
    MotorUp := new primitive('B');
    /// По кругу
    MotorRound := new primitive('C');
    ///Хапнуть
    MotorTake := new primitive('A');
    ///Датчик света
    SensorColor := new primitive(1);

const
    TaskListEt: array of integer = (COLOR_YELLOW, COLOR_WHITE, COLOR_RED, COLOR_BLUE);
    
    
    ///Останавливает моторы
    procedure Stop();
    begin
        Motor.Stop(MotorUp, true);
        Motor.Stop(MotorRound, true);
        Motor.Stop(MotorTake, true);
        
    end;
    
    ///Взять или опустить куб
    procedure TakePut(b: boolean);
    begin
        if b then
        begin
            //Взяли
            Motor.Move(MotorUp, -15, 190, true);
            
            Motor.Move(MotorTake, 70, 1500, true);
            Motor.Move(MotorUp, 15, 190, true);
            
        end
        else
        begin
            //Опустили клешню
            
            Motor.Move(MotorUp, -15, 190, true);
            
            Motor.Move(MotorTake, -70, 1500, true);
            Motor.Move(MotorUp, 15, 190, true);
            
        end;
    end;

begin
    //Motor.Start(MotorUp, -5);
    //Motor.Move(MotorRound, 15, TOTAL_GRAD * 2, true);
    //exit;
    Sensor.wait(SensorColor);
    LCD.Clear();
    var worker := sender as BackgroundWorker;
    //Сброс
    Motor.ResetCount(MotorUp);
    Motor.ResetCount(MotorRound);
    Motor.ResetCount(MotorTake);
    ///Режим - цвет
    Sensor.SetMode(SensorColor, 2);
    
    for var i := 0 to TaskListEt.Length - 1 do
    begin
        Motor.Start(MotorRound, 15);
        var NowValue: integer := Sensor.ReadRawValue(SensorColor, 0);
        while (NowValue <> TaskListEt[i]) do
        begin
            if worker.CancellationPending then
            begin
                e.Cancel := true;
                Stop;
                exit;
            end;
            if ToInt(Motor.GetSpeed(MotorRound)) < 10 then
                Motor.Start(MotorRound, 30)
            else
                Motor.Start(MotorRound, 15);
            
            {        
            if NowValue in COLOR_BAD then
            begin
                Stop;
                Motor.Move(MotorUp, -15, 60, false);
                NowValue := Sensor.ReadRawValue(SensorColor, 0);
                if NowValue = COLOR_RED then
                begin
                    Motor.Move(MotorUp, -15, Motor.GetCount(MotorUp), false);
                    Motor.ResetCount(MotorUp);
                    break;
                end;
            end;
            }
            if NowValue = Color_Green then
            begin
                Motor.Move(MotorRound, -15, 35, true);
                
                Stop;
                Speaker.Tone(100, 5000, 1000);
                Speaker.Tone(100, 10000, 1000);
                Speaker.Tone(100, 5000, 1000);
                Speaker.Tone(100, 2000, 1000);
                Speaker.Tone(100, 5000, 1000);
                Speaker.Tone(100, 10000, 1000);
                Speaker.Tone(100, 5000, 1000);
                
                Speaker.Tone(100, 500, 1000);
                Speaker.Tone(100, 1000, 1000);
                Speaker.Tone(100, 500, 1000);
                Speaker.Tone(100, 200, 1000);
                Speaker.Tone(100, 500, 1000);
                Speaker.Tone(100, 1000, 1000);
                Speaker.Tone(100, 500, 1000);
                exit;
            end;
            NowValue := Sensor.ReadRawValue(SensorColor, 0);
            
        end;
        Motor.Move(MotorRound, -15, 40, true);
        
        Stop;
        
        TakePut(true);
        //Доперемещаем клешню
        Motor.Move(MotorRound, -15, (ToInt(Motor.GetCount(MotorRound)) + TOTAL_GRAD * 20) mod TOTAL_GRAD, true);
        Motor.Move(MotorRound, 15, i * 28 * 7, true);
        TakePut(false);
        Stop;
        Sleep(3000);
    end;    
        //Переходим на построение на др полуокружности
    Motor.Move(MotorRound, -15, (ToInt(Motor.GetCount(MotorRound)) + TOTAL_GRAD * 20) mod TOTAL_GRAD, true);
    
    Motor.Move(MotorRound, -15, TOTAL_GRAD div 2, true);
    
end;



procedure Form1.BackRobot_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    
end;


procedure Form1.BackRobot_RunWorkerCompleted(sender: Object; e: RunWorkerCompletedEventArgs);
begin
    button1.Enabled := true;
    button2.Enabled := false;
    
    if e.Cancelled then
    begin
    end
    else if (e.Error <> nil) then
    begin
        buttonCameraStart.text := e.Error.ToString;
    end
    else
    begin
        if checkBox1.checked then button1.PerformClick;
    end
end;



function GetValue(port: char): integer;
begin
    port := UpCase(port);
    //Result := ((DateTime.Now.Ticks div 1500000) mod 200) - 100 + Random.Create(port.GetHashCode + Random.Create(port.GetHashCode).Next).Next(10);
    //exit;
    Result := ToInt(Motor.GetCount(new primitive(port)));
end;

function GetValue(port: integer): integer;
begin
    //Result := ((DateTime.Now.Ticks div 1500000 ) mod 200) - 100 + Random.Create(port + Random.Create(port).Next).Next(10);
    //exit;
    Result := ToInt(Sensor.ReadRawValue(new primitive(port), 0));
end;



procedure Form1.BackCamera_DoWork(sender: Object; e: DoWorkEventArgs);
begin
    var worker := sender as BackgroundWorker;
    var localEndPoint := new IPEndPoint(IPAddress.Any, PortTCP + 1);
    
        // Create a TCP/IP socket.
    var listener := new Socket(AddressFamily.InterNetwork,
    SocketType.Stream, ProtocolType.Tcp );
    var handler: System.Net.Sockets.Socket;  
    try
        listener.Bind(localEndPoint);
        listener.Listen(10);
        var videoImageIDLast: uint64 := 0;
        while (true) do
        begin
                // Program is suspended while waiting for an incoming connection.
            handler := listener.Accept();
            if worker.CancellationPending then
            begin
                e.Cancel := true;
                exit;
            end;
                // An incoming connection needs to be processed.
            
                // Echo the data back to the client.
            while (videoImageID = videoImageIDLast) or (videoImage = nil) do
            begin
                if worker.CancellationPending then
                begin
                    e.Cancel := true;
                    exit;
                end;
                Sleep(1);
            end;
            if videoImage <> nil then
            begin
                var image := videoImage.Clone as Image;
                var msg: ByteArr := new ByteArr(0);
                
                
                //pictureBox1.Image := videoImage.Clone as Image;
                var converter := new ImageConverter();
                msg := (converter.ConvertTo(image, typeof(ByteArr)) as ByteArr);
                //var ms := new System.IO.MemoryStream;
                //videoImage.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                //var msg := ms.ToArray();
                
                //ms.Dispose();
                image.Dispose();
                handler.Send(msg);
                sleep(25);
            end;
            handler.Shutdown(SocketShutdown.Both);
            handler.Close();
            videoImageIDLast := videoImageID;
        end;
    
    except
        on ex: Exception do
        begin
            handler.Shutdown(SocketShutdown.Both);
            handler.Close();
            Console.WriteLine(ex.ToString);
        end;
    end;
    //videoSource.Stop();
end;


procedure Form1.BackCamera_ProgressChanged(sender: Object; e: ProgressChangedEventArgs);
begin
    
end;


procedure Form1.BackCamera_RunWorkerCompleted(sender: Object; e: RunWorkerCompletedEventArgs);
begin
    BackCamera.RunWorkerAsync;
    //videoSource.Stop();
    
    //videoSource := nil;
    //videoDevices := nil;
end;

procedure Form1.buttonCameraStart_Click(sender: Object; e: EventArgs);
begin
    if not BackCamera.IsBusy then
    begin
        
        if comboBox1.Text = '' then exit;
        videoSource := new VideoCaptureDevice(comboBox1.Text);
        videoSource.NewFrame += VideoSourceNewFrame;
        videoSource.Start();
        BackCamera.RunWorkerAsync();
        (sender as Button).Hide;
    end
    else label1.text := 'Камера занята';
end;

procedure Form1.VideoSourceNewFrame(sender: object; e: AForge.Video.NewFrameEventArgs);
begin
    videoImage := e.Frame;
    Inc(videoImageID);
    //20 FPS
    Sleep(50);
end;

procedure Form1.buttonCameraStop_Click(sender: Object; e: EventArgs);
begin
    
    BackCamera.CancelAsync();
end;

procedure Form1.Form1_FormClosing(sender: Object; e: FormClosingEventArgs);
begin
    if videoSource <> nil then
        videoSource.Stop();
    BackCamera.CancelAsync();
    System.Diagnostics.Process.GetCurrentProcess.Kill();
end;


end.