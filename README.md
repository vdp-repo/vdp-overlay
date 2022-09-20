# vdp-overlay


personal-overlay 

include 4.2.3 bitwig-studio for Gentoo

to make sure that you get the correct version of bitwig consider priority=[] found in 
the portage .conf file is higher then the one used by audio-overlay

you might want to --oneshot bitwig each update as the license does not include major updates after 1 year

	cp vdp-overlay /var/db/repos/vdp-overlay/
	cp vdp-overlay.conf /etc/portage/repos.conf/vdp-overlay.conf
	emaint sync -a

