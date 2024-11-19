	.file	"mult_vector256.c"
	.text
	.p2align 4
	.globl	init
	.type	init, @function
init:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$4096, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.L2:
	leaq	-4096(%rbp), %rbx
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand
	vxorpd	%xmm1, %xmm1, %xmm1
	addq	$8, %rbx
	vcvtsi2sdl	%eax, %xmm1, %xmm0
	vdivsd	.LC0(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, A-8(%rbx)
	call	rand
	vxorpd	%xmm1, %xmm1, %xmm1
	movq	$0x000000000, C-8(%rbx)
	vcvtsi2sdl	%eax, %xmm1, %xmm0
	vdivsd	.LC0(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, B-8(%rbx)
	cmpq	%rbp, %rbx
	jne	.L3
	leaq	4096(%rbx), %rbp
	cmpq	$2097152, %rbx
	jne	.L2
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE20:
	.size	init, .-init
	.p2align 4
	.globl	mmult
	.type	mmult, @function
mmult:
.LFB21:
	.cfi_startproc
	movl	$C, %edi
	xorl	%r9d, %r9d
.L10:
	movq	%r9, %r10
	movl	$B, %r8d
	movl	$B+2097152, %ecx
	xorl	%esi, %esi
	salq	$12, %r10
	addq	$A, %r10
.L14:
	vmovapd	(%rdi,%rsi), %ymm1
	movq	%r10, %rdx
	movq	%r8, %rax
	.p2align 4,,10
	.p2align 3
.L11:
	vbroadcastsd	(%rdx), %ymm0
	vmulpd	(%rax), %ymm0, %ymm0
	addq	$4096, %rax
	addq	$8, %rdx
	vaddpd	%ymm0, %ymm1, %ymm1
	cmpq	%rcx, %rax
	jne	.L11
	vmovapd	%ymm1, (%rdi,%rsi)
	addq	$32, %rsi
	addq	$32, %r8
	leaq	32(%rax), %rcx
	cmpq	$4096, %rsi
	jne	.L14
	addq	$1, %r9
	addq	$4096, %rdi
	cmpq	$512, %r9
	jne	.L10
	vzeroupper
	ret
	.cfi_endproc
.LFE21:
	.size	mmult, .-mmult
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	call	init
	xorl	%eax, %eax
	call	mmult
	movl	$.LC2, %edi
	movl	$1, %eax
	vmovsd	C+2088(%rip), %xmm0
	call	printf
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.globl	C
	.bss
	.align 32
	.type	C, @object
	.size	C, 2097152
C:
	.zero	2097152
	.globl	B
	.align 32
	.type	B, @object
	.size	B, 2097152
B:
	.zero	2097152
	.globl	A
	.align 32
	.type	A, @object
	.size	A, 2097152
A:
	.zero	2097152
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.ident	"GCC: (GNU) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
