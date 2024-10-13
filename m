Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755413A868
	for <iwd@lists.linux.dev>; Sun, 13 Oct 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834199; cv=none; b=hVBD44eQWLgGH0q3N4/bn9ba1V2siskGql9Ni78uESVAXju8GvoTMaXvQRntf4Coc+eKrWdOswB9B2Opyduzb4rkLqvufYFonpIH7OvZq4VCa2PwnoYs0D+093gU+BYcKAt4dsNAwDAk3bIIn6PVBtaHGY/ODgV0JcbJg8bmr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834199; c=relaxed/simple;
	bh=KsuQ4JiM1fyVtTwjBGh3E1qbMMFmtCP92PXVw+G3+HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boRYJ3NfVlVt4lJ9rTktZXnR9HH+slG8rDuBa+q18zt9uBsSygPlIqca1FRgpuuMBFBe/1v9li+ovX3i/e55HhfW+pL9l2dJnhIZYRJKKA+sQMVBQ4HjC+V/Dm77hBHuMWAdBssdtBJF8xYy6HH9NINkZCQGpcMZnIKZUGdL4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=thgAWGY2; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="thgAWGY2"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XRPlD6KGsz9tfv;
	Sun, 13 Oct 2024 17:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728834184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeY46G6so968x2wlqlhzeSURArJacRHhixW8a5QRIds=;
	b=thgAWGY2QG5tglU54YFCYrxHOGUaTWG9vXdTWRUijesrrstzMcHo08cU8xDW1RhuAta2YE
	kx5z/rL15I2epFbVpmHNvjqi1qvBUqlqnq0Pw9+5HtYQMYIS6chuMR9m56wa77aRs7lCGp
	INceAk3jAdqBQ5X2qDp8sYQY4i0tLIWHV4903eom7UM5qtVoV4iOg5MYM1LDwYZ1bkjGT/
	RlcSBrzsIT+LuJp03lOlzNMME/n3NTl4Lk4FoGnOLEDmbd4U0RJt8kED7bagw6ZxEzN2rN
	nOLlx3ztu6WWDKws6l+TGJmIL6D1mkO2QSdf5wg7l0xWWwrikUhj/FvxSFKcWg==
Message-ID: <f4ab8298-9011-40cc-9ad9-1df713b3e9d7@tavla.de>
Date: Sun, 13 Oct 2024 17:43:03 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <69cc8b13-e6b4-43c5-8ba3-7877a75f0581@tavla.de>
 <717feddd-8756-4271-8c05-5ef46ff9e8d2@tavla.de>
 <e27b082f-15eb-412e-b1a5-292b17080cc4@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <e27b082f-15eb-412e-b1a5-292b17080cc4@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arend,

Am 12.10.24 um 13:51 schrieb Arend van Spriel:
> On 10/12/2024 1:06 PM, Martin Petzold wrote:
>> Hi Arend,
>>
>> Am 10.10.24 um 10:06 schrieb Martin Petzold:
>>> Hi Arend,
>>>
>>> Am 09.10.24 um 18:50 schrieb Arend Van Spriel:
>>>
>>> I was able to migrate to NXP kernel 6.1.36 with Debian bookworm 
>>> rootfs containing IWD 2.3. I will try also to build IWD 2.22 later. 
>>> If this setup / configuration makes sense I would go to roaming 
>>> environments again. However, I have the following questions and 
>>> please find the configuration and logs below:
>>>
>>> 1. Why does brcmfmac report "Using regulatory domain US" even though 
>>> I have set "ccode=EU" and "regrev=116" in /lib/firmware/brcm/ 
>>> brcmfmac4339-sdio.txt?
>>
>> I had an entry in the device tree (laird,regdomain = "US"), which 
>> seems to be stronger than the value in the brcmfmac4339-sdio.txt. Can 
>> you confirm?
>>
>> Now I don't get any output like "Using regulatory domain ..." any 
>> more. How can I now be sure that EU (ETSI) is used?
>
> I really have no clue. This is not in the upstream driver so I assume 
> you are also using some Infineon flavor of the brcmfmac driver. That 
> device tree entry is definitely not in the bindings specification.

We are using "community kernel 6.1.36 + minor patches to use latest 
firmware (Laird) and reg domain control from the dts [2]" (I assume 
community kernel refers to NXP kernel, which is derived from mainline) 
[1, 2]. I have now removed the device tree entry and I assume then the 
reg domain should be used from brcmfmac4339-sdio.txt.

[1] 
https://github.com/varigit/linux-imx/commits/lf-6.1.y_var03/drivers/net/wireless/broadcom/brcm80211/brcmfmac
[2] 
https://github.com/varigit/linux-imx/commit/aa055e53527e1321276a44b5105eef2910655da4
>
>>> 2. Is it the best approach to use firmware for Laird LWB5 / CYW43353 
>>> from their Git repository 
>>> (laird-lwb5-etsi-firmware-11.171.0.24.tar.bz2)?
>>
>> Here I switched to newer version 12.29.0.22. I assume this firmware 
>> is the correct one and should work with the Kernel brcmfmac driver 
>> (6.1.36), right?
>
> Sorry. No answer to that. I have no knowledge about distribution 
> packages from Laird.

