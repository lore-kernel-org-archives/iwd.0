Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBD946C
	for <iwd@lists.linux.dev>; Sat, 12 Oct 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731225; cv=none; b=uykCnqFDyUchCPr3QNJwJAKjhODVow1oaXQG7Z8dThWRmoWvFnJYVcVO5PGpvO6CyLCsNSfTc3+sg0jFWEZ/+8nSYDrfZYOxDXQt1mKephHz+KOAJ2CN+serJPCVUdKxk9X2BGxZMTIdsJolvUQJXUMG2l0oAXscKL/5ZDNCKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731225; c=relaxed/simple;
	bh=ZAveBlE2OXoXO2CkAyYPics/6xwbI+yroV6vuak46JQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N0sohkm3yefDNkXqymlyDSxYtdA8ku9LhyNkeucOioZrcGzU41hptiDkGbygiKfU+/itlUWghC3keI+N0w9AIT2v+ofjTUcWwIR17CJzsjJM9bqMFGOEudYCFXb4rJpF+ey6sqnzVG8rPQxpOsM1OwB837QwX7PxN+9XvU3tzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=E5qjdrtG; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="E5qjdrtG"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XQgfy6w6gzDv41;
	Sat, 12 Oct 2024 13:06:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728731211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLzIbRSzuLz2Y27b3uiBROuCjcG3+qFFyNYBWmW+O5Q=;
	b=E5qjdrtGQKDYqcCjDFjHkOM2RB/M3mP3kF25lN+Sm2J48q1kOKIAGN4xtxXMNZLaPvh1ML
	tiH4dsSqT/y+nkt9tvPY7t8ZYtrHXrhvgMm7/CuKQQF5OrG0YznAFpjaSpTXd7P3cnCV8e
	BHjK+Q/+hUSYR6TCHs2cCUZxAhyN9h9kq8ETIiUG5wLVEVviBzAveh+smhyTlqQyeZML4H
	XvaJcf9Hb0e9GyVxyet8i2M54vKULXQ9bO3qvMVig7daK6hBY3Bcitnx2aEfKlNhGU84X9
	Tyd4Q4KN8Uh4dWSh81DIAJy8bUu7eR5Mq5CgTR98kohPZzmvsSdG4spUZup6Hw==
Message-ID: <717feddd-8756-4271-8c05-5ef46ff9e8d2@tavla.de>
Date: Sat, 12 Oct 2024 13:06:49 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
From: Martin Petzold <martin.petzold@tavla.de>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <69cc8b13-e6b4-43c5-8ba3-7877a75f0581@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <69cc8b13-e6b4-43c5-8ba3-7877a75f0581@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arend,

Am 10.10.24 um 10:06 schrieb Martin Petzold:
> Hi Arend,
>
> Am 09.10.24 um 18:50 schrieb Arend Van Spriel:
>> On October 9, 2024 6:07:16 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>>> Hi Martin,
>>>
>>> On 10/9/24 4:43 AM, Martin Petzold wrote:
>>>> Hi
>>>>
>>>> PROBLEM
>>>>
>>>> We (still) have some trouble with IWD together with brcmfmac. We 
>>>> updated
>>>> firmware for the chip (Infineon CYW43353) to latest version 
>>>> 11.171.0.24 and also
>>>
>>> Ugh :)  That stuff is known to be problematic.  You might want to 
>>> involve Arend
>>> in this discussion.
>>
>> Is this specifically related to WPA3 or in general? The version does 
>> not tell me much and I don't have access to Infineon firmware to 
>> examine. I do know there are two variants floating around regarding 
>> WPA3-SAE support: 1) supplicant in firmware and 2) using EXT_AUTH. 
>> The latter is supported in  downstream repo on github, but it has not 
>> been done in upstream linux-wireless. I did post patches for testing 
>> last month. 
>
> I was able to migrate to NXP kernel 6.1.36 with Debian bookworm rootfs 
> containing IWD 2.3. I will try also to build IWD 2.22 later. If this 
> setup / configuration makes sense I would go to roaming environments 
> again. However, I have the following questions and please find the 
> configuration and logs below:
>
> 1. Why does brcmfmac report "Using regulatory domain US" even though I 
> have set "ccode=EU" and "regrev=116" in 
> /lib/firmware/brcm/brcmfmac4339-sdio.txt?

