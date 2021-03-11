Content-Type: multipart/mixed; boundary="===============0628403858702534888=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Thu, 11 Mar 2021 11:06:48 +0000
Message-ID: <bd8195e8-5a46-7443-1458-2cd175523d98@bang-olufsen.dk>
In-Reply-To: <90841d57-63ec-5603-e4b2-876e0f741db2@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0628403858702534888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 3/11/21 3:36 AM, Denis Kenzior wrote:
> Hi Alvin,
> =

>> Roam offload is enabled by default in brcmfmac, but it can be disabled
>> by setting the module parameter roamoff=3D1. Note this stands for "roam
>> (offload) off" - not "roam off(load)" - so 1 means that the firmware
>> will not roam autonomously. Anyway, in that case the driver will not set
>> the WIPHY_FLAG_SUPPORTS_FW_ROAM flag:
>>
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:
>> 7180=C2=A0=C2=A0=C2=A0 if (!ifp->drvr->settings->roamoff)
>> 7181=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wiphy->flags |=3D WIPHY_F=
LAG_SUPPORTS_FW_ROAM;
>>
>> So from that perspective, I think James' patch looks perfectly fine. I
>> have not tested it though.
> =

> Aha!=C2=A0 Thanks for the explanation.=C2=A0 In light of this I concur th=
at we =

> should take James' proposed approach and disable iwd's roaming logic if =

> the flag is set.
> =

>> Yes, this was what I experienced when the firmware roamed by itself.
>> Since we rely on iwd to handle the 4-Way Handshake, I instead worked on
>> getting roaming to work with roam offload disabled. But I didn't think
>> to go back and submit some iwd patches to handle the original failure
>> case - my bad.
>>
> =

> No worries, I was just confused how you were not hitting this case and =

> wondered whether you had more aggressive roaming thresholds so iwd =

> roamed ahead of the firmware.
> =

>>>
>>>>
>>>>> right if station reacts to CQM events. Plus station cannot even do
>>>>> FT on these
>>>>> cards anyways.
>>>>
>>>> Sure, and FT is a bit tricky.=C2=A0 But FT is not the only way to roam=
...
>>
>> Right, and I naively hoped that I might be able to get FT roaming to
>> work too. The latest news I have from our hardware vendor is that - in
>> theory - the chip firmware supports sending reassoc/auth frames, but I
>> have not received any documentation yet. As it stands, brcmfmac does not
>> implement the relevant cfg80211 ops, so one must settle for non-FT
>> roaming if one wishes to use iwd. That would change with the incoming
>> support for 4-Way Handshake offload in iwd, in which case both things
>> can be offloaded to the firmware.
> =

> Right.=C2=A0 This is also a problem for SAE and OWE.=C2=A0 We are also ha=
ving =

> trouble locating brcmfmac based hardware that is SAE/WPA3 or FT offload =

> capable.=C2=A0 Any pointers?

I think it's at least partially a firmware constraint. My =

hardware/firmware pairing doesn't seem to support SAE/WPA3 because it's =

not in the list of features advertised with this wl command:

# wl cap
ap sta wme 802.11d 802.11h rm cqa ccx cac dualband ampdu ampdu_tx =

ampdu_rx amsdurx amsdutx radio_pwrsave p2p proptxstatus mchan wds =

vht-prop-rates dfrts txpwrcache stbc-tx stbc-rx-1ss pspretend rsdb =

probresp_mac_filter mfp wnm bsstrans ndoe mimo_ps epno pfnx scanmac

Nor is it seen here:

# cat /sys/kernel/debug/ieee80211/phy0/features
Features: 001218b6
	MCHAN
	PNO
	P2P
	RSDB
	SCAN_RANDOM_MAC
	MFP
	GSCAN
	DOT11H
	DUMP_OBSS

Quirks:   00000000

If you load the driver with the debug=3D4 parameter set (enables INFO =

debug logging, you may have to build with -DDEBUG), you can see which =

features get detected and enabled, which corresponds to the above sysfs =

output:

[   10.046614] brcmfmac: brcmf_feat_firmware_capabilities [ ap sta wme =

802.11d 802.11h rm cqa ccx cac dualband ampdu ampdu_tx ampdu_rx amsdurx =

amsdutx radio_pwrsave p2p proptxstatus mchan wds vht-prop-rates dfrts =

txpwrcache stbc-tx stbc-rx-1ss pspretend rsdb probresp_mac_filter mfp =

wnm bsstrans ndoe mimo_ps epno pfnx scanmac ]
[   10.046634] brcmfmac: brcmf_feat_firmware_capabilities enabling =

