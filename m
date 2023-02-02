Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C78F54
	for <iwd@lists.linux.dev>; Thu,  2 Feb 2023 18:19:26 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d3so2706284plr.10
        for <iwd@lists.linux.dev>; Thu, 02 Feb 2023 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FSplo2qgQEjdaAXKP4HMza6Bcj0qm45tx9wfV6e/8k=;
        b=g2NEr2kaE0M0/VIfFbWI1JbaceKNdX8hx4aHnuKr6O1VMQ6AqgVPDAM6rH/fquioXi
         woCSxWnhzkiSluBboRvsCDSBIsTN7QqDBI+FQDeEldC/kLtw/XWNpzIkNzl3FgrTsilj
         uzzdZLUV7M3X2x+KlXneysFJel0cFeC9uhQAxdqJ4ik5kuPiHt5NH2ESZSiadIl3owvy
         /VdnbYK0/XRYVbsTkapq4CHuQkjrxLEjSwpkKx8P3L7OCxnlFFCeKl9GIFve1c86hNZJ
         o+8O22QzosehP7Va5qyFgigzVKhv7YVHidURKlaP9mI2txcto2OpLs+38LF0qE2JLNFm
         rp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FSplo2qgQEjdaAXKP4HMza6Bcj0qm45tx9wfV6e/8k=;
        b=d6SFMed3PS5W8ViLoTFeP253NBhNpSTDgtthBQM6focOSRE3Il6/YQzxjEDjXqVSGM
         kr+uumwixp83NAo586KkbC11kDruPOJS7sGpmlMi13mkz2zxzxuailkGO1675BG4qb98
         5pa3eCjJMJ63grWPCzw07LrOIe72daWhlbW9TTxuUeAgl4BUHkR+493vxTc/0ch8epBl
         o6aJSAGRmh/C7K9wdSwHs8ya7gdfnF9ZYptaKLZapwhB307vXVSrJbXkh58DV1+VQvxz
         Cs9u6n/DW6HWzEMSYXH+XUB5iPnsJIr8xLwr2skScQrp5Mk+tMZKiogiVnV7j5CeCRSw
         pNpA==
X-Gm-Message-State: AO0yUKV0rEXNQWjz7DpZqG7GpuXKZBRL2zGhCyVGCiom12NZSqXGUZwV
	NU6Dir2Y74/UX7bDI+XMc5M7omvQyd4=
X-Google-Smtp-Source: AK7set91Q+DfXBCS9ljLzEmhe8OCcSPMbQbQse6m+I5D4okDHD6mABJcnUIurYE9ykUJQwi5idSSPw==
X-Received: by 2002:a17:902:d2c6:b0:189:6ab3:9e64 with SMTP id n6-20020a170902d2c600b001896ab39e64mr9357749plc.34.1675361966178;
        Thu, 02 Feb 2023 10:19:26 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b0019324fbec59sm14161584plp.41.2023.02.02.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:19:25 -0800 (PST)
Message-ID: <6ec3035e63a20ece71befbf0c20abd270666338c.camel@gmail.com>
Subject: Re: IWD AP is not working with NXP (88W8997/88Q9098),  START_AP
 failed: -14
From: James Prestwood <prestwoj@gmail.com>
To: "Altous, Salahaldeen" <salahaldeen.altous@leica-camera.com>, 
	"iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Cc: Wigros Sun <weidong.sun@nxp.com>
Date: Thu, 02 Feb 2023 10:19:25 -0800
In-Reply-To: <f6712e2aecc811f8381fce838d9f157166765315.camel@leica-camera.com>
References: 
	<AM7PR01MB672451F58D20BA27F874E4B2ADC19@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
	 <AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
	 <c14b6ea2528aa47ddb8e0266128d39848aba7fef.camel@gmail.com>
	 <65766f166225211bcd0ba039a824eff9a3f199cc.camel@leica-camera.com>
	 <c102cee23294fe2d2ac42042eb31ba9d47ab783e.camel@gmail.com>
	 <8ae7873bc670ce05cb1f6874171b0b94afda3f49.camel@leica-camera.com>
	 <f6712e2aecc811f8381fce838d9f157166765315.camel@leica-camera.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 2023-02-02 at 12:05 +0000, Altous, Salahaldeen wrote:
> 
> Hi James,
> 
> do you have any new finding regarding hostapd vs iwd-ap logs.

Sorry for the delay, I was out the last few days.