I had an entry in the device tree (laird,regdomain = "US"), which seems 
to be stronger than the value in the brcmfmac4339-sdio.txt. Can you confirm?

Now I don't get any output like "Using regulatory domain ..." any more. 
How can I now be sure that EU (ETSI) is used?


> 2. Is it the best approach to use firmware for Laird LWB5 / CYW43353 
> from their Git repository (laird-lwb5-etsi-firmware-11.171.0.24.tar.bz2)?

Here I switched to newer version 12.29.0.22. I assume this firmware is 
the correct one and should work with the Kernel brcmfmac driver 
(6.1.36), right?


> 3. If you say roaming can be handled by firmware (driver?) OR daemon 
> (IWD), what is the best approach and how to configure it?

This question is still open for me. In general the question, will 
brcmfmac work with the laird firmware and IWD stable (really good) also 
for roaming?


> 4. Is it valid to always use brcm-patchram-plus to load the firmware 
> on every boot?
> 5. I see the following error (more log below). What is going wrong?
>
> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
> load for brcm/brcmfmac4339-sdio.variscite,imx8mp-var-dart.bin failed 
> with error -2
> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
> load for brcm/brcmfmac4339-sdio.clm_blob failed with error -2
> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_c_process_clm_blob: no 
> clm_blob available (err=-2), device may have limited channels available

