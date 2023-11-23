#line 1 "C:/Users/Thomas Bollen/Desktop/mpu6050/mpu6050_1.c"
#line 123 "C:/Users/Thomas Bollen/Desktop/mpu6050/mpu6050_1.c"
typedef struct
{
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;
 }Accel;
 signed int Temperatura;
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;
 }Gyro;
}MPU6050;




void MPU6050_Init()
{
I2C1_Init(400000);
 I2C1_Start();
 I2C1_Wr(  0xD0  );
 I2C1_Wr(  0x6B  );
 I2C1_Wr( 2 );
 I2C1_Wr( 0 );
 I2C1_Stop();
 I2C1_Start();
 I2C1_Wr(  0xD0  );
 I2C1_Wr(  0x1B  );
 I2C1_Wr( 0 );
 I2C1_Wr( 0 );
 I2C1_Stop();
}

void MPU6050_Read( MPU6050 *Sensor )
{
 I2C1_Start();
 I2C1_Wr(  0xD0  );
 I2C1_Wr(  0x3B  );
 I2C1_Start();
 I2C1_Wr(  0xD0  | 1 );
 Sensor->Accel.X = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
 Sensor->Accel.Y = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
 Sensor->Accel.Z = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
 Sensor->Temperatura = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
 Sensor->Gyro.X = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
 Sensor->Gyro.Y = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
 Sensor->Gyro.Z = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(0);
 I2C1_Stop();
 Sensor->Temperatura += 12421;
 Sensor->Temperatura /= 340;
}

MPU6050 Sensor;
char msg[12];
unsigned char readbuff[64] absolute 0x500;
unsigned char writebuff[64] absolute 0x540;
unsigned char buttons;
unsigned char pov, pov_hat, dig_pov;
char x_axis, y_axis, throttle=0;
int temp;

void interrupt()
{
 USB_Interrupt_Proc();
}

void main()
{
 osccon=0xfc;
 PORTB = 0;
 trisb=0xff;

 HID_Enable(readbuff,writebuff);

 UART1_init(9600);
 MPU6050_Init();

 while(1)
 {
 MPU6050_Read( &Sensor );

 buttons= 0  + ( 0 *2) + ( PORTB.F2 *4) + ( PORTB.F3 *8);
 buttons<<=4;

 pov_hat = buttons|4;

 x_axis= Sensor.Accel.X>>7;
 y_axis=(Adc_Read(1)>>2)-128;

 writebuff[0]=128;
 writebuff[1]=x_axis ;
 writebuff[2]=y_axis;
 writebuff[3]= pov_hat;

 while(!HID_Write(writebuff,4));
 }
}
