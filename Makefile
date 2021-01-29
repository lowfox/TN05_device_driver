#
#  TOPPERS/ASP Kernel
#      Toyohashi Open Platform for Embedded Real-Time Systems/
#      Advanced Standard Profile Kernel
# 
#  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
#                              Toyohashi Univ. of Technology, JAPAN
#  Copyright (C) 2006-2014 by Embedded and Real-Time Systems Laboratory
#              Graduate School of Information Science, Nagoya Univ., JAPAN
# 
#  上記著作権老E?E?E?以下?E(1)?E?E4)の条件を満たす場合に限り?E?本ソフトウェ
#  ア?E?本ソフトウェアを改変したものを含む?E?以下同じ）を使用・?E??・改
#  変?E再?E?E??以下，利用と呼ぶ?E?することを無償で許諾する?E?E#  (1) 本ソフトウェアをソースコード?E形で利用する場合には?E?上記?E著?E#      権表示?E?この利用条件および下記?E無保証規定が?E?そのままの形でソー
#      スコード中に含まれてぁE??こと?E?E#  (2) 本ソフトウェアを，ライブラリ形式など?E?他?Eソフトウェア開発に使
#      用できる形で再?E?E??る場合には?E??E配?E??伴ぁE??キュメント（利用
#      老E?Eニュアルなど?E?に?E?上記?E著作権表示?E?この利用条件および下?E#      の無保証規定を掲載すること?E?E#  (3) 本ソフトウェアを，機器に?E??込むなど?E?他?Eソフトウェア開発に使
#      用できなぁE??で再?E?E??る場合には?E?次のぁE??れかの条件を満たすぁE#      と?E?E#    (a) 再?E?E??伴ぁE??キュメント（利用老E?Eニュアルなど?E?に?E?上記?E?E#        作権表示?E?この利用条件および下記?E無保証規定を掲載すること?E?E#    (b) 再?E?E?E形態を?E?別に定める方法によって?E?TOPPERSプロジェクトに
#        報告すること?E?E#  (4) 本ソフトウェアの利用により直接?E??た?E間接?E??生じるいかなる損
#      害からも，上記著作権老E??よ?ETOPPERSプロジェクトを免責すること?E?E#      また，本ソフトウェアのユーザまた?EエンドユーザからのぁE??なる理
#      由に基づく請求からも?E?上記著作権老E??よ?ETOPPERSプロジェクトを
#      免責すること?E?E# 
#  本ソフトウェアは?E?無保証で提供されてぁE??も?Eである?E?上記著作権老E??
#  よ?ETOPPERSプロジェクト?E?E?本ソフトウェアに関して?E?特定?E使用目?E#  に対する適合性も含めて?E?いかなる保証も行わなぁE??また，本ソフトウェ
#  アの利用により直接?E??た?E間接?E??生じたいかなる損害に関しても，そ
#  の責任を負わなぁE??E# 
#  $Id: Makefile 2594 2014-01-02 07:08:54Z ertl-hiro $
# 

#
#  ターゲチE??の持E??！Eakefile.targetで上書きされるのを防ぐためE??E#
all:

#
#  ターゲチE??略称の定義
#
TARGET = nucleo_f401re_gcc

#
#  プログラミング言語?E定義
#
SRCLANG = c

ifeq ($(SRCLANG),c)
  LIBS = -lc
endif
ifeq ($(SRCLANG),c++)
  USE_CXX = true
  CXXLIBS = -lstdc++ -lm -lc
  CXXRTS = cxxrt.o newlibrt.o
endif

#
#  ソースファイルのチE??レクトリの定義
#
SRCDIR = ../../../../

#
#  オブジェクトファイル名?E拡張子?E設?E#
OBJEXT = elf

#
#  実行環?E?E定義?E?ターゲチE??依存に上書きされる場合がある?E?E#
DBGENV := 

#
#  カーネルライブラリ?E?Eibkernel.a?E??EチE??レクトリ吁E#  ?E?カーネルライブラリもmake対象にする時?E?E?空に定義する?E?E#
KERNEL_LIB = 