What about the "clm_blob". Is it required in file system for 4339? (I 
don't want to have limited channels)

Thanks,

Martin

>
> 6. Anything wrong in setup / configuration?
>
> ##### Setup
>
> SoM: Variscite DART-IMX8M-PLUS
> SoC: NXP i.MX8M Plus
> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
> Antenna: Laird FlexPIFA
> RootFS: Debian bookworm
> Kernel: NXP Kernel 6.1.36
> Firmware: Laird 11.171.0.24
> Network Daemon: systemd-networkd 252.30-1~deb12u2
> Wi-Fi Daemon: IWD 2.3-1+deb12u1
> DNS Resolver: systemd-resolved 252.30-1~deb12u2
>
> ##### Firmware configuration
>
> # Sample variables file for BCM94339 WLBGA with eTR,iPA, and eLNA. 
> Laird Sterling-LWB5 CYW43353
> NVRAMRev=$Rev: 410316 $
> sromrev=11
> boardrev=0x1203
> boardtype=0x06c5
> boardflags=0x00000c01
> boardflags2=0x00002000
> boardflags3=0x8101188
> macaddr=00:90:4c:c5:12:38
> cctl=0
> ccode=EU
> regrev=116
> antswitch=0
> pdgain5g=7
> pdgain2g=7
> tworangetssi2g=0
> tworangetssi5g=0
> femctrl=7
> vendid=0x14e4
> devid=0x43ae
> manfid=0x2d0
> nocrc=1
> otpimagesize=502
> xtalfreq=37400
> extpagain2g=2
> pdetrange2g=2
> extpagain5g=2
> pdetrange5g=2
> rxgains2gelnagaina0=0
> rxgains2gtrisoa0=7
> rxgains2gtrelnabypa0=0
> rxgains5gelnagaina0=0
> rxgains5gtrisoa0=11
> rxgains5gtrelnabypa0=0
> rxchain=1
> txchain=1
> aa2g=1
> aa5g=1
> tssipos5g=0
> tssipos2g=0
> pa2ga0=-159,5841,-699
> pa2gccka0=-162,6244,-755
> pa5ga0=-185,5721,-690,-185,5693,-688,-193,5445,-670,-194,5352,-661
> pa5gbw40a0=-188,5836,-710,-187,5839,-708,-173,5956,-714,-159,6022,-712
> pa5gbw80a0=-184,5789,-700,-185,5784,-700,-175,5797,-699,-172,5749,-692
> pdoffset40ma0=0
> pdoffset80ma0=0
> pdoffsetcckma0=0
> maxp2ga0=0x4A
> maxp5ga0=0x4A,0x4A,0x4A,0x4A
> cckbw202gpo=0x0000
> cckbw20ul2gpo=0x0000
> mcsbw202gpo=0x66666666
> mcsbw402gpo=0x66666666
> dot11agofdmhrbw202gpo=0x4444
> ofdmlrbw202gpo=0x4444
> tssifloor2g=500
> mcsbw205glpo=0x22222222
> mcsbw405glpo=0x55555555
> mcsbw805glpo=0xaaaaaaaa
> mcsbw1605glpo=0xffffffff
> mcsbw205gmpo=0x22222222
> mcsbw405gmpo=0x55555555
> mcsbw805gmpo=0xaaaaaaaa
> mcsbw1605gmpo=0xffffffff
> mcsbw205ghpo=0x22222222
> mcsbw405ghpo=0x55555555
> mcsbw805ghpo=0xaaaaaaaa
> mcsbw1605ghpo=0xffffffff
> mcslr5glpo=0x0000
> mcslr5gmpo=0x0000
> mcslr5ghpo=0x0000
> sb20in40hrpo=0x0
> sb20in80and160hr5glpo=0x0
> sb40and80hr5glpo=0x0
> sb20in80and160hr5gmpo=0x0
> sb40and80hr5gmpo=0x0
> sb20in80and160hr5ghpo=0x0
> sb40and80hr5ghpo=0x0
> sb20in40lrpo=0x0
> sb20in80and160lr5glpo=0x0
> sb40and80lr5glpo=0x0
> sb20in80and160lr5gmpo=0x0
> sb40and80lr5gmpo=0x0
> sb20in80and160lr5ghpo=0x0
> sb40and80lr5ghpo=0x0
> dot11agduphrpo=0x0
> dot11agduplrpo=0x0
> phycal_tempdelta=25
> cckdigfilttype=2
> swctrlmap_5g=0x00000008,0x00000010,0x00000008,0x000000,0x038
> swctrlmap_2g=0x00000001,0x00000002,0x00000001,0x040002,0x0ff
> swctrlmapext_5g=0x00000000,0x00000000,0x00000000,0x000000,0x000
> swctrlmapext_2g=0x00000000,0x00000000,0x00000000,0x000000,0x000
> muxenab=0x11
> rssicorrnorm_c0=3,3
> rssicorrnorm5g_c0=2,3,4,2,3,3,0,1,2,0,1,2
> paparambwver=1
> AvVmid_c0=2,155,2,146,2,150,2,154,2,152
> ed_thresh2g=-70
> ed_thresh5g=-73
> txidxcap2g=0
> txidxcap5g=0
>
> ##### IWD configuration (/etc/iwd/main.conf)
>
> [General]
> EnableNetworkConfiguration=true
>
> [Network]
> NameResolvingService=systemd
> EnableIPv6=false
>
> ##### systemd-networkd configuration 
> (/etc/systemd/network/10-eth0.network) - no wifi device configured 
> (handled by IWD only?!)
>
> [Match]
> Name=eth0
>
> [Network]
> DHCP=ipv4
>
> [Link]
> RequiredForOnline=no
>
> ##### WiFi startup
>
> tavla@tavla:~$ cat /lib/systemd/system/variscite-wifi.service
> [Unit]
> Description=Variscite WIFI service
> Before=network.target
> After=sysinit.target
>
> [Service]
> Type=oneshot
>
> RemainAfterExit=yes
>
> ExecStart=/opt/variscite/bin/wifi start
> #ExecStop=/opt/variscite/bin/wifi stop
>
> [Install]
> WantedBy=network.target
>
> tavla@tavla:~$ cat /opt/variscite/bin/wifi
> #!/bin/sh -e
>
> # Include common wireless functions
> . /opt/variscite/bin/common
>
> # Start WIFI hardware
> wifi_start()
> {
>     run_scripts "/opt/variscite/lib/wifi.d" "start"
> }
>
> # Stop WIFI hardware
> # Note that on DART-MX8M this also stops Ethernet
> wifi_stop()
> {
>     run_scripts "/opt/variscite/lib/wifi.d" "stop"
> }
>
> ###########################
> #  Execution starts here  #
> ###########################
> case $1 in
> start)
>     wifi_start
>     ;;
> stop)
>     wifi_stop
>     ;;
> esac
>
> exit
>
> tavla@tavla:~$ cat /opt/variscite/lib/wifi.d/bcm43xx-wifi
> #!/bin/sh -e
> #
> # Activate WIFI on Variscite DART-MX8M-PLUS/VAR-SOM-MX8M-PLUS
> #
>
> # Include common functions
> . /opt/variscite/bin/common
>
> # GPIO pin to supply WIFI power on DART-MX8M-PLUS
> WIFI_PWR_GPIO_DART="gpiochip1 8"
>
> # GPIO pin to supply WIFI power on VAR-SOM-MX8M-PLUS
> WIFI_PWR_GPIO_SOM="gpiochip1 19"
>
> # GPIO pin to enable WIFI module on DART-MX8M-PLUS
> WIFI_EN_GPIO_DART="gpiochip1 7"
>
> # GPIO pin to enable WIFI module on VAR-SOM-MX8M-PLUS
> WIFI_EN_GPIO_SOM="gpiochip1 8"
>
> # GPIO pin to control routing of UART signals
> # to BT module or SOM connectoron DART-MX8M-PLUS
> BT_BUF_GPIO_DART="gpiochip1 9"
>
> # GPIO pin to control routing of UART signals
> # to BT module or SOM connectoron VAR-SOM-MX8M-PLUS
> BT_BUF_GPIO_SOM="gpiochip0 4"
>
> # GPIO pin to enable BT module on DART-MX8M-PLUS
> BT_EN_GPIO_DART="gpiochip1 6"
>
> # GPIO pin to enable BT module on VAR-SOM-MX8M-PLUS
> BT_EN_GPIO_SOM="gpiochip1 9"
>
> # WIFI MMC host
> WIFI_MMC_HOST=30b40000.mmc
> WIFI_MMC_PATH="/sys/bus/platform/drivers/sdhci-esdhc-imx"
>
> # Get the SOM revision
> get_somrev() {
>     # Get the raw output
>     raw_output=$(i2cget -f -y 0x0 0x52 0x1e)
>
>     # Convert the output to decimal
>     decimal_output=$(( $raw_output ))
>
>     # Extract major and minor versions
>     major=$(( ($decimal_output & 0xE0) >> 5 ))
>     minor=$(( $decimal_output & 0x1F ))
>
>     # Adjust the major version as per the specification
>     major=$(( $major + 1 ))
>
>     echo "$major.$minor"
> }
>
> # Check if wifi is bcm43xx
> wifi_is_bcm43xx() {
>     somrev=$(get_somrev)
>
>     if [ "$(echo "$somrev < 2.0" | bc)" -eq 1 ]; then
>         return 0
>     else
>         return 1
>     fi
> }
>
> # Return true if SOM is VAR-SOM-MX8M-PLUS
> som_is_var_som_mx8m_plus()
> {
>     grep -q VAR-SOM-MX8M-PLUS /sys/devices/soc0/machine
> }
>
> # Configure VAR-SOM-MX8M-PLUS WIFI/BT pins
> config_pins()
> {
>     if som_is_var_som_mx8m_plus; then
>         WIFI_PWR_GPIO=${WIFI_PWR_GPIO_SOM}
>         WIFI_EN_GPIO=${WIFI_EN_GPIO_SOM}
>         BT_BUF_GPIO=${BT_BUF_GPIO_SOM}
>         BT_EN_GPIO=${BT_EN_GPIO_SOM}
>     else
>         WIFI_PWR_GPIO=${WIFI_PWR_GPIO_DART}
>         WIFI_EN_GPIO=${WIFI_EN_GPIO_DART}
>         BT_BUF_GPIO=${BT_BUF_GPIO_DART}
>         BT_EN_GPIO=${BT_EN_GPIO_DART}
>     fi
> }
>
> # Power up WIFI chip
> wifi_up()
> {
>     # Unbind WIFI device from MMC controller
>     wifi_mmc_unbind ${WIFI_MMC_PATH} ${WIFI_MMC_HOST}
>
>     # WIFI_PWR up
>     gpioset ${WIFI_PWR_GPIO}=1
>     usleep 10000
>
>     # WLAN_EN up
>     gpioset ${WIFI_EN_GPIO}=1
>
>     # BT_EN up
>     gpioset ${BT_EN_GPIO}=1
>
>     # BT_BUF up
>     gpioset ${BT_BUF_GPIO}=0
>
>     # Wait at least 150ms
>     usleep 200000
>
>     # BT_BUF down
>     gpioset ${BT_BUF_GPIO}=1
>
>     # BT_EN down
>     gpioset ${BT_EN_GPIO}=0
>
>     # Bind WIFI device to MMC controller
>     wifi_mmc_bind ${WIFI_MMC_PATH} ${WIFI_MMC_HOST}
>
>     # Load WIFI driver
>     modprobe brcmfmac
> }
>
> # Power down WIFI chip
> wifi_down()
> {
>     # Unload WIFI driver
>     modprobe -r brcmfmac
>
>     # Unbind WIFI device from MMC controller
>     wifi_mmc_unbind ${WIFI_MMC_PATH} ${WIFI_MMC_HOST}
>
>     # Configure WIFI/BT pins
>     config_pins
>
>     # WIFI_EN down
>     gpioset ${WIFI_EN_GPIO}=0
>
>     # BT_BUF down
>     gpioset ${BT_BUF_GPIO}=1
>
>     # BT_EN down
>     gpioset ${BT_EN_GPIO}=0
>     usleep 10000
>
>     # WIFI_PWR down
>     gpioset ${WIFI_PWR_GPIO}=0
> }
>
> # Return true if SOM has WIFI module assembled
> wifi_is_available()
> {
>     # Read SOM options EEPROM field
>     opt=$(i2cget -f -y 0x0 0x52 0x20)
>
>     # Check WIFI bit in SOM options
>     if [ $((opt & 0x1)) -eq 1 ]; then
>         return 0
>     else
>         return 1
>     fi
> }
>
> # Return true if WIFI should be started
> wifi_should_not_be_started()
> {
>     if ! wifi_is_bcm43xx; then
>         return 0
>     fi
>
>     # Do not start WIFI if it is not available
>     if ! wifi_is_available; then
>         return 0
>     fi
>
>     # Do not start WIFI if it is already started
>     [ -d /sys/class/net/wlan0 ] && return 0
>
>     return 1
> }
>
> # Return true if WIFI should not be stopped
> wifi_should_not_be_stopped()
> {
>     if ! wifi_is_bcm43xx; then
>         return 0
>     fi
>
>     # Do not stop WIFI if it is not available
>     if ! wifi_is_available; then
>         return 0
>     fi
>
>     return 1
> }
>
> # Start WIFI hardware
> wifi_start()
> {
>     # Exit if WIFI should not be started
>     wifi_should_not_be_started && exit 0
>
>     # Configure WIFI/BT pins
>     config_pins
>
>     # Try starting WIFI hardware
>     for i in $(seq 1 3); do
>         # Up WIFI
>         wifi_up
>
>         # Exit if WIFI interface exists
>         wifi_interface_exists "wlan0" && exit 0
>
>         # Down WIFI
>         wifi_down
>
>         # Wait enough time for discharge
>         sleep 5
>     done
>
>     exit 1
> }
>
> # Stop WIFI hardware
> wifi_stop()
> {
>     # Exit if WIFI should not be stopped
>     wifi_should_not_be_stopped && exit 0
>
>     # Down WIFI
>     wifi_down
> }
>
> ###########################
> #  Execution starts here  #
> ###########################
> case $1 in
> start)
>     wifi_start
>     ;;
> stop)
>     wifi_stop
>     ;;
> esac
>
> exit 0
>
> ##### networkctl status
>
> tavla@tavla:~$ networkctl
> IDX LINK  TYPE     OPERATIONAL SETUP
>   1 lo    loopback carrier     unmanaged
>   2 eth0  ether    routable    configured
>   3 wlan0 wlan     routable    unmanaged
>
> 3 links listed.
> tavla@tavla:~$ networkctl status
> ●        State: routable
>   Online state: unknown
>        Address: 192.168.178.149 on eth0
>                 192.168.178.113 on wlan0
>                 2a0a:a549:a304:0:fadc:7aff:fe67:2e4 on eth0
>                 fe80::fadc:7aff:fe67:2e4 on eth0
>                 fe80::c2ee:40ff:fe8a:dd62 on wlan0
>        Gateway: 192.168.178.1 on wlan0
>                 192.168.178.1 on eth0
>                 fe80::3a10:d5ff:fe37:2c79 on eth0
>            DNS: 192.168.178.1
>            NTP: 192.168.178.1
>
> ##### IWD status
>
> tavla@tavla:~$ iwctl device list
> Devices
> -------------------------------------------------------------------------------- 
>
>   Name                  Address               Powered Adapter Mode
> -------------------------------------------------------------------------------- 
>
>   wlan0                 c0:ee:40:8a:dd:62     on phy0 station
>
> tavla@tavla:~$ iwctl device wlan0 show
>                                  Device: wlan0
> -------------------------------------------------------------------------------- 
>
>   Settable  Property Value
> -------------------------------------------------------------------------------- 
>
>             Name wlan0
>          *  Mode station
>          *  Powered on
>             Address c0:ee:40:8a:dd:62
>             Adapter phy0
>
> tavla@tavla:~$ iwctl station wlan0 show
>                                  Station: wlan0
> -------------------------------------------------------------------------------- 
>
>   Settable  Property Value
> -------------------------------------------------------------------------------- 
>
>             Scanning no
>             State connected
>             Connected network TAVLA
>             IPv4 address 192.168.178.113
>             ConnectedBss 38:10:d5:37:2c:7c
>             Frequency 5260
>             Security WPA2-Personal
>             RSSI                  -33 dBm
>             TxBitrate             433300 Kbit/s
>             RxBitrate             6000 Kbit/s
>
> ##### brcmfmac log
>
> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_fw_alloc_request: using 
> brcm/brcmfmac4339-sdio for chip BCM4339/2
> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
> load for brcm/brcmfmac4339-sdio.variscite,imx8mp-var-dart.bin failed 
> with error -2
> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
> load for brcm/brcmfmac4339-sdio.clm_blob failed with error -2
> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_c_process_clm_blob: no 
> clm_blob available (err=-2), device may have limited channels available
> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_c_preinit_dcmds: 
> Firmware: BCM4339/2 wl0: Aug  4 2023 08:42:14 version 6.37.39.141 
> (73212ff CY)
> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_cfg80211_attach: Using 
> regulatory domain US
>
> ##### IWD log
>
> Okt 10 09:38:16 tavla systemd[1]: Mounting var-lib-iwd.mount - 
> /var/lib/iwd...
> Okt 10 09:38:16 tavla systemd[1]: Mounted var-lib-iwd.mount - 
> /var/lib/iwd.
> Okt 10 09:38:18 tavla systemd[1]: Starting iwd.service - Wireless 
> service...
> Okt 10 09:38:18 tavla iwd[386]: No Diffie-Hellman support found, WPS 
> will not be available
> Okt 10 09:38:18 tavla iwd[386]: The following options are missing in 
> the kernel:
> Okt 10 09:38:18 tavla iwd[386]:         CONFIG_KEY_DH_OPERATIONS
> Okt 10 09:38:18 tavla iwd[386]: Wireless daemon version 2.3
> Okt 10 09:38:18 tavla iwd[386]: Loaded configuration from 
> /etc/iwd/main.conf
> Okt 10 09:38:18 tavla systemd[1]: Started iwd.service - Wireless service.
> Okt 10 09:38:19 tavla iwd[386]: Wiphy: 0, Name: phy0
> Okt 10 09:38:19 tavla iwd[386]:         Permanent Address: 
> c0:ee:40:8a:dd:62
> Okt 10 09:38:19 tavla iwd[386]:         2.4Ghz Band:
> Okt 10 09:38:19 tavla iwd[386]:                 Bitrates (non-HT):
> Okt 10 09:38:19 tavla iwd[386]:                          1.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                          2.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                          5.5 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         11.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                          6.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                          9.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         12.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         18.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         24.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         36.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         48.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         54.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:         5Ghz Band:
> Okt 10 09:38:19 tavla iwd[386]:                 Bitrates (non-HT):
> Okt 10 09:38:19 tavla iwd[386]:                          6.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                          9.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         12.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         18.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         24.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         36.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         48.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:                         54.0 Mbps
> Okt 10 09:38:19 tavla iwd[386]:         Ciphers: BIP-CMAC-128 CCMP-128 
> TKIP
> Okt 10 09:38:19 tavla iwd[386]:         Supported iftypes: ad-hoc 
> station ap p2p-client p2p-go p2p-device
> Okt 10 09:38:19 tavla iwd[386]: Wiphy phy0 will only use the default 
> interface
> Okt 10 09:38:19 tavla iwd[386]: No default interface for wiphy 0
> Okt 10 09:38:19 tavla iwd[386]: Could not register frame watch type 
> 00b0: -22
> Okt 10 09:38:20 tavla iwd[386]: hardware_rekey not supported
> Okt 10 09:38:20 tavla iwd[386]: [DHCPv4] l_dhcp_client_start:1219 
> Entering state: DHCP_STATE_SELECTING
> Okt 10 09:38:20 tavla iwd[386]: [DHCPv4] dhcp_client_handle_offer:811 
> Entering state: DHCP_STATE_REQUESTING
> Okt 10 09:38:20 tavla iwd[386]: [DHCPv4] dhcp_client_rx_message:915 
> Entering state: DHCP_STATE_BOUND
> Okt 10 09:38:20 tavla iwd[386]: [DHCPv4] dhcp_client_rx_message:948 T1 
> expiring in 431999064 ms
>
> ##### systemd-networkd log
>
> Okt 10 09:38:14 tavla systemd[1]: Listening on systemd-networkd.socket 
> - Network Service Netlink Socket.
> Okt 10 09:38:15 tavla systemd[1]: Starting systemd-networkd.service - 
> Network Configuration...
> Okt 10 09:38:15 tavla systemd-networkd[255]: lo: Link UP
> Okt 10 09:38:15 tavla systemd-networkd[255]: lo: Gained carrier
> Okt 10 09:38:15 tavla systemd-networkd[255]: Enumeration completed
> Okt 10 09:38:15 tavla systemd-networkd[255]: eth0: found matching 
> network '/etc/systemd/network/10-eth0.network', based on potentially 
> unpredictable interface name.
> Okt 10 09:38:15 tavla systemd-networkd[255]: eth0: Configuring with 
> /etc/systemd/network/10-eth0.network.
> Okt 10 09:38:15 tavla systemd[1]: Started systemd-networkd.service - 
> Network Configuration.
> Okt 10 09:38:15 tavla systemd-networkd[255]: eth0: Link UP
> Okt 10 09:38:19 tavla systemd-networkd[255]: wlan0: Link UP
> Okt 10 09:38:20 tavla systemd-networkd[255]: wlan0: Connected WiFi 
> access point: TAVLA (38:10:d5:37:2c:7c)
> Okt 10 09:38:20 tavla systemd-networkd[255]: wlan0: Gained carrier
> Okt 10 09:38:21 tavla systemd-networkd[255]: eth0: Gained carrier
> Okt 10 09:38:21 tavla systemd-networkd[255]: eth0: found matching 
> network '/etc/systemd/network/10-eth0.network', based on potentially 
> unpredictable interface name.
> Okt 10 09:38:21 tavla systemd-networkd[255]: eth0: DHCPv4 address 
> 192.168.178.149/24, gateway 192.168.178.1 acquired from 192.168.178.1
> Okt 10 09:38:22 tavla systemd-networkd[255]: wlan0: Gained IPv6LL
> Okt 10 09:38:22 tavla systemd-networkd[255]: eth0: Gained IPv6LL
>
> ##### systemd-resolved log
>
> Okt 10 09:38:16 tavla systemd[1]: Starting systemd-resolved.service - 
> Network Name Resolution...
> Okt 10 09:38:16 tavla systemd-resolved[312]: Positive Trust Anchors:
> Okt 10 09:38:16 tavla systemd-resolved[312]: . IN DS 20326 8 2 
> e06d44b80b8f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d
> Okt 10 09:38:16 tavla systemd-resolved[312]: Negative trust anchors: 
> home.arpa 10.in-addr.arpa 16.172.in-addr.arpa 17.172.in-addr.arpa 
> 18.172.in-addr.arpa 19.172.in-addr.arpa 20.172.in-addr.arpa 
> 21.172.in-addr.arpa 22.172.in-addr.arpa 23.172.in-addr.arpa 
> 24.172.in-addr.arpa 25.172.in-addr.arpa 26.172.in-addr.arpa 
> 27.172.in-addr.arpa 28.172.in-addr.arpa 29.172.in-addr.arpa 
> 30.172.in-addr.arpa 31.172.in-addr.arpa 170.0.0.192.in-addr.arpa 
> 171.0.0.192.in-addr.arpa 168.192.in-addr.arpa d.f.ip6.arpa 
> ipv4only.arpa corp home internal intranet lan local private test
> Okt 10 09:38:18 tavla systemd-resolved[312]: Using system hostname 
> 'tavla'.
> Okt 10 09:38:18 tavla systemd[1]: Started systemd-resolved.service - 
> Network Name Resolution.
> Okt 10 09:38:20 tavla systemd-resolved[312]: wlan0: Bus client set DNS 
> server list to: 192.168.178.1
> Okt 10 09:38:20 tavla systemd-resolved[312]: wlan0: Bus client set 
> search domain list to: fritz.box
> Okt 10 09:38:20 tavla systemd-resolved[312]: Detected conflict on 
> tavla IN A 192.168.178.113
> Okt 10 09:38:20 tavla systemd-resolved[312]: Hostname conflict, 
> changing published hostname from 'tavla' to 'tavla11'.
> Okt 10 09:38:21 tavla systemd-resolved[312]: Clock change detected. 
> Flushing caches.
> Okt 10 09:38:21 tavla systemd-resolved[312]: Detected conflict on 
> tavla11 IN A 192.168.178.113
> Okt 10 09:38:21 tavla systemd-resolved[312]: Hostname conflict, 
> changing published hostname from 'tavla11' to 'tavla18'.
> Okt 10 09:38:45 tavla systemd-resolved[312]: Using degraded feature 
> set UDP instead of UDP+EDNS0 for DNS server 192.168.178.1.
> Okt 10 09:41:28 tavla sudo[1307]:    tavla : TTY=pts/0 ; 
> PWD=/home/tavla ; USER=root ; COMMAND=/usr/bin/systemctl status 
> systemd-resolved
>
>
>
-- 
Martin Petzold (Inhaber & Geschäftsführer)

TAVLA Technology GmbH
Im Dau 14
50678 Köln
Deutschland

Telefon: +49 (0)221 / 3466 0885
Mobil: +49 (0)179 / 9220154
E-Mail: martin.petzold@tavla.de

