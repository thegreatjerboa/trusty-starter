#!/usr/bin/make -f

stamp := $(shell date +%s)

all: trusty
	@true

%: %-starter.box
	@true


%-starter.box:
	-vagrant up $*
	vagrant package $* --output $@
	vagrant box add -f thegreatjerboa/$*-starter $@
	vagrant destroy $* -f

clean: clean-trusty
	@true

clean-%:
	-taskkill /im ruby.exe /f
	-vagrant destroy $* -f
	-vagrant box remove thegreatjerboa/$*-starter
	rm -f ../../boxes/$*-starter.box


launch-%:
	mkdir -p $*-$(stamp)
	sed s/@RELEASE@/$*/ <Vagrantfile.in >$*-$(stamp)/Vagrantfile
	cp -r manifests $*-$(stamp)
	cd $*-$(stamp) && vagrant up

.SECONDARY:
