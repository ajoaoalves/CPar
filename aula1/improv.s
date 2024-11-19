	.file	"improv.c"
	.text
	.p2align 4
	.globl	alloc
	.type	alloc, @function
alloc:
.LFB20:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$2097152, %edi
	call	malloc
	movl	$2097152, %edi
	movq	%rax, A(%rip)
	call	malloc
	movl	$2097152, %edi
	movq	%rax, B(%rip)
	call	malloc
	movq	%rax, C(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE20:
	.size	alloc, .-alloc
	.p2align 4
	.globl	init
	.type	init, @function
init:
.LFB21:
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
.L5:
	leaq	-4096(%rbp), %rbx
	.p2align 4,,10
	.p2align 3
.L6:
	call	rand
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movq	A(%rip), %rax
	movsd	%xmm0, (%rax,%rbx)
	call	rand
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movq	B(%rip), %rax
	movsd	%xmm0, (%rax,%rbx)
	movq	C(%rip), %rax
	movq	$0x000000000, (%rax,%rbx)
	addq	$8, %rbx
	cmpq	%rbp, %rbx
	jne	.L6
	leaq	4096(%rbx), %rbp
	cmpq	$2097152, %rbx
	jne	.L5
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE21:
	.size	init, .-init
	.p2align 4
	.globl	mmult
	.type	mmult, @function
mmult:
.LFB22:
	.cfi_startproc
	movq	B(%rip), %rax
	movq	C(%rip), %r10
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xorl	%r9d, %r9d
	movq	A(%rip), %rbx
	leaq	2097152(%rax), %r11
.L11:
	movq	%r9, %r8
	movq	%r11, %rsi
	movq	%r10, %rcx
	xorl	%edi, %edi
	salq	$12, %r8
	addq	%rbx, %r8
.L15:
	movsd	(%rcx), %xmm4
	movsd	8(%rcx), %xmm3
	movq	%r8, %rdx
	leaq	-2097152(%rsi), %rax
	movsd	16(%rcx), %xmm2
	movsd	24(%rcx), %xmm1
	.p2align 4,,10
	.p2align 3
.L12:
	movsd	(%rdx), %xmm0
	mulsd	(%rax), %xmm0
	addq	$4096, %rax
	addq	$8, %rdx
	addsd	%xmm0, %xmm4
	movsd	%xmm4, (%rcx)
	movsd	-8(%rdx), %xmm0
	mulsd	-4088(%rax), %xmm0
	addsd	%xmm0, %xmm3
	movsd	%xmm3, 8(%rcx)
	movsd	-8(%rdx), %xmm0
	mulsd	-4080(%rax), %xmm0
	addsd	%xmm0, %xmm2
	movsd	%xmm2, 16(%rcx)
	movsd	-8(%rdx), %xmm0
	mulsd	-4072(%rax), %xmm0
	addsd	%xmm0, %xmm1
	movsd	%xmm1, 24(%rcx)
	cmpq	%rax, %rsi
	jne	.L12
	addl	$4, %edi
	addq	$32, %rcx
	addq	$32, %rsi
	cmpl	$512, %edi
	jne	.L15
	addq	$1, %r9
	addq	$4096, %r10
	cmpq	$512, %r9
	jne	.L11
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	mmult, .-mmult
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	call	alloc
	xorl	%eax, %eax
	call	init
	xorl	%eax, %eax
	call	mmult
	movq	C(%rip), %rax
	movl	$.LC1, %edi
	movsd	2088(%rax), %xmm0
	movl	$1, %eax
	call	printf
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	C
	.bss
	.align 8
	.type	C, @object
	.size	C, 8
C:
	.zero	8
	.globl	B
	.align 8
	.type	B, @object
	.size	B, 8
B:
	.zero	8
	.globl	A
	.align 8
	.type	A, @object
	.size	A, 8
A:
	.zero	8
	.ident	"GCC: (GNU) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
