procedure InitializeComponent;
    begin
        var resources: System.ComponentModel.ComponentResourceManager := new System.ComponentModel.ComponentResourceManager(typeof(Form1));
        self.labelMotorA := new System.Windows.Forms.Label();
        self.labelMotorAR := new System.Windows.Forms.Label();
        self.labelMotorBR := new System.Windows.Forms.Label();
        self.labelMotorB := new System.Windows.Forms.Label();
        self.labelMotorCR := new System.Windows.Forms.Label();
        self.labelMotorC := new System.Windows.Forms.Label();
        self.labelSensor1R := new System.Windows.Forms.Label();
        self.labelSensor1 := new System.Windows.Forms.Label();
        self.panel1 := new System.Windows.Forms.Panel();
        self.label1 := new System.Windows.Forms.Label();
        self.panelGraph := new System.Windows.Forms.Panel();
        self.panel2 := new System.Windows.Forms.Panel();
        self.label3 := new System.Windows.Forms.Label();
        self.label4 := new System.Windows.Forms.Label();
        self.label5 := new System.Windows.Forms.Label();
        self.label6 := new System.Windows.Forms.Label();
        self.pictureBox1 := new System.Windows.Forms.PictureBox();
        self.label2 := new System.Windows.Forms.Label();
        self.panel1.SuspendLayout();
        self.panelGraph.SuspendLayout();
        self.panel2.SuspendLayout();
        (System.ComponentModel.ISupportInitialize(self.pictureBox1)).BeginInit();
        self.SuspendLayout();
        // 
        // labelMotorA
        // 
        self.labelMotorA.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelMotorA.Location := new System.Drawing.Point(6, 34);
        self.labelMotorA.Name := 'labelMotorA';
        self.labelMotorA.Size := new System.Drawing.Size(120, 35);
        self.labelMotorA.TabIndex := 1;
        self.labelMotorA.Text := 'Захват';
        // 
        // labelMotorAR
        // 
        self.labelMotorAR.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelMotorAR.Location := new System.Drawing.Point(6, 69);
        self.labelMotorAR.Name := 'labelMotorAR';
        self.labelMotorAR.Size := new System.Drawing.Size(106, 35);
        self.labelMotorAR.TabIndex := 4;
        // 
        // labelMotorBR
        // 
        self.labelMotorBR.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelMotorBR.Location := new System.Drawing.Point(159, 69);
        self.labelMotorBR.Name := 'labelMotorBR';
        self.labelMotorBR.Size := new System.Drawing.Size(106, 35);
        self.labelMotorBR.TabIndex := 1;
        self.labelMotorBR.Click += labelMotorBR_Click;
        // 
        // labelMotorB
        // 
        self.labelMotorB.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelMotorB.Location := new System.Drawing.Point(159, 34);
        self.labelMotorB.Name := 'labelMotorB';
        self.labelMotorB.Size := new System.Drawing.Size(120, 35);
        self.labelMotorB.TabIndex := 3;
        self.labelMotorB.Text := 'Высота';
        // 
        // labelMotorCR
        // 
        self.labelMotorCR.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelMotorCR.Location := new System.Drawing.Point(309, 69);
        self.labelMotorCR.Name := 'labelMotorCR';
        self.labelMotorCR.Size := new System.Drawing.Size(106, 35);
        self.labelMotorCR.TabIndex := 2;
        self.labelMotorCR.Click += labelMotorCR_Click;
        // 
        // labelMotorC
        // 
        self.labelMotorC.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelMotorC.Location := new System.Drawing.Point(309, 34);
        self.labelMotorC.Name := 'labelMotorC';
        self.labelMotorC.Size := new System.Drawing.Size(120, 35);
        self.labelMotorC.TabIndex := 5;
        self.labelMotorC.Text := 'Поворот';
        // 
        // labelSensor1R
        // 
        self.labelSensor1R.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelSensor1R.Location := new System.Drawing.Point(465, 69);
        self.labelSensor1R.Name := 'labelSensor1R';
        self.labelSensor1R.Size := new System.Drawing.Size(211, 35);
        self.labelSensor1R.TabIndex := 11;
        // 
        // labelSensor1
        // 
        self.labelSensor1.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.labelSensor1.Location := new System.Drawing.Point(470, 34);
        self.labelSensor1.Name := 'labelSensor1';
        self.labelSensor1.Size := new System.Drawing.Size(120, 35);
        self.labelSensor1.TabIndex := 10;
        self.labelSensor1.Text := 'Цвет';
        self.labelSensor1.Click += labelSensor1_Click;
        // 
        // panel1
        // 
        self.panel1.Controls.Add(self.label1);
        self.panel1.Controls.Add(self.labelMotorA);
        self.panel1.Controls.Add(self.labelSensor1R);
        self.panel1.Controls.Add(self.labelMotorAR);
        self.panel1.Controls.Add(self.labelSensor1);
        self.panel1.Controls.Add(self.labelMotorB);
        self.panel1.Controls.Add(self.labelMotorCR);
        self.panel1.Controls.Add(self.labelMotorBR);
        self.panel1.Controls.Add(self.labelMotorC);
        self.panel1.Location := new System.Drawing.Point(665, 108);
        self.panel1.Name := 'panel1';
        self.panel1.Size := new System.Drawing.Size(688, 127);
        self.panel1.TabIndex := 0;
        // 
        // label1
        // 
        self.label1.Dock := System.Windows.Forms.DockStyle.Top;
        self.label1.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.label1.Location := new System.Drawing.Point(0, 0);
        self.label1.Name := 'label1';
        self.label1.Size := new System.Drawing.Size(688, 34);
        self.label1.TabIndex := 0;
        self.label1.Text := 'Показания датчиков';
        self.label1.TextAlign := System.Drawing.ContentAlignment.MiddleCenter;
        // 
        // panelGraph
        // 
        self.panelGraph.Controls.Add(self.panel2);
        self.panelGraph.Location := new System.Drawing.Point(662, 171);
        self.panelGraph.Name := 'panelGraph';
        self.panelGraph.Size := new System.Drawing.Size(688, 558);
        self.panelGraph.TabIndex := 2;
        // 
        // panel2
        // 
        self.panel2.Controls.Add(self.label5);
        self.panel2.Controls.Add(self.label3);
        self.panel2.Controls.Add(self.label4);
        self.panel2.Location := new System.Drawing.Point(418, 421);
        self.panel2.Name := 'panel2';
        self.panel2.Size := new System.Drawing.Size(270, 108);
        self.panel2.TabIndex := 0;
        self.panel2.Paint += panel2_Paint;
        // 
        // label3
        // 
        self.label3.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.label3.Location := new System.Drawing.Point(138, 0);
        self.label3.Name := 'label3';
        self.label3.Size := new System.Drawing.Size(120, 35);
        self.label3.TabIndex := 12;
        self.label3.Text := 'Захват';
        // 
        // label4
        // 
        self.label4.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.label4.Location := new System.Drawing.Point(138, 35);
        self.label4.Name := 'label4';
        self.label4.Size := new System.Drawing.Size(120, 35);
        self.label4.TabIndex := 12;
        self.label4.Text := 'Высота';
        // 
        // label5
        // 
        self.label5.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.label5.Location := new System.Drawing.Point(138, 70);
        self.label5.Name := 'label5';
        self.label5.Size := new System.Drawing.Size(120, 35);
        self.label5.TabIndex := 12;
        self.label5.Text := 'Поворот';
        // 
        // label6
        // 
        self.label6.Dock := System.Windows.Forms.DockStyle.Top;
        self.label6.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.label6.Location := new System.Drawing.Point(0, 0);
        self.label6.Name := 'label6';
        self.label6.Size := new System.Drawing.Size(1350, 46);
        self.label6.TabIndex := 14;
        self.label6.Text := 'Удаленный контроль манипулятора №4';
        self.label6.TextAlign := System.Drawing.ContentAlignment.MiddleCenter;
        // 
        // pictureBox1
        // 
        self.pictureBox1.Location := new System.Drawing.Point(16, 171);
        self.pictureBox1.Name := 'pictureBox1';
        self.pictureBox1.Size := new System.Drawing.Size(640, 480);
        self.pictureBox1.SizeMode := System.Windows.Forms.PictureBoxSizeMode.Zoom;
        self.pictureBox1.TabIndex := 9;
        self.pictureBox1.TabStop := false;
        self.pictureBox1.UseWaitCursor := true;
        self.pictureBox1.Click += pictureBox1_Click;
        // 
        // label2
        // 
        self.label2.Font := new System.Drawing.Font('Microsoft Sans Serif', 20, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (System.Byte(204)));
        self.label2.Location := new System.Drawing.Point(12, 77);
        self.label2.Name := 'label2';
        self.label2.Size := new System.Drawing.Size(640, 35);
        self.label2.TabIndex := 10;
        self.label2.Text := 'Визуальный контроль';
        self.label2.TextAlign := System.Drawing.ContentAlignment.MiddleCenter;
        // 
        // Form1
        // 
        self.BackColor := System.Drawing.SystemColors.Control;
        self.ClientSize := new System.Drawing.Size(1350, 729);
        self.Controls.Add(self.panel1);
        self.Controls.Add(self.label2);
        self.Controls.Add(self.pictureBox1);
        self.Controls.Add(self.label6);
        self.Controls.Add(self.panelGraph);
        self.Icon := (System.Drawing.Icon(resources.GetObject('$this.Icon')));
        self.Name := 'Form1';
        self.Text := 'Манипулятор №4';
        self.WindowState := System.Windows.Forms.FormWindowState.Maximized;
        self.FormClosing += Form1_FormClosing;
        self.Load += Form1_Load;
        self.panel1.ResumeLayout(false);
        self.panelGraph.ResumeLayout(false);
        self.panel2.ResumeLayout(false);
        (System.ComponentModel.ISupportInitialize(self.pictureBox1)).EndInit();
        self.ResumeLayout(false);
    end;