#
#  カーネルを関数単位でコンパイルするかどぁE??の定義
#
KERNEL_FUNCOBJS = 

#
#  トレースログを取得するかどぁE??の定義
#
ENABLE_TRACE = 

#
#  ユーチE??リチE??プログラムの名称
#
PERL = /usr/bin/perl
CFG = "$(SRCDIR)/cfg/cfg/cfg"

#
#  オブジェクトファイル名?E定義
#
OBJNAME = asp
ifdef OBJEXT
  OBJFILE = $(OBJNAME).$(OBJEXT)
  CFG1_OUT = cfg1_out.$(OBJEXT)
else
  OBJFILE = $(OBJNAME)
  CFG1_OUT = cfg1_out
endif

#
#  ターゲチE??依存部のチE??レクトリの定義
#
TARGETDIR = $(SRCDIR)/target/$(TARGET)

#
#  ターゲチE??依存?E定義のインクルーチE#
include $(TARGETDIR)/Makefile.target

#
#  コンフィギュレータ関係?E変数の定義
#
CFG_TABS := --api-table $(SRCDIR)/kernel/kernel_api.csv \
			--cfg1-def-table $(SRCDIR)/kernel/kernel_def.csv $(CFG_TABS)

CFG_ASMOBJS := $(CFG_ASMOBJS)
CFG_COBJS := kernel_cfg.o $(CFG_COBJS)
CFG_OBJS := $(CFG_ASMOBJS) $(CFG_COBJS)
CFG2_OUT_SRCS := kernel_cfg.h kernel_cfg.c $(CFG2_OUT_SRCS)

#
#  共通コンパイルオプションの定義
#
COPTS := $(COPTS) -g  -MD
ifndef OMIT_WARNING_ALL
  COPTS := $(COPTS) -Wall
endif
ifndef OMIT_OPTIMIZATION
  COPTS := $(COPTS) -O2
endif
CDEFS := $(CDEFS) 
INCLUDES := -I. -I$(SRCDIR)/include -I$(SRCDIR)/arch -I$(SRCDIR) $(INCLUDES)
#  -----------------------------------------------------------------------------
#  (角田) To avoid malloc_error at Build (Page_Size拡張)
# LDFLAGS := $(LDFLAGS) 
LDFLAGS := $(LDFLAGS) -Wl,--defsym=malloc_getpagesize_P=0x80
#  -----------------------------------------------------------------------------
CFG1_OUT_LDFLAGS := $(CFG1_OUT_LDFLAGS) 
LIBS := $(LIBS) $(CXXLIBS)
CFLAGS = $(COPTS) $(CDEFS) $(INCLUDES)

#
#  アプリケーションプログラムに関する定義
#
APPLNAME = hal
APPLDIR = hal_apl
APPL_CFG = $(APPLNAME).cfg

APPL_DIR = $(APPLDIR) $(SRCDIR)/library
APPL_ASMOBJS =
ifdef USE_CXX
  APPL_CXXOBJS = $(APPLNAME).o 
  APPL_COBJS = hal_apl
else
  APPL_COBJS = $(APPLNAME).o 
endif
APPL_COBJS := $(APPL_COBJS) log_output.o vasyslog.o t_perror.o strerror.o
#  -----------------------------------------------------------------------------
#  (角田) hal_apl フォルダに 追加のUser_Module(OBJ)があれば、ここに追記 
#         区切りはspace 又は \で次行に継続 (\の後にはCommentも書けないので注意)
APPL_COBJS := $(APPL_COBJS) hal_extention.o 				\
							device_api.o					\
							device_driver_task.o			\
							drv_user_task.o 
			
#  -----------------------------------------------------------------------------
APPL_CFLAGS =
APPL_LIBS = 
ifdef APPLDIR
  INCLUDES := $(INCLUDES) $(foreach dir,$(APPLDIR),-I$(dir))
