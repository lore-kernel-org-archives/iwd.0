Content-Type: multipart/mixed; boundary="===============4053538920701358276=="
MIME-Version: 1.0
From: Philip Stewart <philip.stewart.public@gmail.com>
Subject: Re: DEL_INTERFACE and CMD_SET_CQM failed; Could not register frame
 watch type 00d0: -95
Date: Mon, 19 Apr 2021 21:41:12 +0100
Message-ID: <O4WTRQ.I7V6LWH79YWO2@gmail.com>
In-Reply-To: <2fe3ffc75401a5ce154b87ecafbd9d9a77c7483b.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4053538920701358276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

Interestingly, I do see them:

src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D3
src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D3

Full debug log attached.

I'm using iwd version 1.12 and iw version 5.9, in Debian bullseye.

Cheers,
Phil

On Mon, 19 Apr, 2021 at 13:10, James Prestwood <prestwoj@gmail.com> =

wrote:
> Hi Philip,
> =

> <snip>
>>  	Supported commands:
>>  		 * set_interface
>>  		 * new_key
>>  		 * join_ibss
>>  		 * set_pmksa
>>  		 * del_pmksa
>>  		 * flush_pmksa
>>  		 * connect
>>  		 * disconnect
> =

> Yes, this appears to be a fullmac card based on the commands it
> supports.
> =

>>  	software interface modes (can always be added):
>>  	interface combinations are not supported
>>  	Device supports scan flush.
>>  	max # scan plans: 1
>>  	max scan plan interval: -1
>>  	max scan plan iterations: 0
>>  	Supported extended features:
> =

> No extended features could be due to an outdated iw version, though my
> thought was that is would support handshake offloading which is
> somewhat old at this point.
> =

> Since its working well for you I wouldn't worry about it, though I am
> somewhat curious how exactly the 4-way handshake is working with a =

> zero
> MAC. Do you by chance see any eapol messages in your IWD logs (running
> in debug mode):
> =

> src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D50
> src/netdev.c:netdev_mlme_notify() MLME notification Unknown(139)
> src/netdev.c:netdev_unicast_notify() Unicast notification 129
> src/netdev.c:netdev_control_port_frame_event()
> src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D50
> =

> Those "handle_ptk_" calls mean the 4-way is happening in userspace. If
> you don't see them then the 4-way is being offloaded to the firmware
> which would make the most sense based on your zero MAC.
> =

>> =

>>  Given it appears to be performing well, I can live with it :)
>> =

>>  All the best,
>>  Phil
>> =

>>  On Mon, 19 Apr, 2021 at 12:06, James Prestwood <prestwoj@gmail.com>
>>  wrote:
>>  > Hi Philip,
>>  >
>>  > On Mon, 2021-04-19 at 19:16 +0100, Philip Stewart wrote:
>>  > >  Hi James,
>>  > >
>>  > >  Thanks for the clarification around DEL_INTERFACE/CQM, that's
>>  > >  reassuring and makes sense!
>>  > >
>>  > >  On the MAC address, yes - /sys/class/ieee80211/phy0/macaddress
>>  > >  reports
>>  > >  all zeros. Would you expect the wl driver to set this?
>>  >
>>  > I would expect that yeah. My only guess is that broadcom-wl is a
>>  > fullmac driver that doesn't set this and handles everything in the
>>  > firmware. You could see what extended features and commands it
>>  > advertises with 'iw list' to verify.
>>  >
>>  > >  n.b. I note that '[iwd]# station wlan0 show' and '# iw wlan0
>>  > > link'
>>  > >  both
>>  > >  successfully report the MAC address for the access point.
>>  > >
>>  > >  Cheers,
>>  > >  Phil
>>  > >
>>  > >  On Mon, 19 Apr, 2021 at 09:07, James Prestwood <
>>  > > prestwoj(a)gmail.com>
>>  > >  wrote:
>>  > >  > Hi Philip,
>>  > >  >
>>  > >  > On Sun, 2021-04-18 at 18:21 +0100, Philip Stewart wrote:
>>  > >  > >  Hello,
>>  > >  > >
>>  > >  > >  I've recently switched from NetworkManager and
>>  > > wpasupplicant to
>>  > >  > >  systemd-networkd and iwd. Whilst everything appears to be
>>  > >  > > working
>>  > >  > >  fine,
>>  > >  > >  I'm curious about some failures reported by iwd:
>>  > >  > >
>>  > >  > >  Apr 18 15:10:32 systemd[1]: Starting Wireless service...
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Wireless daemon version 1.12
>>  > >  > >  Apr 18 15:10:33 systemd[1]: Started Wireless service.
>>  > >  > >  Apr 18 15:10:33 iwd[661]: station: Network configuration =

