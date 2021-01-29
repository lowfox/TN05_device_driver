#include "kernel_cfg.h"         	// Toppers Kernel Config Header
#include "hal.h"					// Toppers Header
#include "hal_extention.h"			// Toppers HAL_Extention Header
#include "mailbox.h"

int drv_api_led (int task_id,int dev_id,int req_code, ...){
    //可変個引数取得
    va_list args;
    va_start(args,req_code);
    int req_op = va_arg(args,int);
    int blink_time = va_arg(args,int);
    int blink_cycle = va_arg(args,int);

    //syslog_3(LOG_ALERT,"req_op=%d, blink_time=%d, blink_cyc=%d",req_op,blink_time,blink_cycle);

    //device_driver_taskに命令を送る
    //pkt領域確保
    //REQ_PKT* req_pkt = get
    //pktにデータ入力
    //REQ_MBXに送信

    return 0;




}