endif

#
#  シスチE??サービスに関する定義
#
SYSSVC_DIR := $(SYSSVC_DIR) $(SRCDIR)/syssvc $(SRCDIR)/library
SYSSVC_ASMOBJS := $(SYSSVC_ASMOBJS)
SYSSVC_COBJS := $(SYSSVC_COBJS) banner.o syslog.o serial.o logtask.o \
				 $(CXXRTS)
SYSSVC_CFLAGS := $(SYSSVC_CFLAGS)
SYSSVC_LIBS := $(SYSSVC_LIBS)
INCLUDES := $(INCLUDES)

#
#  カーネルに関する定義
#
#  KERNEL_ASMOBJS: カーネルライブラリに含める?E?ソースがアセンブリ言語?E
#				   オブジェクトファイル?E?E#  KERNEL_COBJS: カーネルのライブラリに含める?E?ソースがC言語で?E?ソース
#				 ファイルと1対1に対応するオブジェクトファイル?E?E#  KERNEL_LCSRCS: カーネルのライブラリに含めるC言語?Eソースファイルで?E?E#				  1つのソースファイルから?E??のオブジェクトファイルを生
#				  成するもの?E?E#  KERNEL_LCOBJS: 上?Eソースファイルから生?Eされるオブジェクトファイル?E?E#  KERNEL_AUX_COBJS: ロードモジュールに含めなぁE???E?カーネルのソースファ
#					 イルと同じオプションを適用してコンパイルすべき，ソー
#					 スがC言語?Eオブジェクトファイル?E?E#
KERNEL_DIR := $(KERNEL_DIR) $(SRCDIR)/kernel
KERNEL_ASMOBJS := $(KERNEL_ASMOBJS)
KERNEL_COBJS := $(KERNEL_COBJS)
KERNEL_CFLAGS := $(KERNEL_CFLAGS) -I$(SRCDIR)/kernel
ifdef OMIT_MAKEOFFSET
  OFFSET_H =
else
  OFFSET_H = offset.h
ifndef OFFSET_TF
  KERNEL_AUX_COBJS := $(KERNEL_AUX_COBJS) makeoffset.o
endif
endif

#
#  ターゲチE??ファイル?E??E??を同時に選択してはならなぁE??E#
all: $(OBJFILE)
#all: $(OBJNAME).bin
#all: $(OBJNAME).srec

##### 以下?E編雁E??なぁE??と #####

#
#  環?E??依存するコンパイルオプションの定義
#
ifdef DBGENV
  CDEFS := $(CDEFS) -D$(DBGENV)
endif

#
#  カーネルのファイル構?Eの定義
#
include $(SRCDIR)/kernel/Makefile.kernel
ifdef KERNEL_FUNCOBJS
  KERNEL_LCSRCS := $(KERNEL_FCSRCS)
  KERNEL_LCOBJS := $(foreach file,$(KERNEL_FCSRCS),$($(file:.c=)))
else
  KERNEL_CFLAGS := -DALLFUNC $(KERNEL_CFLAGS)
  KERNEL_COBJS := $(KERNEL_COBJS) \
					$(foreach file,$(KERNEL_FCSRCS),$(file:.c=.o))
endif

#
#  ソースファイルのあるチE??レクトリに関する定義
#
vpath %.c $(KERNEL_DIR) $(SYSSVC_DIR) $(APPL_DIR)
vpath %.S $(KERNEL_DIR) $(SYSSVC_DIR) $(APPL_DIR)
vpath %.cfg $(APPL_DIR)

#
#  コンパイルのための変数の定義
#
KERNEL_LIB_OBJS = $(KERNEL_ASMOBJS) $(KERNEL_COBJS) $(KERNEL_LCOBJS)
SYSSVC_OBJS = $(SYSSVC_ASMOBJS) $(SYSSVC_COBJS)
APPL_OBJS = $(APPL_ASMOBJS) $(APPL_COBJS) $(APPL_CXXOBJS)
ALL_OBJS = $(START_OBJS) $(APPL_OBJS) $(SYSSVC_OBJS) $(CFG_OBJS) \
										$(END_OBJS) $(HIDDEN_OBJS)