>> is
>>  > >  > > disabled.
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Wiphy: 0, Name: phy0
>>  > >  > >  Apr 18 15:10:33 iwd[661]:         Permanent Address:
>>  > >  > >  00:00:00:00:00:00
>>  > >  > >  Apr 18 15:10:33 iwd[661]:         Bands: 2.4 GHz 5 GHz
>>  > >  > >  Apr 18 15:10:33 iwd[661]:         Ciphers: CCMP TKIP BIP
>>  > >  > >  Apr 18 15:10:33 iwd[661]:         Supported iftypes: =

>> ad-hoc
>>  > >  > > station
>>  > >  > >  Apr 18 15:10:33 iwd[661]: DEL_INTERFACE failed: Operation
>>  > > not
>>  > >  > >  supported
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
>>  > > type
>>  > >  > > 00d0:
>>  > >  > >  -95
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
>>  > > type
>>  > >  > > 00d0:
>>  > >  > >  -95
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
>>  > > type
>>  > >  > > 00d0:
>>  > >  > >  -95
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
>>  > > type
>>  > >  > > 00d0:
>>  > >  > >  -95
>>  > >  > >  Apr 18 15:10:33 iwd[661]: CMD_SET_CQM failed: Operation =

>> not
>>  > >  > > supported
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
>>  > > type
>>  > >  > > 00d0:
>>  > >  > >  -95
>>  > >  > >  Apr 18 15:10:33 iwd[661]: Could not register frame watch
>>  > > type
>>  > >  > > 00d0:
>>  > >  > >  -95
>>  > >  > >
>>  > >  > >  Further, I note that in the output of 'networkctl status
>>  > > wlan0',
>>  > >  > > the
>>  > >  > >  WiFi access point MAC address is reported as
>>  > > 00:00:00:00:00:00
>>  > >  > > and
>>  > >  > >  I'm
>>  > >  > >  wondering if this is a consequence of these failures and =

