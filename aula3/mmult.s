	.file	"mmult_vector.c"
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
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	C(%rip), %r12
	xorl	%r11d, %r11d
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	B(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	A(%rip), %rbx
	leaq	4096(%r12), %r8
	leaq	2097152(%rbp), %r10
.L11:
	movq	%rbp, %rsi
	leaq	(%r12,%r11,8), %rdx
	movq	%rbx, %r9
.L19:
	movq	%r9, %rdi
	addq	$8, %r9
	cmpq	%r8, %rdi
	setnb	%al
	cmpq	%r9, %rdx
	setnb	%cl
	orb	%cl, %al
	je	.L20
	leaq	8(%rsi), %rax
	cmpq	%rax, %rdx
	je	.L20
	xorl	%eax, %eax
	movddup	(%rdi), %xmm1
	.p2align 4,,10
	.p2align 3
.L14:
	movupd	(%rsi,%rax), %xmm0
	movupd	(%rdx,%rax), %xmm2
	mulpd	%xmm1, %xmm0
	addpd	%xmm2, %xmm0
	movups	%xmm0, (%rdx,%rax)
	addq	$16, %rax
	cmpq	$4096, %rax
	jne	.L14
	addq	$4096, %rsi
	cmpq	%r10, %rsi
	jne	.L19
.L15:
	addq	$512, %r11
	addq	$4096, %r8
	addq	$4096, %rbx
	cmpq	$262144, %r11
	jne	.L11
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L20:
	.cfi_restore_state
	movq	%rsi, %rcx
	movq	%rdx, %rax
	.p2align 4,,10
	.p2align 3
.L12:
	movsd	(%rdi), %xmm0
	mulsd	(%rcx), %xmm0
	addq	$8, %rax
	addq	$8, %rcx
	addsd	-8(%rax), %xmm0
	movsd	%xmm0, -8(%rax)
	cmpq	%r8, %rax
	jne	.L12
	addq	$4096, %rsi
	cmpq	%r10, %rsi
	jne	.L19
	jmp	.L15
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
