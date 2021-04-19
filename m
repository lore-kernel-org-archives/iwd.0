Content-Type: multipart/mixed; boundary="===============6257588513198657938=="
MIME-Version: 1.0
From: Philip Stewart <philip.stewart.public@gmail.com>
Subject: Re: DEL_INTERFACE and CMD_SET_CQM failed; Could not register frame
 watch type 00d0: -95
Date: Mon, 19 Apr 2021 20:58:26 +0100
Message-ID: <E5UTRQ.7JRIEQZ6Y0YG3@gmail.com>
In-Reply-To: <05cfb41c9aa2ef96b57cf70b063bbaba1a20786e.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6257588513198657938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks James, seems it supports no extended features and only a few =

commands:

# iw list
Wiphy phy0
	wiphy index: 0
	max # scan SSIDs: 1
	max scan IEs length: 0 bytes
	max # sched scan SSIDs: 0
	max # match sets: 0
	Retry short limit: 7
	Retry long limit: 4
	Coverage class: 0 (up to 0m)
	Supported Ciphers:
		* WEP40 (00-0f-ac:1)
		* WEP104 (00-0f-ac:5)
		* TKIP (00-0f-ac:2)
		* CCMP-128 (00-0f-ac:4)
		* CMAC (00-0f-ac:6)
	Available Antennas: TX 0 RX 0
	Supported interface modes:
		 * IBSS
		 * managed
	Band 1:
		Bitrates (non-HT):
			* 1.0 Mbps
			* 2.0 Mbps (short preamble supported)
			* 5.5 Mbps (short preamble supported)
			* 11.0 Mbps (short preamble supported)
			* 6.0 Mbps
			* 9.0 Mbps
			* 12.0 Mbps
			* 18.0 Mbps
			* 24.0 Mbps
			* 36.0 Mbps
			* 48.0 Mbps
			* 54.0 Mbps
		Frequencies:
			* 2412 MHz [1] (20.0 dBm)
			* 2417 MHz [2] (20.0 dBm)
			* 2422 MHz [3] (20.0 dBm)
			* 2427 MHz [4] (20.0 dBm)
			* 2432 MHz [5] (20.0 dBm)
			* 2437 MHz [6] (20.0 dBm)
			* 2442 MHz [7] (20.0 dBm)
			* 2447 MHz [8] (20.0 dBm)
			* 2452 MHz [9] (20.0 dBm)
			* 2457 MHz [10] (20.0 dBm)
			* 2462 MHz [11] (20.0 dBm)
			* 2467 MHz [12] (20.0 dBm)
			* 2472 MHz [13] (20.0 dBm)
			* 2484 MHz [14] (disabled)
	Band 2:
		Bitrates (non-HT):
			* 6.0 Mbps
			* 9.0 Mbps
			* 12.0 Mbps
			* 18.0 Mbps
			* 24.0 Mbps
			* 36.0 Mbps
			* 48.0 Mbps
			* 54.0 Mbps
		Frequencies:
			* 5160 MHz [32] (23.0 dBm)
			* 5170 MHz [34] (23.0 dBm)
			* 5180 MHz [36] (23.0 dBm)
			* 5190 MHz [38] (23.0 dBm)
			* 5200 MHz [40] (23.0 dBm)
			* 5210 MHz [42] (23.0 dBm)
			* 5220 MHz [44] (23.0 dBm)
			* 5230 MHz [46] (23.0 dBm)
			* 5240 MHz [48] (23.0 dBm)
			* 5250 MHz [50] (20.0 dBm) (radar detection)
			* 5260 MHz [52] (20.0 dBm) (radar detection)
			* 5270 MHz [54] (20.0 dBm) (radar detection)
			* 5280 MHz [56] (20.0 dBm) (radar detection)
			* 5290 MHz [58] (20.0 dBm) (radar detection)
			* 5300 MHz [60] (20.0 dBm) (radar detection)
			* 5310 MHz [62] (20.0 dBm) (radar detection)
			* 5320 MHz [64] (20.0 dBm) (radar detection)
			* 5330 MHz [66] (20.0 dBm) (radar detection)
			* 5340 MHz [68] (20.0 dBm) (radar detection)
			* 5350 MHz [70] (disabled)
			* 5360 MHz [72] (disabled)
			* 5370 MHz [74] (disabled)
			* 5380 MHz [76] (disabled)
			* 5390 MHz [78] (disabled)
			* 5400 MHz [80] (disabled)
			* 5410 MHz [82] (disabled)
			* 5420 MHz [84] (disabled)
			* 5430 MHz [86] (disabled)
			* 5440 MHz [88] (disabled)
			* 5450 MHz [90] (disabled)
			* 5460 MHz [92] (disabled)
			* 5470 MHz [94] (disabled)
			* 5480 MHz [96] (26.0 dBm) (radar detection)
			* 5490 MHz [98] (26.0 dBm) (radar detection)
			* 5500 MHz [100] (26.0 dBm) (radar detection)
			* 5510 MHz [102] (26.0 dBm) (radar detection)
			* 5520 MHz [104] (26.0 dBm) (radar detection)
			* 5530 MHz [106] (26.0 dBm) (radar detection)
			* 5540 MHz [108] (26.0 dBm) (radar detection)
			* 5550 MHz [110] (26.0 dBm) (radar detection)
			* 5560 MHz [112] (26.0 dBm) (radar detection)
			* 5570 MHz [114] (26.0 dBm) (radar detection)
			* 5580 MHz [116] (26.0 dBm) (radar detection)
			* 5590 MHz [118] (26.0 dBm) (radar detection)
			* 5600 MHz [120] (26.0 dBm) (radar detection)
			* 5610 MHz [122] (26.0 dBm) (radar detection)
			* 5620 MHz [124] (26.0 dBm) (radar detection)
			* 5630 MHz [126] (26.0 dBm) (radar detection)
			* 5640 MHz [128] (26.0 dBm) (radar detection)
			* 5650 MHz [130] (26.0 dBm) (radar detection)
			* 5660 MHz [132] (26.0 dBm) (radar detection)
			* 5670 MHz [134] (26.0 dBm) (radar detection)
			* 5680 MHz [136] (26.0 dBm) (radar detection)
			* 5690 MHz [138] (26.0 dBm) (radar detection)
			* 5700 MHz [140] (26.0 dBm) (radar detection)
			* 5710 MHz [142] (26.0 dBm) (radar detection)
			* 5720 MHz [144] (13.0 dBm) (radar detection)
			* 5725 MHz [145] (13.0 dBm) (radar detection)
			* 5730 MHz [146] (13.0 dBm) (radar detection)
			* 5735 MHz [147] (13.0 dBm)
			* 5740 MHz [148] (13.0 dBm)
			* 5745 MHz [149] (13.0 dBm)
			* 5750 MHz [150] (13.0 dBm)
			* 5755 MHz [151] (13.0 dBm)
			* 5760 MHz [152] (13.0 dBm)
			* 5765 MHz [153] (13.0 dBm)
			* 5770 MHz [154] (13.0 dBm)
			* 5775 MHz [155] (13.0 dBm)
			* 5780 MHz [156] (13.0 dBm)
			* 5785 MHz [157] (13.0 dBm)
			* 5790 MHz [158] (13.0 dBm)
			* 5795 MHz [159] (13.0 dBm)
			* 5800 MHz [160] (13.0 dBm)
			* 5805 MHz [161] (13.0 dBm)
			* 5810 MHz [162] (13.0 dBm)
			* 5815 MHz [163] (13.0 dBm)
			* 5820 MHz [164] (13.0 dBm)
			* 5825 MHz [165] (13.0 dBm)
			* 5830 MHz [166] (13.0 dBm)
			* 5840 MHz [168] (13.0 dBm)
			* 5850 MHz [170] (13.0 dBm)
			* 5860 MHz [172] (13.0 dBm)
			* 5870 MHz [174] (disabled)
			* 5880 MHz [176] (disabled)
			* 5890 MHz [178] (disabled)
			* 5900 MHz [180] (disabled)
			* 5910 MHz [182] (disabled)
			* 5920 MHz [184] (disabled)
			* 5930 MHz [186] (disabled)
			* 5940 MHz [188] (disabled)
			* 5950 MHz [0] (disabled)
			* 5960 MHz [2] (disabled)
			* 5970 MHz [4] (disabled)
			* 5980 MHz [6] (disabled)
			* 5990 MHz [8] (disabled)
			* 6000 MHz [10] (disabled)
			* 6010 MHz [12] (disabled)
			* 6020 MHz [14] (disabled)
			* 6030 MHz [16] (disabled)
			* 6040 MHz [18] (disabled)
			* 6050 MHz [20] (disabled)
			* 6060 MHz [22] (disabled)
			* 6070 MHz [24] (disabled)
			* 6080 MHz [26] (disabled)
			* 6090 MHz [28] (disabled)
			* 6100 MHz [30] (disabled)
			* 6110 MHz [32] (disabled)
			* 6120 MHz [34] (disabled)
			* 6130 MHz [36] (disabled)
			* 6140 MHz [38] (disabled)
	Supported commands:
		 * set_interface
		 * new_key
		 * join_ibss
		 * set_pmksa
		 * del_pmksa
		 * flush_pmksa
		 * connect
		 * disconnect
	software interface modes (can always be added):
	interface combinations are not supported
	Device supports scan flush.
	max # scan plans: 1
	max scan plan interval: -1
	max scan plan iterations: 0
	Supported extended features:

Given it appears to be performing well, I can live with it :)

All the best,
Phil

On Mon, 19 Apr, 2021 at 12:06, James Prestwood <prestwoj@gmail.com> =

wrote:
> Hi Philip,
> =

> On Mon, 2021-04-19 at 19:16 +0100, Philip Stewart wrote:
>>  Hi James,
>> =

>>  Thanks for the clarification around DEL_INTERFACE/CQM, that's
>>  reassuring and makes sense!
>> =

>>  On the MAC address, yes - /sys/class/ieee80211/phy0/macaddress
>>  reports
>>  all zeros. Would you expect the wl driver to set this?
> =

> I would expect that yeah. My only guess is that broadcom-wl is a
> fullmac driver that doesn't set this and handles everything in the
> firmware. You could see what extended features and commands it
> advertises with 'iw list' to verify.
> =

>> =

>>  n.b. I note that '[iwd]# station wlan0 show' and '# iw wlan0 link'
>>  both
>>  successfully report the MAC address for the access point.
>> =

>>  Cheers,
>>  Phil
>> =

>>  On Mon, 19 Apr, 2021 at 09:07, James Prestwood <prestwoj@gmail.com>
>>  wrote:
>>  > Hi Philip,
>>  >
>>  > On Sun, 2021-04-18 at 18:21 +0100, Philip Stewart wrote:
>>  > >  Hello,
>>  > >
>>  > >  I've recently switched from NetworkManager and wpasupplicant to
>>  > >  systemd-networkd and iwd. Whilst everything appears to be
>>  > > working
>>  > >  fine,
>>  > >  I'm curious about some failures reported by iwd:
>>  > >
>>  > >  Apr 18 15:10:32 systemd[1]: Starting Wireless service...
>>  > >  Apr 18 15:10:33 iwd[661]: Wireless daemon version 1.12
>>  > >  Apr 18 15:10:33 systemd[1]: Started Wireless service.
>>  > >  Apr 18 15:10:33 iwd[661]: station: Network configuration is
>>  > > disabled.
>>  > >  Apr 18 15:10:33 iwd[661]: Wiphy: 0, Name: phy0
>>  > >  Apr 18 15:10:33 iwd[661]:         Permanent Address:
>>  > >  00:00:00:00:00:00
>>  > >  Apr 18 15:10:33 iwd[661]:         Bands: 2.4 GHz 5 GHz
>>  > >  Apr 18 15:10:33 iwd[661]:         Ciphers: CCMP TKIP BIP
>>  > >  Apr 18 15:10:33 iwd[661]:         Supported iftypes: ad-hoc
>>  > > station
>>  > >  Apr 18 15:10:33 iwd[661]: DEL_INTERFACE failed: Operation not
>>  > >  supported
>>  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch type
>>  > > 00d0:
>>  > >  -95
>>  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch type
>>  > > 00d0:
>>  > >  -95
>>  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch type
>>  > > 00d0:
>>  > >  -95
>>  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch type
>>  > > 00d0:
>>  > >  -95
>>  > >  Apr 18 15:10:33 iwd[661]: CMD_SET_CQM failed: Operation not
>>  > > supported
>>  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch type
>>  > > 00d0:
>>  > >  -95
>>  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch type
>>  > > 00d0:
>>  > >  -95
>>  > >
>>  > >  Further, I note that in the output of 'networkctl status =

