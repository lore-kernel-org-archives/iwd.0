Content-Type: multipart/mixed; boundary="===============2027288531494193700=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: DEL_INTERFACE and CMD_SET_CQM failed; Could not register frame
 watch type 00d0: -95
Date: Mon, 19 Apr 2021 13:10:10 -0700
Message-ID: <2fe3ffc75401a5ce154b87ecafbd9d9a77c7483b.camel@gmail.com>
In-Reply-To: <E5UTRQ.7JRIEQZ6Y0YG3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2027288531494193700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

<snip>
> 	Supported commands:
> 		 * set_interface
> 		 * new_key
> 		 * join_ibss
> 		 * set_pmksa
> 		 * del_pmksa
> 		 * flush_pmksa
> 		 * connect
> 		 * disconnect

Yes, this appears to be a fullmac card based on the commands it
supports.

> 	software interface modes (can always be added):
> 	interface combinations are not supported
> 	Device supports scan flush.
> 	max # scan plans: 1
> 	max scan plan interval: -1
> 	max scan plan iterations: 0
> 	Supported extended features:

No extended features could be due to an outdated iw version, though my
thought was that is would support handshake offloading which is
somewhat old at this point.

Since its working well for you I wouldn't worry about it, though I am
somewhat curious how exactly the 4-way handshake is working with a zero
MAC. Do you by chance see any eapol messages in your IWD logs (running
in debug mode):

src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D50
src/netdev.c:netdev_mlme_notify() MLME notification Unknown(139)
src/netdev.c:netdev_unicast_notify() Unicast notification 129
src/netdev.c:netdev_control_port_frame_event() =

src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D50

Those "handle_ptk_" calls mean the 4-way is happening in userspace. If
you don't see them then the 4-way is being offloaded to the firmware
which would make the most sense based on your zero MAC.

> =

> Given it appears to be performing well, I can live with it :)
> =

> All the best,
> Phil
> =

> On Mon, 19 Apr, 2021 at 12:06, James Prestwood <prestwoj@gmail.com> =

> wrote:
> > Hi Philip,
> > =

> > On Mon, 2021-04-19 at 19:16 +0100, Philip Stewart wrote:
> > >  Hi James,
> > > =

> > >  Thanks for the clarification around DEL_INTERFACE/CQM, that's
> > >  reassuring and makes sense!
> > > =

> > >  On the MAC address, yes - /sys/class/ieee80211/phy0/macaddress
> > >  reports
> > >  all zeros. Would you expect the wl driver to set this?
> > =

> > I would expect that yeah. My only guess is that broadcom-wl is a
> > fullmac driver that doesn't set this and handles everything in the
> > firmware. You could see what extended features and commands it
> > advertises with 'iw list' to verify.
> > =

> > >  n.b. I note that '[iwd]# station wlan0 show' and '# iw wlan0
> > > link'
> > >  both
> > >  successfully report the MAC address for the access point.
> > > =

> > >  Cheers,
> > >  Phil
> > > =