I suspect its got something to do the probe response contents, since
this appears to be a full mac card. From the iwmon logs I don't see
anything wrong, the elements/lengths match up and don't indicate we're
overrunning a buffer. You could try this diff and see if Start AP is
successful:

diff --git a/src/ap.c b/src/ap.c
index b51befe4..28353d88 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2828,7 +2828,7 @@ static struct l_genl_msg
*ap_build_cmd_start_ap(struct ap_state *ap)
                l_genl_msg_append_attr(cmd, NL80211_ATTR_CENTER_FREQ1,
4,
                                        &ap-
>chandef.center1_frequency);
 
-       if (wiphy_supports_probe_resp_offload(wiphy)) {
+       if (0) {
                uint8_t probe_resp[head_len + tail_len];
                uint8_t *ptr = probe_resp;


With this AP mode is unlikely to work correctly, but at least it will
tell us its something to do with the probe response attribute.

Thanks,
James


> 
> Regards,
> Salahaldeen
> 
> On Fri, 2023-01-20 at 18:10 +0000, Altous, Salahaldeen wrote:
> > Hi,
> > 
> > On Thu, 2023-01-19 at 15:32 -0800, James Prestwood wrote:
> > > Hi,
> > > 
> > > On Thu, 2023-01-19 at 19:04 +0000, Altous, Salahaldeen wrote:
> > > > Hi James,
> > > > 
> > > > Thanks for your quick reply, I am using kernel 4.19.124 with iwd-
> > > > 2.0.
> > > > I
> > > > have now tested with hostapd-2.9 and it works.
> > > 
> > > It looks like the iwmon logs for hostapd/uaputl aren't complete,
> > > probably started iwmon too late. The IWD log is fine though.
> > > 
> > > If you can try again making to start iwmon before hostapd/uaputl
> > > that
> > > would be great. You can search the logs afterwards and make sure
> > > you
> > > see a message for "Start AP", something like:
> > > 
> > > "< Request: Start AP (0x0f) len 320 [ack]"
> > > 
> > > Thanks,
> > > James
> > 
> > I have captured the logs again for hostapd. last time I have made a
> > mistake and after I started uaputl, I have stopped it and then used
> > hostapd. I have now seen a strange behavior, when starting uaptl
> > there
> > will be NO iwmon logs!! I have again attached the logs from hostapd
> > (iwmon-hostapd-v2.9-AP-working-NXP-Q9098PCIe-20.01.2023.txt)
> > 
> > Response: Start AP (0x0f) len 4 [0x100]
> > 
> > 
> > Also the start sequence logs for uaputl(uaputl-output.txt).
> > sh-5.0# ./uaputl.exe -i uap0 bss_start
> > dev_name:uap0
> > channel=149
> > Enabling 11d for 11h operation and setting country code to DE
> > BSS start successful!
> > [  987.974829] IPv6: ADDRCONF(NETDEV_CHANGE): uap0: link becomes
> > ready
> > 
> > Regards,
> > Salahaldeen
> > 
> > > > On Tue, 2023-01-17 at 10:28 -0800, James Prestwood wrote:
> > > > > Hi,
> > > > > 
> > > > > On Tue, 2023-01-17 at 10:55 +0000, Altous, Salahaldeen wrote:
> > > > > > Hi all,
> > > > > > 
> > > > > > I am testing now IWD-2.0 with an ublox module Jody-W377
> > > > > > (chipset
> > > > > > NXP-
> > > > > > Q9098) and using the open-source driver from NXP
> > > > > > (mwifiex),station
> > > > > > mode
> > > > > > is working fine but I have problem with starting AP
> > > > > > (CMD_RESP:
> > > > > > cmd
> > > > > > 0xb1
> > > > > > error, result=0x1; START_AP failed: -14). I have in the past
> > > > > > used
> > > > > > the
> > > > > > iwd with Qualcomm/Intel chipset with no problem. Does IWD
> > > > > > support
> > > > > > NXP-
> > > > > > Q9098?
> > > > > > attached you can find the log from iwd and iwctl
> > > > > 
> > > > > I did a quick look around in that driver for -EFAULT (the error
> > > > > you're
> > > > > seeing) and nothing jumped out at me.
> > > > > 
> > > > > I don't have any mwifiex hardware to try, but I don't see why
> > > > > it
> > > > > shouldn't work. Have you tried hostapd? If hostapd works, then
> > > > > we
> > > > > will
> > > > > need a iwmon log from both hostapd (working) and IWD (not
> > > > > working).
> > > > > Then we can compare what differs between the two.
> > > > > 
> > > > I have tested today again with hostapd and attahced you can find
> > > > the
> > > > working iwmon-log with hostapd (iwmon-hostapd-v2.9-AP-working-
> > > > NXP-
> > > > Q9098PCIe.txt) and the notworking iwmon-log from iwd (iwmon-log-
> > > > iwd-
> > > > 2.0-not-working.txt).
> > > > 
> > > > NXP have also a tool called uaputl.exe (internal authenticator)
> > > > which
> > > > can used used to config An Access point. I have also tested with
> > > > this
> > > > tool and I can start the AP (iwmon-log-uaputl-4.10-working.txt).
> > > > 
> > > > If you need special test with customized configrations for
> > > > (iwd/hostapd/uaputl.ext) I will happy to provide you with the
> > > > iwmon
> > > > logs.
> > > > 
> > > > Regards,
> > > > Salahaldeen
> > > > 
> > > > > Thanks,
> > > > > James
> > > > > 
> > > > > > can you please check what is the needed information from wlan
> > > > > > driver
> > > > > > and is missing (not set) in mwifiex driver?
> > > > > > 
> > > > > > Also using 2 interfaces will fail when starting iwd and only
> > > > > > one
> > > > > > interface will be listed with device list
> > > > > > # /usr/libexec/iwd -i mlan0 -i uap0 &
> > > > > > Wireless daemon version 1.12
> > > > > > station: Network configuration is disabled.
> > > > > > Wiphy: 0, Name: mwiphy0
> > > > > >           Permanent Address: 20:4e:f6:bb:0c:2f
> > > > > >           Bands: 2.4 GHz 5 GHz
> > > > > >           Ciphers: CCMP TKIP BIP
> > > > > >           Supported iftypes: station ap p2p-client p2p-go
> > > > > > Wiphy mwiphy0 will only use the default interface
> > > > > > 
> > > > > > [Note]
> > > > > > If only starting iwd with uap0 , uap0 can be listed
> > > > > > [iwd]# device list
> > > > > >                                     Devices
> > > > > > 
> > > > > > 
> > > > > > -------------------------------------------------------------
> > > > > > ----
> > > > > > ------
> > > > > > ---------
> > > > > >   Name                  Address               Powered
> > > > > > Adapter
> > > > > > 
> > > > > > Mode
> > > > > > -------------------------------------------------------------
> > > > > > ----
> > > > > > ------
> > > > > > ---------
> > > > > >   uap0                  00:50:43:20:13:34     on
> > > > > > mwiphy0
> > > > > > 
> > > > > > ap
> > > > > > 
> > > > > > 
> > > > > > Best Regards,
> > > > > > Salahaldeen
> > > > > > 
> > > > > > --
> > > > > > Mit freundlichen Gruessen / kind regards
> > > > > > 
> > > > > > M.Sc Salahaldeen Altous
> > > > > > Senior Embedded Linux Developer
> > > > > > Leica Camera AG | Registergericht | District Court of
> > > > > > Wetzlar:
> > > > > > HRB966
> > > > > > Vorstand | Executive Board: Matthias Harsch (CEO) I Michael
> > > > > > Grimm
> > > > > > (CFO)
> > > > > > Aufsichtsratsvorsitzender | Chairman of the Supervisory
> > > > > > Board:
> > > > > > Dr.
> > > > > > Andreas Kaufmann
> > > > > > This message may contain confidential and privileged
> > > > > > information.
> > > > > > If it
> > > > > > has been sent to you in error, please notify the sender
> > > > > > immediately
> > > > > > by
> > > > > > replying to the message and please delete it from your
> > > > > > computer.
> > > > Leica Camera AG | Registergericht | District Court of Wetzlar:
> > > > HRB966
> > > > Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm
> > > > (CFO)
> > > > Aufsichtsratsvorsitzender | Chairman of the Supervisory Board:
> > > > Dr.
> > > > Andreas Kaufmann
> > > > 
> > > > This message may contain confidential and privileged information.
> > > > If
> > > > it has been sent to you in error, please notify the sender
> > > > immediately by replying to the message and please delete it from
> > > > your
> > > > computer.
> > Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
> > Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm
> > (CFO)
> > Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> > Andreas Kaufmann
> > 
> > This message may contain confidential and privileged information. If
> > it has been sent to you in error, please notify the sender
> > immediately by replying to the message and please delete it from your
> > computer.
> Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
> Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm (CFO)
> Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> Andreas Kaufmann
> 
> This message may contain confidential and privileged information. If it
> has been sent to you in error, please notify the sender immediately by
> replying to the message and please delete it from your computer.


