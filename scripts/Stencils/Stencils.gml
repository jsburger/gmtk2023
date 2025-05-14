function stencil_setup_write(mask) {
	gpu_set_stencil_enable(true);
	draw_clear_stencil(0);
	gpu_set_stencil_func(cmpfunc_always);
	gpu_set_stencil_ref(mask);
	gpu_set_stencil_pass(stencilop_replace);
}

function stencil_setup_read() {
	gpu_set_stencil_enable(true);
	gpu_set_stencil_func(cmpfunc_equal);
	gpu_set_stencil_pass(stencilop_keep);
}

function stencil_setup_avoid() {
	gpu_set_stencil_enable(true);
	gpu_set_stencil_func(cmpfunc_notequal);
	gpu_set_stencil_ref(gpu_get_stencil_ref() + 1);
	gpu_set_stencil_pass(stencilop_keep);
}

function stencil_disable() {
	gpu_set_stencil_enable(false);
}