Okay, so you would recommend to use upstream firmware [3,4] with your 
mainline driver, right? Also for the Laird Sterling-LWB5 (Infineon 
CYW43353)?

SOM vendor tells me: "mainline firmware are not validated by 
Laird, mainline firmware are usually older than those provided by Laird".

How is the regulatory domain configured for Infineon CYW43353 if I use 
YOUR mainline driver and firmware?

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
[4] https://packages.debian.org/bookworm-backports/firmware-brcm80211

>
>>> 3. If you say roaming can be handled by firmware (driver?) OR daemon 
>>> (IWD), what is the best approach and how to configure it?
>>
>> This question is still open for me. In general the question, will 
>> brcmfmac work with the laird firmware and IWD stable (really good) 
>> also for roaming?
>
> In general it is best to let firmware take care of roaming. You can 
> try using the module parameter 'roam_off' and see how well IWD takes 
> care of roaming. I have never used IWD.

IMHO it seems IWD is getting some adoption. For me it seems to be a 
really good alternative together with systemd-networkd. We wanted to 
migrate from NetworkManager to IWD together with 6.1.36 kernel. Of 
course I know IWD is coming from Intel and you are working for Broadcom, 
there could be some political / strategic issues then. However, I think 
it would be quite important to have brcmfmac driver work well and be 
tested with IWD.

>
>>> 4. Is it valid to always use brcm-patchram-plus to load the firmware 
>>> on every boot?
>
> What is brcm-patchram-plus?

It is a tool built by Broadcom to load the firmware to the chip: 
https://github.com/varigit/meta-variscite-bsp-common/blob/mickledore-var02/recipes-connectivity/brcm-patchram-plus/brcm-patchram-plus/brcm_patchram_plus.c

This is what our SOM vendor (Variscite) suggests to do: Blacklist 
"brcmfmac" and then there are scripts to load the firmware (from Laird) 
to the chip and then enable the "brcmfmac" driver module.

Bad idea? Maybe this is some legacy for older kernels or non mainline 
drivers?

Is this actually also handled by your kernel driver? I mean the firmware 
loading if I switch to mainline?

