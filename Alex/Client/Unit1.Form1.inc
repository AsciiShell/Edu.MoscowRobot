procedure InitializeComponent;
    begin
        var resources: System.ComponentModel.ComponentResourceManager := new System.ComponentModel.ComponentResourceManager(typeof(Form1));
        self.button1 := new System.Windows.Forms.Button();
        self.button2 := new System.Windows.Forms.Button();
        self.label1 := new System.Windows.Forms.Label();
        self.buttonCameraStart := new System.Windows.Forms.Button();
        self.comboBox1 := new System.Windows.Forms.ComboBox();
        self.checkBox1 := new System.Windows.Forms.CheckBox();
        self.SuspendLayout();
        // 
        // button1
        // 
        self.button1.Location := new System.Drawing.Point(12, 35);
        self.button1.Name := 'button1';
        self.button1.Size := new System.Drawing.Size(96, 23);
        self.button1.TabIndex := 0;
        self.button1.Text := 'Старт';
        self.button1.UseVisualStyleBackColor := true;
        self.button1.Click += button1_Click;
        // 
        // button2
        // 
        self.button2.Enabled := false;
        self.button2.Location := new System.Drawing.Point(114, 36);
        self.button2.Name := 'button2';
        self.button2.Size := new System.Drawing.Size(96, 23);
        self.button2.TabIndex := 1;
        self.button2.Text := 'Стоп';
        self.button2.UseVisualStyleBackColor := true;
        self.button2.Click += button2_Click;
        // 
        // label1
        // 
        self.label1.Location := new System.Drawing.Point(12, 9);
        self.label1.Name := 'label1';
        self.label1.Size := new System.Drawing.Size(156, 23);
        self.label1.TabIndex := 2;
        self.label1.Text := 'Управление роботом';
        // 
        // buttonCameraStart
        // 
        self.buttonCameraStart.Location := new System.Drawing.Point(13, 65);
        self.buttonCameraStart.Name := 'buttonCameraStart';
        self.buttonCameraStart.Size := new System.Drawing.Size(197, 172);
        self.buttonCameraStart.TabIndex := 3;
        self.buttonCameraStart.Text := 'Запустить видео';
        self.buttonCameraStart.UseVisualStyleBackColor := true;
        self.buttonCameraStart.Click += buttonCameraStart_Click;
        // 
        // comboBox1
        // 
        self.comboBox1.FormattingEnabled := true;
        self.comboBox1.Location := new System.Drawing.Point(294, 65);
        self.comboBox1.Name := 'comboBox1';
        self.comboBox1.Size := new System.Drawing.Size(121, 21);
        self.comboBox1.TabIndex := 5;
        // 
        // checkBox1
        // 
        self.checkBox1.Location := new System.Drawing.Point(294, 93);
        self.checkBox1.Name := 'checkBox1';
        self.checkBox1.Size := new System.Drawing.Size(104, 24);
        self.checkBox1.TabIndex := 6;
        self.checkBox1.Text := 'Зациклить';
        self.checkBox1.UseVisualStyleBackColor := true;
        // 
        // Form1
        // 
        self.ClientSize := new System.Drawing.Size(559, 497);
        self.Controls.Add(self.checkBox1);
        self.Controls.Add(self.comboBox1);
        self.Controls.Add(self.buttonCameraStart);
        self.Controls.Add(self.label1);
        self.Controls.Add(self.button2);
        self.Controls.Add(self.button1);
        self.Icon := (System.Drawing.Icon(resources.GetObject('$this.Icon')));
        self.Name := 'Form1';
        self.Text := 'Server';
        self.FormClosing += Form1_FormClosing;
        self.Load += Form1_Load;
        self.ResumeLayout(false);
    end;