>> if
>>  > >  > > there is
>>  > >  > >  anything I can do about it?
>>  > >  >
>>  > >  > I'm not familiar with the wl driver specifically but I'm
>>  > > guessing
>>  > >  > it
>>  > >  > does not support DEL_INTERFACE/CQM.
>>  > >  >
>>  > >  > This is fine though. In the DEL_INTERFACE case IWD will just
>>  > > use
>>  > >  > the
>>  > >  > interface that already exists on the system. Effectively
>>  > >  > [General].UseDefaultInterface=3Dtrue.
>>  > >  >
>>  > >  > CQM is also ok as the driver (presumably) manages low RSSI
>>  > > itself
>>  > >  > and
>>  > >  > will roam on its own. At least this is what I would expect.
>>  > >  >
>>  > >  > We pull the permanent address from
>>  > >  > /sys/class/ieee80211/<phy>/macaddress. Is that reporting
>>  > > zero's?
>>  > >  >
>>  > >  > Thanks,
>>  > >  > James
>>  > >  >
>>  > >  > >  Kind regards,
>>  > >  > >  Phil
>>  > >  > >
>>  > >  > >  # lspci -vv -d 14e4:
>>  > >  > >  03:00.0 Network controller: Broadcom Inc. and subsidiaries
>>  > >  > > BCM4322
>>  > >  > >  802.11a/b/g/n Wireless LAN Controller (rev 01)
>>  > >  > >  	Subsystem: Apple Inc. AirPort Extreme
>>  > >  > >  	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
>>  > > VGASnoop-
>>  > >  > >  ParErr-
>>  > >  > >  Stepping- SERR- FastB2B- DisINTx-
>>  > >  > >  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>>  > > >TAbort-
>>  > >  > >  <TAbort- <MAbort- >SERR- <PERR- INTx-
>>  > >  > >  	Latency: 0, Cache Line Size: 256 bytes
>>  > >  > >  	Interrupt: pin A routed to IRQ 20
>>  > >  > >  	Region 0: Memory at d3200000 (64-bit, non-prefetchable)
>>  > >  > >  [size=3D16K]
>>  > >  > >  	Capabilities: [40] Power Management version 3
>>  > >  > >  		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>>  > >  > >  PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>  > >  > >  		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0
>>  > > DScale=3D2 PME-
>>  > >  > >  	Capabilities: [58] Vendor Specific Information: Len=3D78
>>  > > <?>
>>  > >  > >  	Capabilities: [e8] MSI: Enable- Count=3D1/1 Maskable-
>>  > > 64bit+
>>  > >  > >  		Address: 0000000000000000  Data: 0000
>>  > >  > >  	Capabilities: [d0] Express (v1) Endpoint, MSI 00
>>  > >  > >  		DevCap:	MaxPayload 128 bytes, PhantFunc
>>  > > 0,
>>  > >  > > Latency
>>  > >  > >  L0s <4us, L1
>>  > >  > >  unlimited
>>  > >  > >  			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
>>  > > FLReset-
>>  > >  > >  SlotPowerLimit 0.000W
>>  > >  > >  		DevCtl:	CorrErr- NonFatalErr- FatalErr-
>>  > > UnsupReq-
>>  > >  > >  			RlxdOrd- ExtTag+ PhantFunc- AuxPwr-
>>  > > NoSnoop-
>>  > >  > >  			MaxPayload 128 bytes, MaxReadReq 128
>>  > > bytes
>>  > >  > >  		DevSta:	CorrErr- NonFatalErr- FatalErr-
>>  > > UnsupReq-
>>  > >  > >  AuxPwr- TransPend-
>>  > >  > >  		LnkCap:	Port #0, Speed 2.5GT/s, Width x1,
>>  > > ASPM
>>  > >  > > L0s
>>  > >  > >  L1, Exit Latency
>>  > >  > >  L0s <4us, L1 <64us
>>  > >  > >  			ClockPM+ Surprise- LLActRep- BwNot-
>>  > >  > >  ASPMOptComp-
>>  > >  > >  		LnkCtl:	ASPM L0s L1 Enabled; RCB 64
>>  > > bytes,
>>  > >  > > Disabled-
>>  > >  > >  CommClk+
>>  > >  > >  			ExtSynch- ClockPM+ AutWidDis- BWInt-
>>  > > AutBWInt-
>>  > >  > >  		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
>>  > >  > >  			TrErr- Train- SlotClk+ DLActive-
>>  > > BWMgmt-
>>  > >  > >  ABWMgmt-
>>  > >  > >  	Capabilities: [100 v1] Advanced Error Reporting
>>  > >  > >  		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
>>  > > CmpltAbrt-
>>  > >  > >  UnxCmplt- RxOF-
>>  > >  > >  MalfTLP- ECRC- UnsupReq- ACSViol-
>>  > >  > >  		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO-
>>  > > CmpltAbrt-
>>  > >  > >  UnxCmplt- RxOF-
>>  > >  > >  MalfTLP- ECRC- UnsupReq- ACSViol-
>>  > >  > >  		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO-
>>  > > CmpltAbrt-
>>  > >  > >  UnxCmplt- RxOF+
>>  > >  > >  MalfTLP+ ECRC- UnsupReq- ACSViol-
>>  > >  > >  		CESta:	RxErr- BadTLP- BadDLLP- Rollover-
>>  > >  > > Timeout-
>>  > >  > >  AdvNonFatalErr-
>>  > >  > >  		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
>>  > >  > > Timeout-
>>  > >  > >  AdvNonFatalErr+
>>  > >  > >  		AERCap:	First Error Pointer: 00,
>>  > > ECRCGenCap+
>>  > >  > >  ECRCGenEn- ECRCChkCap+
>>  > >  > >  ECRCChkEn-
>>  > >  > >  			MultHdrRecCap- MultHdrRecEn-
>>  > > TLPPfxPres-
>>  > >  > >  HdrLogCap-
>>  > >  > >  		HeaderLog: 00000000 00000000 00000000 00000000
>>  > >  > >  	Capabilities: [13c v1] Virtual Channel
>>  > >  > >  		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>>  > >  > >  		Arb:	Fixed- WRR32- WRR64- WRR128-
>>  > >  > >  		Ctrl:	ArbSelect=3DFixed
>>  > >  > >  		Status:	InProgress-
>>  > >  > >  		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1
>>  > >  > >  RejSnoopTrans-
>>  > >  > >  			Arb:	Fixed- WRR32- WRR64- WRR128-
>>  > > TWRR128-
>>  > >  > >  WRR256-
>>  > >  > >  			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed
>>  > > TC/VC=3Dff
>>  > >  > >  			Status:	NegoPending- InProgress-
>>  > >  > >  	Capabilities: [160 v1] Device Serial Number xx-xx-xx-
>>  > > xx-xx-xx-
>>  > >  > >  xx-xx
>>  > >  > >  	Capabilities: [16c v1] Power Budgeting <?>
>>  > >  > >  	Kernel driver in use: wl
>>  > >  > >  	Kernel modules: ssb, wl
>>  > >  > >
>>  > >  > >
>>  > >  > >  _______________________________________________
>>  > >  > >  iwd mailing list -- iwd(a)lists.01.org
>>  > >  > >  To unsubscribe send an email to iwd-leave(a)lists.01.org
>>  > >
>>  > >
>> =

>> =

> =



--===============4053538920701358276==
Content-Type: text/x-log
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="iwd_debug.log"