ifdef KERNEL_LIB
  ALL_LIBS = $(APPL_LIBS) $(SYSSVC_LIBS) -lkernel $(LIBS)
  LIBS_DEP = $(filter %.a,$(ALL_LIBS)) $(KERNEL_LIB)/libkernel.a
  LDFLAGS := $(LDFLAGS) -L$(KERNEL_LIB)
  REALCLEAN_FILES := libkernel.a $(REALCLEAN_FILES)
else
  ALL_LIBS = $(APPL_LIBS) $(SYSSVC_LIBS) libkernel.a $(LIBS)
  LIBS_DEP = $(filter %.a,$(ALL_LIBS))
endif

ifdef TEXT_START_ADDRESS
  LDFLAGS := $(LDFLAGS) -Wl,-Ttext,$(TEXT_START_ADDRESS)
  CFG1_OUT_LDFLAGS := $(CFG1_OUT_LDFLAGS) -Wl,-Ttext,$(TEXT_START_ADDRESS)
endif
ifdef DATA_START_ADDRESS
  LDFLAGS := $(LDFLAGS) -Wl,-Tdata,$(DATA_START_ADDRESS)
  CFG1_OUT_LDFLAGS := $(CFG1_OUT_LDFLAGS) -Wl,-Tdata,$(DATA_START_ADDRESS)
endif
ifdef LDSCRIPT
  LDFLAGS := $(LDFLAGS) -T $(LDSCRIPT)
  CFG1_OUT_LDFLAGS := $(CFG1_OUT_LDFLAGS) -T $(LDSCRIPT)
endif

#
#  オフセチE??ファイル?E?Effset.h?E??E生?E規則
#
ifdef OFFSET_TF
offset.h: $(APPL_CFG) kernel_cfg.timestamp
	$(CFG) --pass 3 --kernel asp $(INCLUDES) \
				--rom-image cfg1_out.srec --symbol-table cfg1_out.syms \
				-T $(OFFSET_TF) $(CFG_TABS) $<
else
offset.h: makeoffset.s $(SRCDIR)/utils/genoffset
	$(PERL) $(SRCDIR)/utils/genoffset makeoffset.s > offset.h
endif

ifneq (,$(findstring /cygdrive/,$(PATH)))
    UNAME := Cygwin
else
ifeq ($(OS),Windows_NT)
    UNAME := Windows
else
ifeq ($(UNAME),Linux)
    UNAME := Linux
ifeq ($(UNAME),Darwin)
    UNAME := Darwin
endif
endif
endif
endif

#
#  カーネルのコンフィギュレーションファイルの生?E
#
cfg1_out.c: $(APPL_CFG)
	$(CFG) --pass 1 --kernel asp $(INCLUDES) $(CFG_TABS) $<
	$(CFG) -M cfg1_out.c $(INCLUDES) $< >> cfg1_out.c.d

$(CFG2_OUT_SRCS): kernel_cfg.timestamp
kernel_cfg.timestamp: $(APPL_CFG) \
						$(START_OBJS) cfg1_out.o $(END_OBJS) $(HIDDEN_OBJS)
	$(LINK) $(CFLAGS) $(CFG1_OUT_LDFLAGS) -o $(CFG1_OUT) \
						$(START_OBJS) cfg1_out.o $(END_OBJS)
	$(NM) -n $(CFG1_OUT) > cfg1_out.syms
	$(OBJCOPY) -O srec -S $(CFG1_OUT) cfg1_out.srec
	$(CFG) --pass 2 --kernel asp $(INCLUDES) \
				-T $(TARGETDIR)/target.tf $(CFG_TABS) $<
ifeq ($(UNAME), Windows)
	copy /B kernel_cfg.c +,,
	echo  -n > kernel_cfg.timestamp
