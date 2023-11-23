
_MPU6050_Init:

;mpu6050_1.c,143 :: 		void MPU6050_Init()
;mpu6050_1.c,145 :: 		I2C1_Init(400000);
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;mpu6050_1.c,146 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;mpu6050_1.c,147 :: 		I2C1_Wr( MPU6050_ADDRESS );
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,148 :: 		I2C1_Wr( MPU6050_RA_PWR_MGMT_1 );
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,149 :: 		I2C1_Wr( 2 ); //Sleep OFF
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,150 :: 		I2C1_Wr( 0 );
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,151 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;mpu6050_1.c,152 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;mpu6050_1.c,153 :: 		I2C1_Wr( MPU6050_ADDRESS );
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,154 :: 		I2C1_Wr( MPU6050_RA_GYRO_CONFIG );
	MOVLW       27
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,155 :: 		I2C1_Wr( 0 ); //gyro_config, +-250 °/s
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,156 :: 		I2C1_Wr( 0 ); //accel_config +-2g
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,157 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;mpu6050_1.c,158 :: 		}
L_end_MPU6050_Init:
	RETURN      0
; end of _MPU6050_Init

_MPU6050_Read:

;mpu6050_1.c,160 :: 		void MPU6050_Read( MPU6050 *Sensor )
;mpu6050_1.c,162 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;mpu6050_1.c,163 :: 		I2C1_Wr( MPU6050_ADDRESS );
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,164 :: 		I2C1_Wr( MPU6050_RA_ACCEL_XOUT_H );
	MOVLW       59
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,165 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;mpu6050_1.c,166 :: 		I2C1_Wr( MPU6050_ADDRESS | 1 );
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;mpu6050_1.c,167 :: 		Sensor->Accel.X = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
	MOVF        FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVF        FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,168 :: 		Sensor->Accel.Y = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
	MOVLW       2
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,169 :: 		Sensor->Accel.Z = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
	MOVLW       4
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,170 :: 		Sensor->Temperatura = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
	MOVLW       6
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,171 :: 		Sensor->Gyro.X = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
	MOVLW       8
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVF        R1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,172 :: 		Sensor->Gyro.Y = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(1);
	MOVLW       8
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,173 :: 		Sensor->Gyro.Z = ( I2C1_Rd(1) << 8 ) | I2C1_Rd(0);
	MOVLW       8
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       R1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FLOC__MPU6050_Read+2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__MPU6050_Read+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__MPU6050_Read+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__MPU6050_Read+1, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__MPU6050_Read+2, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,174 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;mpu6050_1.c,175 :: 		Sensor->Temperatura += 12421;
	MOVLW       6
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVLW       133
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,176 :: 		Sensor->Temperatura /= 340;
	MOVLW       6
	ADDWF       FARG_MPU6050_Read_Sensor+0, 0 
	MOVWF       FLOC__MPU6050_Read+0 
	MOVLW       0
	ADDWFC      FARG_MPU6050_Read_Sensor+1, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	MOVFF       FLOC__MPU6050_Read+0, FSR0L+0
	MOVFF       FLOC__MPU6050_Read+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       84
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVFF       FLOC__MPU6050_Read+0, FSR1L+0
	MOVFF       FLOC__MPU6050_Read+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;mpu6050_1.c,177 :: 		}
L_end_MPU6050_Read:
	RETURN      0
; end of _MPU6050_Read

_interrupt:

;mpu6050_1.c,188 :: 		void interrupt()
;mpu6050_1.c,190 :: 		USB_Interrupt_Proc();        // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;mpu6050_1.c,191 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;mpu6050_1.c,193 :: 		void main()
;mpu6050_1.c,195 :: 		osccon=0xfc;           //externo cristal 4 Mhz
	MOVLW       252
	MOVWF       OSCCON+0 
;mpu6050_1.c,196 :: 		PORTB = 0;
	CLRF        PORTB+0 
;mpu6050_1.c,197 :: 		trisb=0xff;
	MOVLW       255
	MOVWF       TRISB+0 
;mpu6050_1.c,199 :: 		HID_Enable(readbuff,writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;mpu6050_1.c,201 :: 		UART1_init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH+0 
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;mpu6050_1.c,202 :: 		MPU6050_Init();
	CALL        _MPU6050_Init+0, 0
;mpu6050_1.c,204 :: 		while(1)
L_main0:
;mpu6050_1.c,206 :: 		MPU6050_Read( &Sensor );
	MOVLW       _Sensor+0
	MOVWF       FARG_MPU6050_Read_Sensor+0 
	MOVLW       hi_addr(_Sensor+0)
	MOVWF       FARG_MPU6050_Read_Sensor+1 
	CALL        _MPU6050_Read+0, 0
;mpu6050_1.c,208 :: 		buttons=button1 + (button2*2) + (button3*4) + (button4*8); //Compact buttons
	CLRF        R1 
	BTFSC       PORTB+0, 2 
	INCF        R1, 1 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	CLRF        R2 
	BTFSC       PORTB+0, 3 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       _buttons+0 
;mpu6050_1.c,209 :: 		buttons<<=4;
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       _buttons+0 
;mpu6050_1.c,211 :: 		pov_hat = buttons|4;
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       _pov_hat+0 
;mpu6050_1.c,213 :: 		x_axis= Sensor.Accel.X>>7;      //Read only the upper 8 bits of the ADC
	MOVLW       7
	MOVWF       R2 
	MOVF        _Sensor+0, 0 
	MOVWF       R0 
	MOVF        _Sensor+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main9:
	BZ          L__main10
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main9
L__main10:
	MOVF        R0, 0 
	MOVWF       _x_axis+0 
;mpu6050_1.c,214 :: 		y_axis=(Adc_Read(1)>>2)-128;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVLW       128
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _y_axis+0 
;mpu6050_1.c,216 :: 		writebuff[0]=128;
	MOVLW       128
	MOVWF       1344 
;mpu6050_1.c,217 :: 		writebuff[1]=x_axis ;
	MOVF        _x_axis+0, 0 
	MOVWF       1345 
;mpu6050_1.c,218 :: 		writebuff[2]=y_axis;
	MOVF        R0, 0 
	MOVWF       1346 
;mpu6050_1.c,219 :: 		writebuff[3]= pov_hat;
	MOVF        _pov_hat+0, 0 
	MOVWF       1347 
;mpu6050_1.c,221 :: 		while(!HID_Write(writebuff,4));
L_main2:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       4
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
	GOTO        L_main2
L_main3:
;mpu6050_1.c,222 :: 		}
	GOTO        L_main0
;mpu6050_1.c,223 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