> > >  On Mon, 19 Apr, 2021 at 09:07, James Prestwood <
> > > prestwoj(a)gmail.com>
> > >  wrote:
> > >  > Hi Philip,
> > >  >
> > >  > On Sun, 2021-04-18 at 18:21 +0100, Philip Stewart wrote:
> > >  > >  Hello,
> > >  > >
> > >  > >  I've recently switched from NetworkManager and
> > > wpasupplicant to
> > >  > >  systemd-networkd and iwd. Whilst everything appears to be
> > >  > > working
> > >  > >  fine,
> > >  > >  I'm curious about some failures reported by iwd:
> > >  > >
> > >  > >  Apr 18 15:10:32 systemd[1]: Starting Wireless service...
> > >  > >  Apr 18 15:10:33 iwd[661]: Wireless daemon version 1.12
> > >  > >  Apr 18 15:10:33 systemd[1]: Started Wireless service.
> > >  > >  Apr 18 15:10:33 iwd[661]: station: Network configuration is
> > >  > > disabled.
> > >  > >  Apr 18 15:10:33 iwd[661]: Wiphy: 0, Name: phy0
> > >  > >  Apr 18 15:10:33 iwd[661]:         Permanent Address:
> > >  > >  00:00:00:00:00:00
> > >  > >  Apr 18 15:10:33 iwd[661]:         Bands: 2.4 GHz 5 GHz
> > >  > >  Apr 18 15:10:33 iwd[661]:         Ciphers: CCMP TKIP BIP
> > >  > >  Apr 18 15:10:33 iwd[661]:         Supported iftypes: ad-hoc
> > >  > > station
> > >  > >  Apr 18 15:10:33 iwd[661]: DEL_INTERFACE failed: Operation
> > > not
> > >  > >  supported
> > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
> > > type
> > >  > > 00d0:
> > >  > >  -95
> > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
> > > type
> > >  > > 00d0:
> > >  > >  -95
> > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
> > > type
> > >  > > 00d0:
> > >  > >  -95
> > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
> > > type
> > >  > > 00d0:
> > >  > >  -95
> > >  > >  Apr 18 15:10:33 iwd[661]: CMD_SET_CQM failed: Operation not
> > >  > > supported
> > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
> > > type
> > >  > > 00d0:
> > >  > >  -95
> > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
> > > type
> > >  > > 00d0:
> > >  > >  -95
> > >  > >
> > >  > >  Further, I note that in the output of 'networkctl status =