>> wlan0',
>>  > > the
>>  > >  WiFi access point MAC address is reported as 00:00:00:00:00:00
>>  > > and
>>  > >  I'm
>>  > >  wondering if this is a consequence of these failures and if
>>  > > there is
>>  > >  anything I can do about it?
>>  >
>>  > I'm not familiar with the wl driver specifically but I'm guessing
>>  > it
>>  > does not support DEL_INTERFACE/CQM.
>>  >
>>  > This is fine though. In the DEL_INTERFACE case IWD will just use
>>  > the
>>  > interface that already exists on the system. Effectively
>>  > [General].UseDefaultInterface=3Dtrue.
>>  >
>>  > CQM is also ok as the driver (presumably) manages low RSSI itself
>>  > and
>>  > will roam on its own. At least this is what I would expect.
>>  >
>>  > We pull the permanent address from
>>  > /sys/class/ieee80211/<phy>/macaddress. Is that reporting zero's?
>>  >
>>  > Thanks,
>>  > James
>>  >
>>  > >  Kind regards,
>>  > >  Phil
>>  > >
>>  > >  # lspci -vv -d 14e4:
>>  > >  03:00.0 Network controller: Broadcom Inc. and subsidiaries
>>  > > BCM4322
>>  > >  802.11a/b/g/n Wireless LAN Controller (rev 01)
>>  > >  	Subsystem: Apple Inc. AirPort Extreme
>>  > >  	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>  > >  ParErr-
>>  > >  Stepping- SERR- FastB2B- DisINTx-
>>  > >  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>>  > >  <TAbort- <MAbort- >SERR- <PERR- INTx-
>>  > >  	Latency: 0, Cache Line Size: 256 bytes
>>  > >  	Interrupt: pin A routed to IRQ 20
>>  > >  	Region 0: Memory at d3200000 (64-bit, non-prefetchable)
>>  > >  [size=3D16K]
>>  > >  	Capabilities: [40] Power Management version 3
>>  > >  		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>>  > >  PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>  > >  		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 PME-
>>  > >  	Capabilities: [58] Vendor Specific Information: Len=3D78 <?>
>>  > >  	Capabilities: [e8] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>>  > >  		Address: 0000000000000000  Data: 0000
>>  > >  	Capabilities: [d0] Express (v1) Endpoint, MSI 00
>>  > >  		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
>>  > > Latency
>>  > >  L0s <4us, L1
>>  > >  unlimited
>>  > >  			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>  > >  SlotPowerLimit 0.000W
>>  > >  		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>  > >  			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>>  > >  			MaxPayload 128 bytes, MaxReadReq 128 bytes
>>  > >  		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>  > >  AuxPwr- TransPend-
>>  > >  		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM
>>  > > L0s
>>  > >  L1, Exit Latency
>>  > >  L0s <4us, L1 <64us
>>  > >  			ClockPM+ Surprise- LLActRep- BwNot-
>>  > >  ASPMOptComp-
>>  > >  		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes,
>>  > > Disabled-
>>  > >  CommClk+
>>  > >  			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>  > >  		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
>>  > >  			TrErr- Train- SlotClk+ DLActive- BWMgmt-
>>  > >  ABWMgmt-
>>  > >  	Capabilities: [100 v1] Advanced Error Reporting
>>  > >  		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>  > >  UnxCmplt- RxOF-
>>  > >  MalfTLP- ECRC- UnsupReq- ACSViol-
>>  > >  		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>  > >  UnxCmplt- RxOF-
>>  > >  MalfTLP- ECRC- UnsupReq- ACSViol-
>>  > >  		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
>>  > >  UnxCmplt- RxOF+
>>  > >  MalfTLP+ ECRC- UnsupReq- ACSViol-
>>  > >  		CESta:	RxErr- BadTLP- BadDLLP- Rollover-
>>  > > Timeout-
>>  > >  AdvNonFatalErr-
>>  > >  		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
>>  > > Timeout-
>>  > >  AdvNonFatalErr+
>>  > >  		AERCap:	First Error Pointer: 00, ECRCGenCap+
>>  > >  ECRCGenEn- ECRCChkCap+
>>  > >  ECRCChkEn-
>>  > >  			MultHdrRecCap- MultHdrRecEn- TLPPfxPres-
>>  > >  HdrLogCap-
>>  > >  		HeaderLog: 00000000 00000000 00000000 00000000
>>  > >  	Capabilities: [13c v1] Virtual Channel
>>  > >  		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>>  > >  		Arb:	Fixed- WRR32- WRR64- WRR128-
>>  > >  		Ctrl:	ArbSelect=3DFixed
>>  > >  		Status:	InProgress-
>>  > >  		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1
>>  > >  RejSnoopTrans-
>>  > >  			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128-
>>  > >  WRR256-
>>  > >  			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
>>  > >  			Status:	NegoPending- InProgress-
>>  > >  	Capabilities: [160 v1] Device Serial Number xx-xx-xx-xx-xx-xx-
>>  > >  xx-xx
>>  > >  	Capabilities: [16c v1] Power Budgeting <?>
>>  > >  	Kernel driver in use: wl
>>  > >  	Kernel modules: ssb, wl
>>  > >
>>  > >
>>  > >  _______________________________________________
>>  > >  iwd mailing list -- iwd(a)lists.01.org
>>  > >  To unsubscribe send an email to iwd-leave(a)lists.01.org
>> =

>> =

> =



--===============6257588513198657938==--

