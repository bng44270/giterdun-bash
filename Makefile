all:
	mkdir build
	mkdir build/include
	mkdir build/db
	mkdir build/web
	cp include/* build/include/
	@read -p "Enter install path [/opt/giterdun]: " installpath ; if [ -z "$$installpath" ]; then installpath="/opt/giterdun" ; fi ; m4 -D MAKEDBFILE=$$installpath/db/repos.db giterdun-m4.cgi > build/web/giterdun.cgi ; m4 -D MAKEDUNBASE="$$installpath" giterdun-m4.sh > build/giterdun.sh ; printf "/opt/giterdun" > build/install-path
	@read -p "Enter Git proxy servername [127.0.0.1]: " gitservername ; if [ -z "$$gitservername" ]; then gitservername="127.0.0.1" ; fi ; m4 -D MAKEGITSERVERNAME="$$gitservername" giterdun-m4.conf > build/web/giterdun.conf 
	chmod +x build/giterdun.sh
	chmod +x build/web/giterdun.cgi
	

clean:
	rm -rf build/

install:
	mkdir -p $$(cat build/install-path)
	cp -R build/* $$(cat build/install-path)
	rm $$(cat build/install-path)/install-path
