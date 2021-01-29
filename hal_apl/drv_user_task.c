//*******************************************************************************
//    Driver User Task LED Sample : drv_user_task.c
//                                                                         Sumida
//*******************************************************************************
#include "kernel_cfg.h"         	// Toppers Kernel Config Header
#include "hal.h"					// Toppers Header
#include "hal_extention.h"			// Toppers HAL_Extention Header
#include "api_macro.h"
//*******************************************************************************
//*     [ User Task Entry ]                                                     *
//*******************************************************************************
void drv_user_task(intptr_t task_id) {
  	ER   rspcd;                                  		// 応答Code

  	syslog_0(LOG_ALERT,"\n\rUser_Task start");       	// Start Message
  	//***** Driver_LED svc ********
   rspcd = drv_api_led (task_id,LED1,sv_open);
   syslog_1(LOG_ALERT,"\n\r*User LED1,open  ; rspcd = %d", rspcd);			// LED1 open

   rspcd = drv_api_led (task_id,LED1,sv_control,led_on);
   syslog_1(LOG_ALERT,"\n\r*User LED1,control,led_on; rspcd = %d", rspcd); // LED1を点灯

   rspcd = drv_api_led (task_id,LED2,sv_open);
   syslog_1(LOG_ALERT,"\n\r*User LED2,open  ; rspcd = %d", rspcd);			// LED2 open


   rspcd = drv_api_led (task_id,LED2,sv_control,led_blink,10,500);			// LED2 10秒間500ms間隔で点滅(非同期処理)
   syslog_1(LOG_ALERT,"\n\r*User LED2,control,blink(async) start; rspcd = %d", rspcd);
   do {
   dly_tsk(10);
   rspcd = drv_api_led (task_id,LED2,sv_control,led_stat);				// LED2点滅終了検査
   }while (rspcd != rsp_ok);
   syslog_1(LOG_ALERT,"\n\r*User LED2,control,blink(async) end; rspcd = %d", rspcd); //LED2点滅終了


   rspcd = drv_api_led (task_id,LED1,sv_control,led_off);
   syslog_1(LOG_ALERT,"\n\r*User LED1,control, led_off; rspcd = %d", rspcd);// LED1 消灯


   rspcd = drv_api_led (task_id,LED1,sv_close);
   syslog_1(LOG_ALERT,"\n\r*User LED1,close  ; rspcd = %d", rspcd);		// LED1 close


 	rspcd = drv_api_led (task_id,LED2,sv_close);
   syslog_1(LOG_ALERT,"\n\r*User LED2,close  ; rspcd = %d", rspcd);		// LED2 close


	syslog_0(LOG_ALERT,"\n\rUser_Task end");       		// End Message
/*
   rspcd = drv_api_sio (task_id, SIO1, open); 											
											
   char  cbuff='A';											
   rspcd = drv_api_sio (task_id, SIO1, control, sio_write_c, &cbuff);							// 文字出力
   char  sbuff[]="Test Message";											
   rspcd = drv_api_sio (task_id, SIO1, control, sio_write_s, sbuff);							// 文字列出力
   
   rspcd = drv_api_sio (task_id, SIO1, control, sio_read_s, sbuff);							// 文字列入力待ち
   do {											
   	dly_tsk(1000);										
   	rspcd = drv_api_sio (task_id, SIO1, control, sio_read_stat);						// 文字列入力完了確認
   } while (rspcd != rsp_ok);							// 入力されるまでLoop
   
   rspcd = drv_api_sio (task_id, SIO1, control, sio_read_s, sbuff);                  							// 文字列入力待ち
   dly_tsk(10000);											
   rspcd = drv_api_sio (task_id, SIO1, control, sio_read_stat);                  							// 10秒経過後の状態確認
   if (rspcd == rsp_waiting) {							// まだ入力されていなければ、入力待ちCancel
   	rspcd = drv_api_sio (task_id, SIO1, control, sio_read_cancel);                  										
   }											
   
   rspcd = drv_api_sio (task_id, SIO1, close);  											
   */

}
