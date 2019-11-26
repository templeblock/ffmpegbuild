# ffmpegbuild

## ffmpeg4.2.1
### NDK r20

##### 编译动态库
	  # 将ffmpeg-4.2.1目录中configure 文件中的：
		SLIBNAME_WITH_MAJOR='$(SLIBNAME).$(LIBMAJOR)' 
		LIB_INSTALL_EXTRA_CMD='$$(RANLIB) "$(LIBDIR)/$(LIBNAME)"' 
		SLIB_INSTALL_NAME='$(SLIBNAME_WITH_VERSION)' 
		SLIB_INSTALL_LINKS='$(SLIBNAME_WITH_MAJOR) $(SLIBNAME)'

		#替换为：
		SLIBNAME_WITH_MAJOR='$(SLIBPREF)$(FULLNAME)-$(LIBMAJOR)$(SLIBSUF)'
		LIB_INSTALL_EXTRA_CMD='$$(RANLIB) "$(LIBDIR)/$(LIBNAME)"'
		SLIB_INSTALL_NAME='$(SLIBNAME_WITH_MAJOR)'
		SLIB_INSTALL_LINKS='$(SLIBNAME)'

##### API=29遇到的问题
		dlopen failed: "has text relocations"
		解决方案：--disable-asm 
		在低版本手机中就会遇到这个问题：dlopen failed: cannot locate symbol "iconv_open"，”iconv_close“ ，只能降低API 版本

##### API=21遇到的问题：
		1. In file included from libswscale/x86/rgb2rgb.c:102: 
		libswscale/x86/rgb2rgb_template.c:1666:13: error: inline assembly requires more 
		      registers than available 
		            "mov                        %4, %%"FF_REG_a"\n\t" 
		            ^ 
		In file included from libswscale/x86/rgb2rgb.c:136: 
		libswscale/x86/rgb2rgb_template.c:1666:13: error: inline assembly requires more 
		      registers than available 
		            "mov                        %4, %%"FF_REG_a"\n\t" 
		            ^ 
		In file included from libswscale/x86/rgb2rgb.c:109: 
		libswscale/x86/rgb2rgb_template.c:1666:13: error: inline assembly requires more 
		      registers than available 
		            "mov                        %4, %%"FF_REG_a"\n\t" 
            ^ 
	解决方案：--disable-iconv 才可以解决