> > > wlan0',
> > >  > > the
> > >  > >  WiFi access point MAC address is reported as
> > > 00:00:00:00:00:00
> > >  > > and
> > >  > >  I'm
> > >  > >  wondering if this is a consequence of these failures and if
> > >  > > there is
> > >  > >  anything I can do about it?
> > >  >
> > >  > I'm not familiar with the wl driver specifically but I'm
> > > guessing
> > >  > it
> > >  > does not support DEL_INTERFACE/CQM.
> > >  >
> > >  > This is fine though. In the DEL_INTERFACE case IWD will just
> > > use
> > >  > the
> > >  > interface that already exists on the system. Effectively
> > >  > [General].UseDefaultInterface=3Dtrue.
> > >  >
> > >  > CQM is also ok as the driver (presumably) manages low RSSI
> > > itself
> > >  > and
> > >  > will roam on its own. At least this is what I would expect.
> > >  >
> > >  > We pull the permanent address from
> > >  > /sys/class/ieee80211/<phy>/macaddress. Is that reporting
> > > zero's?
> > >  >
> > >  > Thanks,
> > >  > James
> > >  >
> > >  > >  Kind regards,
> > >  > >  Phil
> > >  > >
> > >  > >  # lspci -vv -d 14e4:
> > >  > >  03:00.0 Network controller: Broadcom Inc. and subsidiaries
> > >  > > BCM4322
> > >  > >  802.11a/b/g/n Wireless LAN Controller (rev 01)
> > >  > >  	Subsystem: Apple Inc. AirPort Extreme
> > >  > >  	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> > > VGASnoop-
> > >  > >  ParErr-
> > >  > >  Stepping- SERR- FastB2B- DisINTx-
> > >  > >  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
> > > >TAbort-
> > >  > >  <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >  > >  	Latency: 0, Cache Line Size: 256 bytes
> > >  > >  	Interrupt: pin A routed to IRQ 20
> > >  > >  	Region 0: Memory at d3200000 (64-bit, non-prefetchable)
> > >  > >  [size=3D16K]
> > >  > >  	Capabilities: [40] Power Management version 3
> > >  > >  		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
> > >  > >  PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >  > >  		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0
> > > DScale=3D2 PME-
> > >  > >  	Capabilities: [58] Vendor Specific Information: Len=3D78
> > > <?>
> > >  > >  	Capabilities: [e8] MSI: Enable- Count=3D1/1 Maskable-
> > > 64bit+
> > >  > >  		Address: 0000000000000000  Data: 0000
> > >  > >  	Capabilities: [d0] Express (v1) Endpoint, MSI 00
> > >  > >  		DevCap:	MaxPayload 128 bytes, PhantFunc
> > > 0,
> > >  > > Latency
> > >  > >  L0s <4us, L1
> > >  > >  unlimited
> > >  > >  			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
> > > FLReset-
> > >  > >  SlotPowerLimit 0.000W
> > >  > >  		DevCtl:	CorrErr- NonFatalErr- FatalErr-
> > > UnsupReq-
> > >  > >  			RlxdOrd- ExtTag+ PhantFunc- AuxPwr-
> > > NoSnoop-
> > >  > >  			MaxPayload 128 bytes, MaxReadReq 128
> > > bytes
> > >  > >  		DevSta:	CorrErr- NonFatalErr- FatalErr-
> > > UnsupReq-
> > >  > >  AuxPwr- TransPend-
> > >  > >  		LnkCap:	Port #0, Speed 2.5GT/s, Width x1,
> > > ASPM
> > >  > > L0s
> > >  > >  L1, Exit Latency
> > >  > >  L0s <4us, L1 <64us
> > >  > >  			ClockPM+ Surprise- LLActRep- BwNot-
> > >  > >  ASPMOptComp-
> > >  > >  		LnkCtl:	ASPM L0s L1 Enabled; RCB 64
> > > bytes,
> > >  > > Disabled-
> > >  > >  CommClk+
> > >  > >  			ExtSynch- ClockPM+ AutWidDis- BWInt-
> > > AutBWInt-
> > >  > >  		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
> > >  > >  			TrErr- Train- SlotClk+ DLActive-
> > > BWMgmt-
> > >  > >  ABWMgmt-
> > >  > >  	Capabilities: [100 v1] Advanced Error Reporting
> > >  > >  		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> > > CmpltAbrt-
> > >  > >  UnxCmplt- RxOF-
> > >  > >  MalfTLP- ECRC- UnsupReq- ACSViol-
> > >  > >  		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO-
> > > CmpltAbrt-
> > >  > >  UnxCmplt- RxOF-
> > >  > >  MalfTLP- ECRC- UnsupReq- ACSViol-
> > >  > >  		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO-
> > > CmpltAbrt-
> > >  > >  UnxCmplt- RxOF+
> > >  > >  MalfTLP+ ECRC- UnsupReq- ACSViol-
> > >  > >  		CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> > >  > > Timeout-
> > >  > >  AdvNonFatalErr-
> > >  > >  		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> > >  > > Timeout-
> > >  > >  AdvNonFatalErr+
> > >  > >  		AERCap:	First Error Pointer: 00,
> > > ECRCGenCap+
> > >  > >  ECRCGenEn- ECRCChkCap+
> > >  > >  ECRCChkEn-
> > >  > >  			MultHdrRecCap- MultHdrRecEn-
> > > TLPPfxPres-
> > >  > >  HdrLogCap-
> > >  > >  		HeaderLog: 00000000 00000000 00000000 00000000
> > >  > >  	Capabilities: [13c v1] Virtual Channel
> > >  > >  		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> > >  > >  		Arb:	Fixed- WRR32- WRR64- WRR128-
> > >  > >  		Ctrl:	ArbSelect=3DFixed
> > >  > >  		Status:	InProgress-
> > >  > >  		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1
> > >  > >  RejSnoopTrans-
> > >  > >  			Arb:	Fixed- WRR32- WRR64- WRR128-
> > > TWRR128-
> > >  > >  WRR256-
> > >  > >  			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed
> > > TC/VC=3Dff
> > >  > >  			Status:	NegoPending- InProgress-
> > >  > >  	Capabilities: [160 v1] Device Serial Number xx-xx-xx-
> > > xx-xx-xx-
> > >  > >  xx-xx
> > >  > >  	Capabilities: [16c v1] Power Budgeting <?>
> > >  > >  	Kernel driver in use: wl
> > >  > >  	Kernel modules: ssb, wl
> > >  > >
> > >  > >
> > >  > >  _______________________________________________
> > >  > >  iwd mailing list -- iwd(a)lists.01.org
> > >  > >  To unsubscribe send an email to iwd-leave(a)lists.01.org
> > > =

> > > =

> =

>=20

--===============2027288531494193700==--