feature: MCHAN
[   10.046638] brcmfmac: brcmf_feat_firmware_capabilities enabling =

feature: P2P
[   10.046662] brcmfmac: brcmf_feat_firmware_capabilities enabling =

feature: DOT11H
[   10.046931] brcmfmac: brcmf_feat_iovar_data_set enabling feature: GSCAN
[   10.047153] brcmfmac: brcmf_feat_iovar_int_get enabling feature: PNO
[   10.047559] brcmfmac: brcmf_feat_iovar_int_get enabling feature: RSDB
[   10.047972] brcmfmac: brcmf_feat_iovar_int_get enabling feature: MFP
[   10.048179] brcmfmac: brcmf_feat_iovar_int_get enabling feature: =

DUMP_OBSS

Finally you can also grep the version string of the firmware file:

# strings /lib/firmware/cypress/cyfmac4359-pcie.bin | grep Ve
rsion
4359b1-roml/pcie-wl11u-mfp-nvramadj-sr-die3-pwrofs-wnm-mobfd-txbf-mimopscan=
-slna-nsslimit-lpc-wepso-pspretend-apbs-apcs-spurcan-clm_min-obss-cynctsf-o=
bssdump-rxactfrm-kmdump =

Version: ...

Which can also give a hint as to the features (although it doesn't seem =

to map 1-1 with the above).

So to answer your question, I don't know directly, but then I did some =

searching online and found this thread[1] where a guy does the same grep:

$ strings /lib/firmware/brcm/brcmfmac43455-sdio.bin | grep Version
43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-wowlpf-i=
dsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-roamprof-txbf-ve-sae=
-sr-okc-bpd =

Version: ...

And there I can see 'sae', so there's a good chance that this firmware =

supports SAE offload. For WPA3 and FT offload I don't know what the =

corresponding string is but I believe (firmware driven) FT is a standard =

feature so it might not have its own string. More on that later...

So I checked out the latest FMAC/FW releases from Cypress[2] and did the =

same grepping:

alvin(a)capella ~/Downloads/cypress/5.4.18-2020_0925/firmware $ for i in =

`ls *.bin`; do x=3D$(strings $i | grep Version | grep sae); if [ ! -z "$x" =

]; then echo "$i"; echo "$x"; fi; done
cyfmac43012-sdio.bin
43012c0-roml/threadx-sdio-ag-p2p-keepalive-sr-proptxstatus-fcbs-ipa-idsup-i=
dauth-consuartcc-dwt-pf2-mcs8support-cca-ipcamfeatures-bcntrim-wmetp-ulp-pn=
o-aoe-txbf-wnm-bwte-ve-mfp-roamprof-dltro-mchan-dbguc-dbgmac-srampmac-utrac=
e-tko-mchandump-tcpka-extgpio-sae-okc-scancache-clm_min-pwrstats-phyextiova=
r-dpp =

(config_sdio_release)  Version: 13.10.271.253 (c4c4c7c CY) CRC: 3c8e9ce4 =

Date: Wed 2020-09-09 01:30:00 PDT Ucode Ver: 1182.166 FWID 01-3d0fbe29
cyfmac43430-sdio.bin
43430a1-roml/sdio-g-pool-p2p-idsup-idauth-pktfilter-keepalive-aoe-lpc-swdiv=
-srfast-fuart-btcxhybridhw-noclminc-clm_min-fbt-mfp-sae-tko =

Version: 7.45.98.97 (r724416 CY) CRC: 588b07d3 Date: Sun 2020-02-16 =

22:41:02 PST Ucode Ver: 1043.2137 FWID 01-bf41ed64
cyfmac43455-sdio.bin
43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-wowlpf-i=
dsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-roamprof-txbf-ve-sae=
-dpp-sr-okc-bpd =

Version: 7.45.221 (3a6d3a0 CY) CRC: 8f977704 Date: Fri 2020-09-18 =

02:30:48 PDT Ucode Ver: 1043.2156 FWID 01-bbd9282b
cyfmac4373-sdio.bin
4373a0-roml/sdio-ag-p2p-mchan-wfds-idsup-idauth-wowlpf-pktfilter-swdivenhan=
ced-aoe-mfp-clm_min-sr-txbf-proptxstatus-sae-2040coex =

