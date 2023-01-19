Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D022F29
	for <iwd@lists.linux.dev>; Thu, 19 Jan 2023 23:32:56 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id d8so3984448pjc.3
        for <iwd@lists.linux.dev>; Thu, 19 Jan 2023 15:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ez2RLUUJ6ZMTnPC8U5Gg8kAe2dgDetXM1NxCiO/UbdI=;
        b=OF/qHKoiMZQCjP7sw9JL5Xfo4vMH3UlX78fb9Ih1cPXqWBeilJVkh8Mz/Rht83JpxP
         jKiJeZBnS7WdM7cQylvaEhO+uRinawfT+V7iZY6mgW3+krdHCgNGVyivDyX2VOfVFuK4
         shR8cY/ozvR2L+IWs0PUnPNcn9br6vGO0VftiXdwHo9uBOxqJX+6sSQPYUcSBU4iKs6V
         WmWGtXbsTmoRjSAYb4xEF6LZguFzfyCPDiKMW99NAe2hBvV9LhyUGk+jvR2IWXM6IrXa
         fhs6FdllEU7i2hlMkyx12AIxIKtMMx9L6NYONiadHOpVjvwnATeP69cyTyCrYQLmbZee
         TNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ez2RLUUJ6ZMTnPC8U5Gg8kAe2dgDetXM1NxCiO/UbdI=;
        b=thuxQtdcXVf7AzhI9xl6w56N6N1LtnVuTDsAKzZAqndwZVqsNNS0XWaoXj1JVk4hE0
         tlYXs6KeeaytDQZnM44m7YFAUnpTg20VJYPpob0X/qZyMojg6A5Rv77qBfWWkPN5LTkq
         Qy8ceD8gWDIHdQRaubHjE/KZ4dY4Z3v3zUTDhoc/tvYHqWFsUplu0vFFvc2wFuW9sC4Z
         bMuZdaJzvTUZeIzFl+zcul+vXybMUrY35vL226ihuHqiElnf0KWozYUO1mLf8mlMzF5k
         3huc8GAbRWW4CIXYldhHgI2EYLK/zF/xnIX9yOa0EcRM3nXKsn5QouMWhEZn76VR87Ei
         M4Qg==
X-Gm-Message-State: AFqh2kphM1XuFuJTGXX6YfN8MueOsocrpw9nk9Rz1nzvaOOSwCsJeZSF
	Y1IqDctJpHTR6TB2Jg+V40g=
X-Google-Smtp-Source: AMrXdXtbhFfWoS0QhKq6wu2oAZurn8EXF5zZz4184HrjMx3rlDtkOD41NGXnvvzeJvQoaPoD1Y999Q==
X-Received: by 2002:a17:90b:4b8a:b0:229:f5a2:80c9 with SMTP id lr10-20020a17090b4b8a00b00229f5a280c9mr2340040pjb.49.1674171175517;
        Thu, 19 Jan 2023 15:32:55 -0800 (PST)
Received: from [192.168.254.109] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q65-20020a17090a754700b002271b43e528sm185207pjk.33.2023.01.19.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:32:55 -0800 (PST)
Message-ID: <c102cee23294fe2d2ac42042eb31ba9d47ab783e.camel@gmail.com>
Subject: Re: IWD AP is not working with NXP (88W8997/88Q9098),  START_AP
 failed: -14
From: James Prestwood <prestwoj@gmail.com>
To: "Altous, Salahaldeen" <salahaldeen.altous@leica-camera.com>, 
	"iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Cc: Wigros Sun <weidong.sun@nxp.com>
Date: Thu, 19 Jan 2023 15:32:53 -0800
In-Reply-To: <65766f166225211bcd0ba039a824eff9a3f199cc.camel@leica-camera.com>
References: 
	<AM7PR01MB672451F58D20BA27F874E4B2ADC19@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
	 <AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
	 <c14b6ea2528aa47ddb8e0266128d39848aba7fef.camel@gmail.com>
	 <65766f166225211bcd0ba039a824eff9a3f199cc.camel@leica-camera.com>
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

On Thu, 2023-01-19 at 19:04 +0000, Altous, Salahaldeen wrote:
> Hi James,
> 
> Thanks for your quick reply, I am using kernel 4.19.124 with iwd-2.0.
> I
> have now tested with hostapd-2.9 and it works.

It looks like the iwmon logs for hostapd/uaputl aren't complete,
probably started iwmon too late. The IWD log is fine though.