IyAvdXNyL2xpYmV4ZWMvaXdkIC0tZGVidWcKV2lyZWxlc3MgZGFlbW9uIHZlcnNpb24gMS4xMgpz
cmMvbWFpbi5jOm1haW4oKSBVc2luZyBjb25maWd1cmF0aW9uIGRpcmVjdG9yeSAvZXRjL2l3ZApz
cmMvc3RvcmFnZS5jOnN0b3JhZ2VfY3JlYXRlX2RpcnMoKSBVc2luZyBzdGF0ZSBkaXJlY3Rvcnkg
L3Zhci9saWIvaXdkCnNyYy9tYWluLmM6bmw4MDIxMV9hcHBlYXJlZCgpIEZvdW5kIG5sODAyMTEg
aW50ZXJmYWNlCnNyYy9tb2R1bGUuYzppd2RfbW9kdWxlc19pbml0KCkgCnN0YXRpb246IE5ldHdv
cmsgY29uZmlndXJhdGlvbiBpcyBkaXNhYmxlZC4Kc3JjL3dzYy5jOndzY19pbml0KCkgCnNyYy9l
YXAuYzpfX2VhcF9tZXRob2RfZW5hYmxlKCkgCnNyYy9lYXAtd3NjLmM6ZWFwX3dzY19pbml0KCkg
CnNyYy9lYXAtbWQ1LmM6ZWFwX21kNV9pbml0KCkgCnNyYy9lYXAtdGxzLmM6ZWFwX3Rsc19pbml0
KCkgCnNyYy9lYXAtdHRscy5jOmVhcF90dGxzX2luaXQoKSAKc3JjL2VhcC1tc2NoYXB2Mi5jOmVh
cF9tc2NoYXB2Ml9pbml0KCkgCnNyYy9lYXAtc2ltLmM6ZWFwX3NpbV9pbml0KCkgCnNyYy9lYXAt
YWthLmM6ZWFwX2FrYV9wcmltZV9pbml0KCkgCnNyYy9lYXAtYWthLmM6ZWFwX2FrYV9pbml0KCkg
CnNyYy9lYXAtcGVhcC5jOmVhcF9wZWFwX2luaXQoKSAKc3JjL2VhcC1ndGMuYzplYXBfZ3RjX2lu
aXQoKSAKc3JjL2VhcC1wd2QuYzplYXBfcHdkX2luaXQoKSAKc3JjL21hbmFnZXIuYzptYW5hZ2Vy
X3dpcGh5X2R1bXBfY2FsbGJhY2soKSBOZXcgd2lwaHkgcGh5MCBhZGRlZCAoMCkKV2lwaHk6IDAs
IE5hbWU6IHBoeTAKCVBlcm1hbmVudCBBZGRyZXNzOiAwMDowMDowMDowMDowMDowMAoJQmFuZHM6
IDIuNCBHSHogNSBHSHoKCUNpcGhlcnM6IENDTVAgVEtJUCBCSVAKCVN1cHBvcnRlZCBpZnR5cGVz
OiBhZC1ob2Mgc3RhdGlvbgpzcmMvbWFuYWdlci5jOm1hbmFnZXJfaW50ZXJmYWNlX2R1bXBfY2Fs
bGJhY2soKSAKc3JjL21hbmFnZXIuYzptYW5hZ2VyX2dldF9pbnRlcmZhY2VfY2IoKSAKc3JjL21h
bmFnZXIuYzptYW5hZ2VyX2dldF9pbnRlcmZhY2VfY2IoKSAKc3JjL3dpcGh5LmM6d2lwaHlfdXBk
YXRlX3JlZ19kb21haW4oKSBOZXcgcmVnIGRvbWFpbiBjb3VudHJ5IGNvZGUgZm9yIChnbG9iYWwp
IGlzIDAwCnNyYy9tYW5hZ2VyLmM6bWFuYWdlcl9kZWxfaW50ZXJmYWNlX2NiKCkgCkRFTF9JTlRF
UkZBQ0UgZmFpbGVkOiBPcGVyYXRpb24gbm90IHN1cHBvcnRlZApzcmMvbWFuYWdlci5jOm1hbmFn
ZXJfdXNlX2RlZmF1bHQoKSAKc3JjL25ldGRldi5jOm5ldGRldl9jcmVhdGVfZnJvbV9nZW5sKCkg
Q3JlYXRlZCBpbnRlcmZhY2Ugd2xhbjBbMyAxXQpzcmMvbmV0ZGV2LmM6bmV0ZGV2X2NxbV9yc3Np
X3VwZGF0ZSgpIApDb3VsZCBub3QgcmVnaXN0ZXIgZnJhbWUgd2F0Y2ggdHlwZSAwMGQwOiAtOTUK
Q291bGQgbm90IHJlZ2lzdGVyIGZyYW1lIHdhdGNoIHR5cGUgMDBkMDogLTk1CnNyYy9uZXRkZXYu
YzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDMKc3JjL25ldGRldi5j
Om5ldGRldl9zZXRfNGFkZHIoKSBuZXRkZXY6IDMgdXNlXzRhZGRyOiAwCnNyYy9uZXRkZXYuYzpu
ZXRkZXZfaW5pdGlhbF91cF9jYigpIEludGVyZmFjZSAzIGluaXRpYWxpemVkCnNyYy9zdGF0aW9u
LmM6c3RhdGlvbl9lbnRlcl9zdGF0ZSgpIE9sZCBTdGF0ZTogZGlzY29ubmVjdGVkLCBuZXcgc3Rh
dGU6IGF1dG9jb25uZWN0X3F1aWNrCnNyYy93aXBoeS5jOndpcGh5X3JhZGlvX3dvcmtfaW5zZXJ0
KCkgSW5zZXJ0aW5nIHdvcmsgaXRlbSAxCnNyYy93aXBoeS5jOndpcGh5X3JhZGlvX3dvcmtfbmV4
dCgpIFN0YXJ0aW5nIHdvcmsgaXRlbSAxCnNyYy93c2MuYzp3c2NfYWRkX3N0YXRpb24oKSBTaW1w
bGUgQ29uZmlndXJhdGlvbiBpc24ndCBzdXBwb3J0ZWQgYnkgaWZpbmRleCAzCkNvdWxkIG5vdCBy
ZWdpc3RlciBmcmFtZSB3YXRjaCB0eXBlIDAwZDA6IC05NQpDb3VsZCBub3QgcmVnaXN0ZXIgZnJh
bWUgd2F0Y2ggdHlwZSAwMGQwOiAtOTUKQ01EX1NFVF9DUU0gZmFpbGVkOiBPcGVyYXRpb24gbm90
IHN1cHBvcnRlZApzcmMvbWFuYWdlci5jOm1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5vdGlmaWNh
dGlvbiBvZiBjb21tYW5kIFNldCBJbnRlcmZhY2UoNikKQ291bGQgbm90IHJlZ2lzdGVyIGZyYW1l
IHdhdGNoIHR5cGUgMDBkMDogLTk1CnNyYy9zY2FuLmM6c2Nhbl9ub3RpZnkoKSBTY2FuIG5vdGlm
aWNhdGlvbiBUcmlnZ2VyIFNjYW4oMzMpCnNyYy9zY2FuLmM6c2Nhbl9yZXF1ZXN0X3RyaWdnZXJl
ZCgpIFBhc3NpdmUgc2NhbiB0cmlnZ2VyZWQgZm9yIHdkZXYgMQpzcmMvc3RhdGlvbi5jOnN0YXRp
b25fcXVpY2tfc2Nhbl90cmlnZ2VyZWQoKSBRdWljayBzY2FuIHRyaWdnZXJlZCBmb3Igd2xhbjAK
Q291bGQgbm90IHJlZ2lzdGVyIGZyYW1lIHdhdGNoIHR5cGUgMDBkMDogLTk1CnNyYy93aXBoeS5j
OndpcGh5X3JlZ19ub3RpZnkoKSBOb3RpZmljYXRpb24gb2YgY29tbWFuZCBSZWcgQmVhY29uIEhp
bnQoNDIpCnNyYy93aXBoeS5jOndpcGh5X3JlZ19ub3RpZnkoKSBOb3RpZmljYXRpb24gb2YgY29t
bWFuZCBSZWcgQmVhY29uIEhpbnQoNDIpCnNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnko
KSBldmVudCAxNiBvbiBpZmluZGV4IDMKc3JjL3dpcGh5LmM6d2lwaHlfcmVnX25vdGlmeSgpIE5v
dGlmaWNhdGlvbiBvZiBjb21tYW5kIFJlZyBCZWFjb24gSGludCg0MikKc3JjL3NjYW4uYzpzY2Fu
X25vdGlmeSgpIFNjYW4gbm90aWZpY2F0aW9uIE5ldyBTY2FuIFJlc3VsdHMoMzQpCnNyYy9zY2Fu
LmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjawpzcmMvc2Nhbi5jOnNjYW5f
cGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogMTkzLzI1NQpzcmMvc2Nhbi5j
OmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpnZXRfc2Nh
bl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrCnNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJh
Y2soKSBnZXRfc2Nhbl9jYWxsYmFjawpzcmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0
aW9uX2VsZW1lbnRzKCkgTG9hZDogMTQwLzI1NQpzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNr
KCkgZ2V0X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpzY2FuX3BhcnNlX2Jzc19pbmZvcm1hdGlv
bl9lbGVtZW50cygpIExvYWQ6IDU2LzI1NQpzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkg
Z2V0X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpzY2FuX3BhcnNlX2Jzc19pbmZvcm1hdGlvbl9l
bGVtZW50cygpIExvYWQ6IDU2LzI1NQpzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0
X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpzY2FuX3BhcnNlX2Jzc19pbmZvcm1hdGlvbl9lbGVt
ZW50cygpIExvYWQ6IDg0LzI1NQpzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3Nj
YW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxi
YWNrCnNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjawpzcmMv
c2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogNzUvMjU1
CnNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjawpzcmMvc2Nh
bi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpzY2Fu
X3BhcnNlX2Jzc19pbmZvcm1hdGlvbl9lbGVtZW50cygpIExvYWQ6IDIwLzI1NQpzcmMvc2Nhbi5j
OmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpzY2FuX3Bh
cnNlX2Jzc19pbmZvcm1hdGlvbl9lbGVtZW50cygpIExvYWQ6IDE2LzI1NQpzcmMvc2Nhbi5jOmdl
dF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3NjYW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpnZXRfc2Nhbl9j
YWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrCnNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2so
KSBnZXRfc2Nhbl9jYWxsYmFjawpzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3Nj
YW5fY2FsbGJhY2sKc3JjL3NjYW4uYzpzY2FuX3BhcnNlX2Jzc19pbmZvcm1hdGlvbl9lbGVtZW50
cygpIExvYWQ6IDIvMjU1CnNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9j
YWxsYmFjawpzcmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkg
TG9hZDogMi8yNTUKc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxi
YWNrCnNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjawpzcmMv
c2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogMTM2LzI1
NQpzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3NjYW5fY2FsbGJhY2sKc3JjL3Nj
YW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrCnNyYy9zY2FuLmM6Z2V0
X3NjYW5fZG9uZSgpIGdldF9zY2FuX2RvbmUKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVu
X2JzcygpIFByb2Nlc3NpbmcgQlNTICc1NDo4MzozYTowNzo0MDpjZScgd2l0aCBTU0lEOiBidWJi
bGUsIGZyZXE6IDU1MDAsIHJhbms6IDEwNjg5LCBzdHJlbmd0aDogLTQ5MDAKc3JjL3N0YXRpb24u
YzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIEFkZGVkIG5ldyBOZXR3b3JrICJidWJibGUiIHNlY3Vy
aXR5IHBzawpzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBC
U1MgJzcyOjgzOjNhOjA3OjQwOmNiJyB3aXRoIFNTSUQ6ICwgZnJlcTogNTUwMCwgcmFuazogMTA2
ODksIHN0cmVuZ3RoOiAtNDkwMApzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkg
QlNTIGhhcyBoaWRkZW4gU1NJRApzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkg
UHJvY2Vzc2luZyBCU1MgJzcwOjUwOmFmOmI1OjE1Ojg1JyB3aXRoIFNTSUQ6IFNLWTg3MzRFLCBm
cmVxOiA1MTgwLCByYW5rOiA4MzMyLCBzdHJlbmd0aDogLTU4MDAKc3JjL3N0YXRpb24uYzpzdGF0
aW9uX2FkZF9zZWVuX2JzcygpIEFkZGVkIG5ldyBOZXR3b3JrICJTS1k4NzM0RSIgc2VjdXJpdHkg
cHNrCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJTUyAn
NWM6MDM6Mzk6OGI6ZTA6MjMnIHdpdGggU1NJRDogVm9kYWZvbmVDb25uZWN0NTg0NzI5NDAsIGZy
ZXE6IDUyNjAsIHJhbms6IDcxMDksIHN0cmVuZ3RoOiAtNTcwMApzcmMvc3RhdGlvbi5jOnN0YXRp
b25fYWRkX3NlZW5fYnNzKCkgQWRkZWQgbmV3IE5ldHdvcmsgIlZvZGFmb25lQ29ubmVjdDU4NDcy
OTQwIiBzZWN1cml0eSBwc2sKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFBy
b2Nlc3NpbmcgQlNTICc2YTo4MzozYTowNzo0MDpjYycgd2l0aCBTU0lEOiBlcmVib3MsIGZyZXE6
IDI0MzcsIHJhbms6IDQ5NzYsIHN0cmVuZ3RoOiAtNDgwMApzcmMvc3RhdGlvbi5jOnN0YXRpb25f
YWRkX3NlZW5fYnNzKCkgQWRkZWQgbmV3IE5ldHdvcmsgImVyZWJvcyIgc2VjdXJpdHkgcHNrCnNy
Yy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJTUyAnNTQ6ODM6
M2E6MDc6NDA6Y2QnIHdpdGggU1NJRDogYnViYmxlLCBmcmVxOiAyNDM3LCByYW5rOiA0OTc2LCBz
dHJlbmd0aDogLTQ4MDAKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nl
c3NpbmcgQlNTICc3ODo2NTo1OTo4NDo5NTo1YScgd2l0aCBTU0lEOiBQTFVTTkVULTJKV04sIGZy
ZXE6IDI0MTIsIHJhbms6IDQxNjcsIHN0cmVuZ3RoOiAtNDYwMApzcmMvc3RhdGlvbi5jOnN0YXRp
b25fYWRkX3NlZW5fYnNzKCkgQWRkZWQgbmV3IE5ldHdvcmsgIlBMVVNORVQtMkpXTiIgc2VjdXJp
dHkgcHNrCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJT
UyAnNzA6NTA6YWY6YjU6MTU6ODInIHdpdGggU1NJRDogU0tZODczNEUsIGZyZXE6IDI0MzcsIHJh
bms6IDM5MzUsIHN0cmVuZ3RoOiAtNDkwMApzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5f
YnNzKCkgUHJvY2Vzc2luZyBCU1MgJzVjOjAzOjM5OjhiOmUwOjIxJyB3aXRoIFNTSUQ6IFZvZGFm
b25lQ29ubmVjdDU4NDcyOTQwLCBmcmVxOiAyNDcyLCByYW5rOiAzMjQxLCBzdHJlbmd0aDogLTU4
MDAKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3NpbmcgQlNTICc5
YzozMTpjMzo0NjpmMzphZCcgd2l0aCBTU0lEOiBTS1kxRThWWSwgZnJlcTogNTE4MCwgcmFuazog
MjkzNywgc3RyZW5ndGg6IC03MzAwCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3Mo
KSBBZGRlZCBuZXcgTmV0d29yayAiU0tZMUU4VlkiIHNlY3VyaXR5IHBzawpzcmMvc3RhdGlvbi5j
OnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJzc4OjY1OjU5Ojg0Ojk1OjVi
JyB3aXRoIFNTSUQ6IFBMVVNORVQtMkpXTiwgZnJlcTogNTE4MCwgcmFuazogMjUzOCwgc3RyZW5n
dGg6IC03MjAwCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5n
IEJTUyAnOWM6MzE6YzM6NDY6ZjM6YWEnIHdpdGggU1NJRDogU0tZMUU4VlksIGZyZXE6IDI0NjIs
IHJhbms6IDI0OTUsIHN0cmVuZ3RoOiAtNjcwMApzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3Nl
ZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJzI0OjdmOjIwOjU0OmMyOmNkJyB3aXRoIFNTSUQ6IFNh
Z2VtY29tLTgzSzlQSCwgZnJlcTogMjQ2MiwgcmFuazogMjI2OCwgc3RyZW5ndGg6IC03MDAwCnNy
Yy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBBZGRlZCBuZXcgTmV0d29yayAiU2Fn
ZW1jb20tODNLOVBIIiBzZWN1cml0eSBwc2sKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVu
X2JzcygpIFByb2Nlc3NpbmcgQlNTICdhMDowNDo2MDozYTo4MTowOCcgd2l0aCBTU0lEOiBTS1k4
NzM0RV8yR0VYVCwgZnJlcTogMjQzNywgcmFuazogMjE0Nywgc3RyZW5ndGg6IC03MTAwCnNyYy9z
dGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBBZGRlZCBuZXcgTmV0d29yayAiU0tZODcz
NEVfMkdFWFQiIHNlY3VyaXR5IHBzawpzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNz
KCkgUHJvY2Vzc2luZyBCU1MgJ2IwOjVhOmRhOmY2OjdjOmFkJyB3aXRoIFNTSUQ6IERJUkVDVC1B
Qy1IUCBPZmZpY2VKZXQgNDY1MCwgZnJlcTogMjQxMiwgcmFuazogMjExNywgc3RyZW5ndGg6IC03
MTAwCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBBZGRlZCBuZXcgTmV0d29y
ayAiRElSRUNULUFDLUhQIE9mZmljZUpldCA0NjUwIiBzZWN1cml0eSBwc2sKc3JjL3N0YXRpb24u
YzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3NpbmcgQlNTICcwODpkNTo5ZDo5ZjoyZjpj
NCcgd2l0aCBTU0lEOiBQTFVTTkVULVRDRjUsIGZyZXE6IDI0MzcsIHJhbms6IDIwNzMsIHN0cmVu
Z3RoOiAtNzIwMApzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgQWRkZWQgbmV3
IE5ldHdvcmsgIlBMVVNORVQtVENGNSIgc2VjdXJpdHkgcHNrCnNyYy9zdGF0aW9uLmM6c3RhdGlv
bl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJTUyAnZDg6MGQ6MTc6OWE6ZTA6NGUnIHdpdGgg
U1NJRDogVFAtTGlua19FMDRFLCBmcmVxOiAyNDEyLCByYW5rOiAxOTM1LCBzdHJlbmd0aDogLTY4
MDAKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIEFkZGVkIG5ldyBOZXR3b3Jr
ICJUUC1MaW5rX0UwNEUiIHNlY3VyaXR5IHBzawpzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3Nl
ZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJ2NjOjQwOmQwOjUwOmUzOjE1JyB3aXRoIFNTSUQ6IEZh
bWlseWhvbWVfRVhULCBmcmVxOiAyNDEyLCByYW5rOiAxNTMzLCBzdHJlbmd0aDogLTc5MDAKc3Jj
L3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIEFkZGVkIG5ldyBOZXR3b3JrICJGYW1p
bHlob21lX0VYVCIgc2VjdXJpdHkgcHNrCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9i
c3MoKSBQcm9jZXNzaW5nIEJTUyAnODA6NzI6MTU6YmM6ODM6ZjInIHdpdGggU1NJRDogU0tZQ0U2
RU0sIGZyZXE6IDI0NjIsIHJhbms6IDE0NjAsIHN0cmVuZ3RoOiAtODAwMApzcmMvc3RhdGlvbi5j
OnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgQWRkZWQgbmV3IE5ldHdvcmsgIlNLWUNFNkVNIiBzZWN1
cml0eSBwc2sKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3Npbmcg
QlNTICdhMDowNDo2MDozYTo4MTowNycgd2l0aCBTU0lEOiBTS1k4NzM0RV81R0VYVCwgZnJlcTog
NTE4MCwgcmFuazogMTM4Nywgc3RyZW5ndGg6IC04MTAwCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9h
ZGRfc2Vlbl9ic3MoKSBBZGRlZCBuZXcgTmV0d29yayAiU0tZODczNEVfNUdFWFQiIHNlY3VyaXR5
IHBzawpzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1Mg
J2NjOjMyOmU1OjM5OjExOmZlJyB3aXRoIFNTSUQ6IGJ1YmJsZSwgZnJlcTogNTE4MCwgcmFuazog
MTA4MCwgc3RyZW5ndGg6IC04NTAwCnNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3Mo
KSBQcm9jZXNzaW5nIEJTUyAnMDg6ZDU6OWQ6OWY6MmY6YzUnIHdpdGggU1NJRDogUExVU05FVC1U
Q0Y1LCBmcmVxOiA1MjQwLCByYW5rOiAxMDA4LCBzdHJlbmd0aDogLTg2MDAKc3JjL3N0YXRpb24u
YzpzdGF0aW9uX2F1dG9jb25uZWN0X25leHQoKSBDb25zaWRlcmluZyBhdXRvY29ubmVjdGluZyB0
byBCU1MgJzU0OjgzOjNhOjA3OjQwOmNlJyB3aXRoIFNTSUQ6IGJ1YmJsZSwgZnJlcTogNTUwMCwg
cmFuazogMTA2ODksIHN0cmVuZ3RoOiAtNDkwMApzcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3Jr
X2luc2VydCgpIEluc2VydGluZyB3b3JrIGl0ZW0gMgpzcmMvc3RhdGlvbi5jOl9fc3RhdGlvbl9j
b25uZWN0X25ldHdvcmsoKSBjb25uZWN0aW5nIHRvIEJTUyA1NDo4MzozYTowNzo0MDpjZQpzcmMv
c3RhdGlvbi5jOnN0YXRpb25fZW50ZXJfc3RhdGUoKSBPbGQgU3RhdGU6IGF1dG9jb25uZWN0X3F1
aWNrLCBuZXcgc3RhdGU6IGNvbm5lY3RpbmcKc3JjL3NjYW4uYzpzY2FuX2NhbmNlbCgpIFRyeWlu
ZyB0byBjYW5jZWwgc2NhbiBpZCAxIGZvciB3ZGV2IDEKc3JjL3dpcGh5LmM6d2lwaHlfcmFkaW9f
d29ya19kb25lKCkgV29yayBpdGVtIDEgZG9uZQpzcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3Jr
X25leHQoKSBTdGFydGluZyB3b3JrIGl0ZW0gMgpzcmMvc3RhdGlvbi5jOnN0YXRpb25fbmV0ZGV2
X2V2ZW50KCkgQXNzb2NpYXRpbmcKc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1M
TUUgbm90aWZpY2F0aW9uIENvbm5lY3QoNDYpCnNyYy9uZXRkZXYuYzpuZXRkZXZfY29ubmVjdF9l
dmVudCgpIApzcmMvbmV0ZGV2LmM6bmV0ZGV2X2xpbmtfbm90aWZ5KCkgZXZlbnQgMTYgb24gaWZp
bmRleCAzCnNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmlu
ZGV4IDMKc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5k
ZXggMwpzcmMvd2lwaHkuYzp3aXBoeV9yZWdfbm90aWZ5KCkgTm90aWZpY2F0aW9uIG9mIGNvbW1h
bmQgUmVnIENoYW5nZSgzNikKc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX3JlZ19kb21haW4oKSBO
ZXcgcmVnIGRvbWFpbiBjb3VudHJ5IGNvZGUgZm9yIChnbG9iYWwpIGlzIERFCnNyYy9lYXBvbC5j
OmVhcG9sX2hhbmRsZV9wdGtfMV9vZl80KCkgaWZpbmRleD0zCnNyYy9lYXBvbC5jOmVhcG9sX2hh
bmRsZV9wdGtfM19vZl80KCkgaWZpbmRleD0zCnNyYy9uZXRkZXYuYzpuZXRkZXZfc2V0X2d0aygp
IDMKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2hhbmRzaGFrZV9ldmVudCgpIFNldHRpbmcga2V5cwpz
cmMvbmV0ZGV2LmM6bmV0ZGV2X3NldF90aygpIDMKc3JjL25ldGRldi5jOm5ldGRldl9zZXRfcmVr
ZXlfb2ZmbG9hZCgpIDMKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2Nvbm5lY3RfY2IoKSAzLCByZXN1
bHQ6IDAKc3JjL3N0YXRpb24uYzpzdGF0aW9uX2VudGVyX3N0YXRlKCkgT2xkIFN0YXRlOiBjb25u
ZWN0aW5nLCBuZXcgc3RhdGU6IGNvbm5lY3RlZApzcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3Jr
X2RvbmUoKSBXb3JrIGl0ZW0gMiBkb25lCgo=

--===============4053538920701358276==--