(config_sdio_release)  Version: 13.10.246.234 (c294843 CY) CRC: e0db40f8 =

Date: Thu 2020-08-06 15:14:45 PDT Ucode Ver: 1191.1 FWID 01-f6e93fbb
cyfmac4373-usb.bin
4373a0-roml/usb-ag-p2p-mchan-wfds-idsup-idauth-wowlpf-pktfilter-swdivenhanc=
ed-aoe-mfp-clm_min-sr-txbf-proptxstatus-sae-2040coex-bdcsr-msgtrace =

(config_usb_release)  Version: 13.10.246.234 (c294843 CY) CRC: da9e5c6b =

Date: Thu 2020-08-06 15:09:17 PDT Ucode Ver: 1191.1 FWID 01-d5cfbedf
cyfmac54591-pcie.bin
4359d0-roml/pcie-wl11u-mfp-sr-apcs-phyflags-ag-pktfilter-p2p-mchan-proptxst=
atus-ampduhostreorder-powoff-pwrofs5g-pwrstats-lpc-clm_min-rxdesens-wapi-tx=
bf-dfsradar-murx-pprhtoffset-txpwr-mbss-rsdbscan-btcdyn-apbs-dbgrsdb-cyncts=
f-sae-idsup-idauth =

(config_pcie_release_sae_cync)  Version: 13.35.173 (r725742 CY) CRC: =

d513bd43 Date: Fri 2020-05-22 00:12:18 PDT Ucode Ver: 1184.1035 FWID =

01-93eb441a

So that should be a good hint. I can see for example =

cyfmac43455-sdio.bin is used by some RPi models, which should be pretty =

easy to get your hands on. Then download the relevant firmware/NVRAM/CLM =

blob files and stick them in the /lib/firmware path and try running one =

of the commands I showed upstairs. You should probably see something like:

brcmfmac: brcmf_feat_firmware_capabilities enabling feature: SAE

Without having my hands on the particular hardware it's hard for me to =

be sure, but I hope the above can point you in the right direction.

One more thing about FT: Support for FT is only relevant with roam =

offload enabled, as I mentioned in my last mail. But if you want to test =

that out then you can just verify with a wireless monitor whether it's =

actually doing FT when it roams. Cumbersome I know, but I must admit I =

haven't actually verified the functionality myself because of the =

existing trouble I had with roam offload + iwd.

Hope that helps!

[1] https://github.com/raspberrypi/firmware/issues/1403
[2] =

https://community.cypress.com/t5/Resource-Library/Cypress-Linux-WiFi-Driver=
-Release-FMAC-2020-09-25/ta-p/251089

> =

> It may actually be nice if brcmfmac allowed us to do =

> Authenticate/Associate without the offload.=C2=A0 I'm fairly certain 802.=
1X + =

> offload still has many surprises in store for us...
> =

>>
>> Personally I am a bit distrustful of the firmware, so it seemed like a
>> better use of my time to rest control of the entire roaming process away
> =

> Agreed.
> =

>> from the firmware and into the supplicant. The lack of FT support is
>> disappointing though, so perhaps I should have just worked on 4-Way
>> Handshake offload support for iwd instead. I'm not working on the FT
>> stuff these days but I'll follow up when I have some time.
> =

> That'd be great.
> =

> <snip>
> =

>>> Yeah not sure on this one. I guess we just need to make a policy
>>> decision here. If we always want to roam ourselves then we need a way
>>> to prevent the FW from roaming. If we want to allow both we need to
>>> disable our roaming logic for cards that do it on their own. Allowing
>>> FW roaming plus our own roaming logic just seems like a logic
>>> nightmare.
>>
>> The simple answer is that it never worked for me until I disabled
>> roaming in the firmware (roamoff=3D1).
> =

> May be academic at this point, but I'm still curious as to what actually =

> failed?

It's been a while now and I'm not in the office this week to test again, =

but what James wrote sounds pretty much like what I experienced:

> So as things stand now we get CMD_ROAM and then we just sit there and
> don't do anything. This results in the 4-way timing out and a
> disconnect.

I should note that I tested this before implementing the CQM stuff in =

brcmfmac, so roaming did not work at all to begin with. I.e. roam =

offloading resulted in the above scenario, and roam offloading disabled =

resulted in iwd not doing anything because it didn't get notified about =

RSSI (lack of CQM API).

Kind regards,
Alvin
--===============0628403858702534888==--