If you can try again making to start iwmon before hostapd/uaputl that
would be great. You can search the logs afterwards and make sure you
see a message for "Start AP", something like:

"< Request: Start AP (0x0f) len 320 [ack]"

Thanks,
James

> 
> On Tue, 2023-01-17 at 10:28 -0800, James Prestwood wrote:
> > Hi,
> > 
> > On Tue, 2023-01-17 at 10:55 +0000, Altous, Salahaldeen wrote:
> > > Hi all,
> > > 
> > > I am testing now IWD-2.0 with an ublox module Jody-W377 (chipset
> > > NXP-
> > > Q9098) and using the open-source driver from NXP
> > > (mwifiex),station
> > > mode
> > > is working fine but I have problem with starting AP (CMD_RESP:
> > > cmd
> > > 0xb1
> > > error, result=0x1; START_AP failed: -14). I have in the past used
> > > the
> > > iwd with Qualcomm/Intel chipset with no problem. Does IWD support
> > > NXP-
> > > Q9098?
> > > attached you can find the log from iwd and iwctl
> > 
> > I did a quick look around in that driver for -EFAULT (the error
> > you're
> > seeing) and nothing jumped out at me.
> > 
> > I don't have any mwifiex hardware to try, but I don't see why it
> > shouldn't work. Have you tried hostapd? If hostapd works, then we
> > will
> > need a iwmon log from both hostapd (working) and IWD (not working).
> > Then we can compare what differs between the two.
> > 
> I have tested today again with hostapd and attahced you can find the
> working iwmon-log with hostapd (iwmon-hostapd-v2.9-AP-working-NXP-
> Q9098PCIe.txt) and the notworking iwmon-log from iwd (iwmon-log-iwd-
> 2.0-not-working.txt).
> 
> NXP have also a tool called uaputl.exe (internal authenticator) which
> can used used to config An Access point. I have also tested with this
> tool and I can start the AP (iwmon-log-uaputl-4.10-working.txt).
> 
> If you need special test with customized configrations for
> (iwd/hostapd/uaputl.ext) I will happy to provide you with the iwmon
> logs.
> 
> Regards,
> Salahaldeen
> 
> > Thanks,
> > James
> > 
> > > can you please check what is the needed information from wlan
> > > driver
> > > and is missing (not set) in mwifiex driver?
> > > 
> > > Also using 2 interfaces will fail when starting iwd and only one
> > > interface will be listed with device list
> > > # /usr/libexec/iwd -i mlan0 -i uap0 &
> > > Wireless daemon version 1.12
> > > station: Network configuration is disabled.
> > > Wiphy: 0, Name: mwiphy0
> > >           Permanent Address: 20:4e:f6:bb:0c:2f
> > >           Bands: 2.4 GHz 5 GHz
> > >           Ciphers: CCMP TKIP BIP
> > >           Supported iftypes: station ap p2p-client p2p-go
> > > Wiphy mwiphy0 will only use the default interface
> > > 
> > > [Note]
> > > If only starting iwd with uap0 , uap0 can be listed
> > > [iwd]# device list
> > >                                     Devices
> > > 
> > > 
> > > -----------------------------------------------------------------
> > > ------
> > > ---------
> > >   Name                  Address               Powered     Adapter
> > > 
> > > Mode
> > > -----------------------------------------------------------------
> > > ------
> > > ---------
> > >   uap0                  00:50:43:20:13:34     on          mwiphy0
> > > 
> > > ap
> > > 
> > > 
> > > Best Regards,
> > > Salahaldeen
> > > 
> > > --
> > > Mit freundlichen Gruessen / kind regards
> > > 
> > > M.Sc Salahaldeen Altous
> > > Senior Embedded Linux Developer
> > > Leica Camera AG | Registergericht | District Court of Wetzlar:
> > > HRB966
> > > Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm
> > > (CFO)
> > > Aufsichtsratsvorsitzender | Chairman of the Supervisory Board:
> > > Dr.
> > > Andreas Kaufmann
> > > This message may contain confidential and privileged information.
> > > If it
> > > has been sent to you in error, please notify the sender
> > > immediately
> > > by
> > > replying to the message and please delete it from your computer.
> > 
> > 
> Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
> Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm
> (CFO)
> Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> Andreas Kaufmann
> 
> This message may contain confidential and privileged information. If
> it has been sent to you in error, please notify the sender
> immediately by replying to the message and please delete it from your
> computer.