else
	touch -r kernel_cfg.c kernel_cfg.timestamp
endif

#
#  カーネルライブラリファイルの生?E
#
libkernel.a: $(OFFSET_H) $(KERNEL_LIB_OBJS)
	-rm -f libkernel.a
	$(AR) -rcs libkernel.a $(KERNEL_LIB_OBJS)
	$(RANLIB) libkernel.a

#
#  特別な依存関係?E定義
#
banner.o: kernel_cfg.timestamp $(filter-out banner.o,$(ALL_OBJS)) $(LIBS_DEP)

#
#  全体?Eリンク
#
$(OBJFILE): $(APPL_CFG) kernel_cfg.timestamp $(ALL_OBJS) $(LIBS_DEP)
	$(LINK) $(CFLAGS) $(LDFLAGS) -o $(OBJFILE) $(START_OBJS) \
			$(APPL_OBJS) $(SYSSVC_OBJS) $(CFG_OBJS) $(ALL_LIBS) $(END_OBJS)
	$(NM) -n $(OBJFILE) > $(OBJNAME).syms
	$(OBJCOPY) -O srec -S $(OBJFILE) $(OBJNAME).srec
	$(CFG) --pass 3 --kernel asp $(INCLUDES) \
				--rom-image $(OBJNAME).srec --symbol-table $(OBJNAME).syms \
				-T $(TARGETDIR)/target_check.tf $(CFG_TABS) $<

#
#  バイナリファイルの生?E
#
$(OBJNAME).bin: $(OBJFILE)
	$(OBJCOPY) -O binary -S $(OBJFILE) $(OBJNAME).bin

#
#  Sレコードファイルの生?E
#
$(OBJNAME).srec: $(OBJFILE)
	$(OBJCOPY) -O srec -S $(OBJFILE) $(OBJNAME).srec

#
#  コンパイル結果の消去
#
.PHONY: clean
clean:
	-rm -f *.o *.d $(CLEAN_FILES)
	-rm -f $(OBJFILE) $(OBJNAME).syms $(OBJNAME).srec $(OBJNAME).bin
	-rm -f kernel_cfg.timestamp $(CFG2_OUT_SRCS)
	-rm -f cfg1_out.c $(CFG1_OUT) cfg1_out.syms cfg1_out.srec
ifndef KERNEL_LIB
	-rm -f libkernel.a
endif
	-rm -f makeoffset.s offset.h

.PHONY: cleankernel
cleankernel:
	-rm -rf $(KERNEL_LIB_OBJS)
	-rm -f makeoffset.s offset.h

.PHONY: cleandep
cleandep:
	-rm -f kernel_cfg.timestamp $(CFG2_OUT_SRCS); \
	-rm -f cfg1_out.c cfg1_out.o $(CFG1_OUT) cfg1_out.syms cfg1_out.srec; \
	-rm -f makeoffset.s offset.h; \

.PHONY: realclean
realclean: cleandep clean
	-rm -f $(REALCLEAN_FILES)

#
#  コンフィギュレータが生成したファイルのコンパイルルールと依存関係作?E
#  ルールの定義
#
#  コンフィギュレータが生成したファイルは?E?アプリケーションプログラム用?E?E#  シスチE??サービス用?E?カーネル用のすべてのオプションを付けてコンパイル
#  する?E?E#
ALL_CFG_COBJS = $(CFG_COBJS) cfg1_out.o
ALL_CFG_ASMOBJS = $(CFG_ASMOBJS)
CFG_CFLAGS = $(APPL_CFLAGS) $(SYSSVC_CFLAGS) $(KERNEL_CFLAGS)