>
>>> 5. I see the following error (more log below). What is going wrong?
>>>
>>> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
>>> load for brcm/brcmfmac4339-sdio.variscite,imx8mp-var-dart.bin failed 
>>> with error -2
>>> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
>>> load for brcm/brcmfmac4339-sdio.clm_blob failed with error -2
>>> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_c_process_clm_blob: no 
>>> clm_blob available (err=-2), device may have limited channels available
>
> Nothing wrong here except that it does not find a clm_blob file.
>
>> What about the "clm_blob". Is it required in file system for 4339? (I 
>> don't want to have limited channels)
>
> What channels are reported if you use the iw utility?

I get the following output, which seems to be wrong (or can't I trust IW):

-----

tavla@tavla:~$ sudo journalctl --boot --no-pager | grep brcm
Okt 13 16:53:35 tavla kernel: brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac4339-sdio for chip BCM4339/2
Okt 13 16:53:35 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware load 
for brcm/brcmfmac4339-sdio.variscite,imx8mp-var-dart.bin failed with 
error -2
Okt 13 16:53:35 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware load 
for brcm/brcmfmac4339-sdio.clm_blob failed with error -2
Okt 13 16:53:36 tavla kernel: brcmfmac: brcmf_c_process_clm_blob: no 
clm_blob available (err=-2), device may have limited channels available
Okt 13 16:53:36 tavla kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: 
BCM4339/2 wl0: Aug  4 2023 08:42:14 version 6.37.39.141 (73212ff CY)
Okt 13 16:53:36 tavla kernel: ieee80211 phy0: 
brcmf_p2p_send_action_frame: Unknown Frame: category 0x5, action 0x4
Okt 13 16:53:54 tavla kernel: ieee80211 phy0: 
brcmf_p2p_send_action_frame: Unknown Frame: category 0x5, action 0x4
tavla@tavla:~$ sudo iw reg get
global
country 00: DFS-UNSET
     (2402 - 2472 @ 40), (6, 20), (N/A)
     (2457 - 2482 @ 20), (6, 20), (N/A), AUTO-BW, PASSIVE-SCAN
     (2474 - 2494 @ 20), (6, 20), (N/A), NO-OFDM, PASSIVE-SCAN
     (5170 - 5250 @ 80), (6, 20), (N/A), AUTO-BW, PASSIVE-SCAN
     (5250 - 5330 @ 80), (6, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
     (5490 - 5730 @ 160), (6, 20), (0 ms), DFS, PASSIVE-SCAN
     (5735 - 5835 @ 80), (6, 20), (N/A), PASSIVE-SCAN
     (57240 - 63720 @ 2160), (N/A, 0), (N/A)

phy#0
country 99: DFS-UNSET
     (2402 - 2482 @ 40), (6, 20), (N/A)
     (2474 - 2494 @ 20), (6, 20), (N/A)
     (5140 - 5360 @ 160), (6, 20), (N/A)
     (5460 - 5860 @ 160), (6, 20), (N/A)

tavla@tavla:~$ cat /lib/firmware/brcm/brcmfmac4339-sdio.txt
# Sample variables file for BCM94339 WLBGA with eTR,iPA, and eLNA. 
Sterling-LWB5 CYW43353
NVRAMRev=$Rev: 410316 $
sromrev=11
boardrev=0x1203
boardtype=0x06c5
boardflags=0x00000c01
boardflags2=0x00002000
boardflags3=0x8101188
macaddr=00:90:4c:c5:12:38
cctl=0
ccode=EU
regrev=116
antswitch=0
pdgain5g=7
pdgain2g=7
tworangetssi2g=0
tworangetssi5g=0
femctrl=7
vendid=0x14e4
devid=0x43ae
manfid=0x2d0
nocrc=1
otpimagesize=502
xtalfreq=37400
extpagain2g=2
pdetrange2g=2
extpagain5g=2
pdetrange5g=2
rxgains2gelnagaina0=0
rxgains2gtrisoa0=7
rxgains2gtrelnabypa0=0
rxgains5gelnagaina0=0
rxgains5gtrisoa0=11
rxgains5gtrelnabypa0=0
rxchain=1
txchain=1
aa2g=1
aa5g=1
tssipos5g=0
tssipos2g=0
pa2ga0=-159,5841,-699
pa2gccka0=-162,6244,-755
pa5ga0=-185,5721,-690,-185,5693,-688,-193,5445,-670,-194,5352,-661
pa5gbw40a0=-188,5836,-710,-187,5839,-708,-173,5956,-714,-159,6022,-712
pa5gbw80a0=-184,5789,-700,-185,5784,-700,-175,5797,-699,-172,5749,-692
pdoffset40ma0=0
pdoffset80ma0=0
pdoffsetcckma0=0
maxp2ga0=0x4A
maxp5ga0=0x4A,0x4A,0x4A,0x4A
cckbw202gpo=0x0000
cckbw20ul2gpo=0x0000
mcsbw202gpo=0x66666666
mcsbw402gpo=0x66666666
dot11agofdmhrbw202gpo=0x4444
ofdmlrbw202gpo=0x4444
tssifloor2g=500
mcsbw205glpo=0x22222222
mcsbw405glpo=0x55555555
mcsbw805glpo=0xaaaaaaaa
mcsbw1605glpo=0xffffffff
mcsbw205gmpo=0x22222222
mcsbw405gmpo=0x55555555
mcsbw805gmpo=0xaaaaaaaa
mcsbw1605gmpo=0xffffffff
mcsbw205ghpo=0x22222222
mcsbw405ghpo=0x55555555
mcsbw805ghpo=0xaaaaaaaa
mcsbw1605ghpo=0xffffffff
mcslr5glpo=0x0000
mcslr5gmpo=0x0000
mcslr5ghpo=0x0000
sb20in40hrpo=0x0
sb20in80and160hr5glpo=0x0
sb40and80hr5glpo=0x0
sb20in80and160hr5gmpo=0x0
sb40and80hr5gmpo=0x0
sb20in80and160hr5ghpo=0x0
sb40and80hr5ghpo=0x0
sb20in40lrpo=0x0
sb20in80and160lr5glpo=0x0
sb40and80lr5glpo=0x0
sb20in80and160lr5gmpo=0x0
sb40and80lr5gmpo=0x0
sb20in80and160lr5ghpo=0x0
sb40and80lr5ghpo=0x0
dot11agduphrpo=0x0
dot11agduplrpo=0x0
phycal_tempdelta=25
cckdigfilttype=2
swctrlmap_5g=0x00000008,0x00000010,0x00000008,0x000000,0x038
swctrlmap_2g=0x00000001,0x00000002,0x00000001,0x040002,0x0ff
swctrlmapext_5g=0x00000000,0x00000000,0x00000000,0x000000,0x000
swctrlmapext_2g=0x00000000,0x00000000,0x00000000,0x000000,0x000
muxenab=0x11
rssicorrnorm_c0=3,3
rssicorrnorm5g_c0=2,3,4,2,3,3,0,1,2,0,1,2
paparambwver=1
AvVmid_c0=2,155,2,146,2,150,2,154,2,152
ed_thresh2g=-70
ed_thresh5g=-73
txidxcap2g=0
txidxcap5g=0

-----

