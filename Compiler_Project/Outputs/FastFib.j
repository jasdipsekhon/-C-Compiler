.class public FastFib
.super java/lang/Object

.field private static _sysin Ljava/util/Scanner;

;
; Runtime input scanner
;
.method static <clinit>()V

	new	java/util/Scanner
	dup
	getstatic	java/lang/System/in Ljava/io/InputStream;
	invokespecial	java/util/Scanner/<init>(Ljava/io/InputStream;)V
	putstatic	FastFib/_sysin Ljava/util/Scanner;
	return

.limit locals 0
.limit stack 3
.end method

;
; Main class constructor
;
.method public <init>()V
.var 0 is this LFastFib;

	aload_0
	invokespecial	java/lang/Object/<init>()V
	return

.limit locals 1
.limit stack 1
.end method

;
; PROCEDURE main
;
.method private static main()V

.var 1 is fib_n I
.var 0 is i I
	iconst_0
	istore_1
	iconst_0
	istore_0
;
; 005 inti
;
L001:
;
; 007 print("Enter Number:")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Enter Number:"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 008 read(i)
;
	getstatic	FastFib/_sysin Ljava/util/Scanner;
	invokevirtual	java/util/Scanner/nextInt()I
	istore_0
	iload_0
	iconst_0
	if_icmpge	L005
	iconst_0
	goto	L006
L005:
	iconst_1
L006:
	iconst_0
	if_icmpeq	L004
;
; 010 intfib_n=fib(i)
;
	iload_0
	invokestatic	FastFib/fib(I)I
	istore_1
;
; 011 println("The ",i,(i==1)?"st":((i==2)?"nd":(i==3?"rd":"th"))," Fibbonac ...
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"The %d%s Fibbonachi number is: %d\n"
	iconst_3
	anewarray	java/lang/Object
	dup
	iconst_0
	iload_0
	invokestatic	java/lang/Integer/valueOf(I)Ljava/lang/Integer;
	aastore
	dup
	iconst_1
	iload_0
	iconst_1
	if_icmpeq	L009
	iconst_0
	goto	L010
L009:
	iconst_1
L010:
	iconst_0
	if_icmpeq	L007
	ldc	"st"
	goto	L008
L007:
	iload_0
	iconst_2
	if_icmpeq	L013
	iconst_0
	goto	L014
L013:
	iconst_1
L014:
	iconst_0
	if_icmpeq	L011
	ldc	"nd"
	goto	L012
L011:
	iload_0
	iconst_3
	if_icmpeq	L017
	iconst_0
	goto	L018
L017:
	iconst_1
L018:
	iconst_0
	if_icmpeq	L015
	ldc	"rd"
	goto	L016
L015:
	ldc	"th"
L016:
L012:
L008:
	aastore
	dup
	iconst_2
	iload_1
	invokestatic	java/lang/Integer/valueOf(I)Ljava/lang/Integer;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	goto	L003
L004:
L003:
;
; 014 println()
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	invokevirtual	java/io/PrintStream.println()V
	iload_0
	iconst_0
	if_icmpge	L019
	iconst_0
	goto	L020
L019:
	iconst_1
L020:
	iconst_1
	if_icmpeq	L001
L002:

	return

.limit locals 2
.limit stack 13
.end method

;
; FUNCTION fib
;
.method private static fib(I)I

.var 2 is arr [I
.var 1 is arrLen I
.var 3 is i I
.var 0 is index I
	iconst_0
	istore_1
	iconst_0
	istore_3
;
; 020 intarrLen=(index<=1)?2:index+1
;
	iload_0
	iconst_1
	if_icmple	L023
	iconst_0
	goto	L024
L023:
	iconst_1
L024:
	iconst_0
	if_icmpeq	L021
	iconst_2
	goto	L022
L021:
	iload_0
	iconst_1
	iadd
L022:
	istore_1
;
; 021 intarr[arrLen]
;

	iload_1
	newarray	int
	astore_2
;
; 022 arr[0]=0
;
	aload_2
	iconst_0
	iconst_0
	iastore
;
; 023 arr[1]=1
;
	aload_2
	iconst_1
	iconst_1
	iastore
;
; 024 inti=2
;
	iconst_2
	istore_3
L025:
	iload_3
	iload_0
	if_icmple	L027
	iconst_0
	goto	L028
L027:
	iconst_1
L028:
	iconst_0
	if_icmpeq	L026
;
; 025 arr[i]=arr[i-2]+arr[i-1]
;
	aload_2
	iload_3
	aload_2
	iload_3
	iconst_2
	isub
	iaload
	aload_2
	iload_3
	iconst_1
	isub
	iaload
	iadd
	iastore
;
; 024 i++
;
	iload_3
	iconst_1
	iadd
	istore_3
	goto	L025
L026:
;
; 027 print("Fib array: ")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Fib array: "
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 028 printList(arr,arrLen)
;
	aload_2
	iload_1
	invokestatic	FastFib/printList([II)V
;
; 029 returnarr[index]
;
	aload_2
	iload_0
	iaload
	ireturn

	ireturn

.limit locals 4
.limit stack 10
.end method

;
; PROCEDURE printList
;
.method private static printList([II)V

.var 2 is k I
.var 1 is len I
.var 0 is list [I
	iconst_0
	istore_2
;
; 034 print("[")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"["
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 035 intk=0
;
	iconst_0
	istore_2
L029:
	iload_2
	iload_1
	if_icmplt	L031
	iconst_0
	goto	L032
L031:
	iconst_1
L032:
	iconst_0
	if_icmpeq	L030
;
; 036 print(list[k])
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"%d"
	iconst_1
	anewarray	java/lang/Object
	dup
	iconst_0
	aload_0
	iload_2
	iaload
	invokestatic	java/lang/Integer/valueOf(I)Ljava/lang/Integer;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	iload_2
	iload_1
	iconst_1
	isub
	if_icmplt	L035
	iconst_0
	goto	L036
L035:
	iconst_1
L036:
	iconst_0
	if_icmpeq	L034
;
; 038 print(",")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	","
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
	goto	L033
L034:
L033:
;
; 035 k++
;
	iload_2
	iconst_1
	iadd
	istore_2
	goto	L029
L030:
;
; 041 println("]")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"]\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 042 return
;
	return

	return

.limit locals 3
.limit stack 10
.end method

;
; MAIN
;
.method public static main([Ljava/lang/String;)V
.var 0 is args [Ljava/lang/String;
.var 1 is _start Ljava/time/Instant;
.var 2 is _end Ljava/time/Instant;
.var 3 is _elapsed J

	invokestatic	java/time/Instant/now()Ljava/time/Instant;
	astore_1

	invokestatic	FastFib/main()V

	invokestatic	java/time/Instant/now()Ljava/time/Instant;
	astore_2
	aload_1
	aload_2
	invokestatic	java/time/Duration/between(Ljava/time/temporal/Temporal;Ljava/time/temporal/Temporal;)Ljava/time/Duration;
	invokevirtual	java/time/Duration/toMillis()J
	lstore_3
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"\n[%,d milliseconds execution time.]\n"
	iconst_1
	anewarray	java/lang/Object
	dup
	iconst_0
	lload_3
	invokestatic	java/lang/Long/valueOf(J)Ljava/lang/Long;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	return

.limit locals 6
.limit stack 14
.end method