$(ALL_CFG_COBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $(CFG_CFLAGS) $<

#$(ALL_CFG_COBJS:.o=.s): %.s: %.c
#	$(CC) -S $(CFLAGS) $(CFG_CFLAGS) $<

$(ALL_CFG_ASMOBJS): %.o: %.S
	$(CC) -c $(CFLAGS) $(CFG_CFLAGS) $<

#
#  依存関係ファイルをインクルーチE#
-include *.d

#
#  開発チE?Eルのコマンド名の定義
#
ifeq ($(TOOL),gcc)
  #
  #  GNU開発環?E??
  #
  ifdef GCC_TARGET
    GCC_TARGET_PREFIX = $(GCC_TARGET)-
  else
    GCC_TARGET_PREFIX =
  endif
#
#  Windowsの場合?Eフルパスにする
#
ifeq ($(UNAME),Windows)
  GCC_TARGET_PREFIX = arm-atollic-eabi-
  CC = $(GCC_TARGET_PREFIX)gcc
  CXX = $(GCC_TARGET_PREFIX)g++
  AS = $(GCC_TARGET_PREFIX)as
  LD = $(GCC_TARGET_PREFIX)ld
  AR = $(GCC_TARGET_PREFIX)ar
  NM = $(GCC_TARGET_PREFIX)nm
  RANLIB = $(GCC_TARGET_PREFIX)ranlib
  OBJCOPY = $(GCC_TARGET_PREFIX)objcopy
  OBJDUMP = $(GCC_TARGET_PREFIX)objdump
endif
endif

ifdef USE_CXX
  LINK = $(CXX)
else
  LINK = $(CC)
endif

#
#  コンパイルルールの定義
#
KERNEL_ALL_COBJS = $(KERNEL_COBJS) $(KERNEL_AUX_COBJS)

$(KERNEL_ALL_COBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $(KERNEL_CFLAGS) $<

#$(KERNEL_ALL_COBJS:.o=.s): %.s: %.c
#	$(CC) -S $(CFLAGS) $(KERNEL_CFLAGS) $<

$(KERNEL_LCOBJS): %.o:
	$(CC) -DTOPPERS_$(*F) -o $@ -c $(CFLAGS) $(KERNEL_CFLAGS) $<

#$(KERNEL_LCOBJS:.o=.s): %.s:
#	$(CC) -DTOPPERS_$(*F) -o $@ -S $(CFLAGS) $(KERNEL_CFLAGS) $<

$(KERNEL_ASMOBJS): %.o: %.S
	$(CC) -c $(CFLAGS) $(KERNEL_CFLAGS) $<

$(SYSSVC_COBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $(SYSSVC_CFLAGS) $<

#$(SYSSVC_COBJS:.o=.s): %.s: %.c
#	$(CC) -S $(CFLAGS) $(SYSSVC_CFLAGS) $<

$(SYSSVC_ASMOBJS): %.o: %.S
	$(CC) -c $(CFLAGS) $(SYSSVC_CFLAGS) $<

$(APPL_COBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $(APPL_CFLAGS) $<

#$(APPL_COBJS:.o=.s): %.s: %.c
#	$(CC) -S $(CFLAGS) $(APPL_CFLAGS) $<

$(APPL_CXXOBJS): %.o: %.cpp
	$(CXX) -c $(CFLAGS) $(APPL_CFLAGS) $<

#$(APPL_CXXOBJS:.o=.s): %.s: %.cpp
#	$(CXX) -S $(CFLAGS) $(APPL_CFLAGS) $<

$(APPL_ASMOBJS): %.o: %.S
	$(CC) -c $(CFLAGS) $(APPL_CFLAGS) $<

#
#  チE??ォルトコンパイルルールを上書ぁE#
%.o: %.c
	@echo "*** Default compile rules should not be used."
	$(CC) -c $(CFLAGS) $<

%.s: %.c
	@echo "*** Default compile rules should not be used."
	$(CC) -S $(CFLAGS) $<

%.o: %.cpp
	@echo "*** Default compile rules should not be used."
	$(CXX) -c $(CFLAGS) $<

%.s: %.cpp
	@echo "*** Default compile rules should not be used."
	$(CXX) -S $(CFLAGS) $<

%.o: %.S
	@echo "*** Default compile rules should not be used."
	$(CC) -c $(CFLAGS) $<
