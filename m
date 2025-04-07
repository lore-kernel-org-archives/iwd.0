Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA91FAC5A
	for <iwd@lists.linux.dev>; Mon,  7 Apr 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040154; cv=none; b=mvUfCdLiSYNlPSAwJxSTjeMaKQmbfPqDfCnmiopGJ/xo6iBKSk1ug8hYeBofr6EQ3luVOWIIg2FbBdz3naPloQNiTRR9RiRj7sq/jKXYKvlAgivlleO/DEQcOnwKbBpCDWK7BwMuSCpjE9+zsGSgydyxeK3i1WyqaAhxUtLa294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040154; c=relaxed/simple;
	bh=UtAgf5csCQEeqT5RfI+2NwmdAcSTBcxJnLJNQzc/L8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjL4pEUZwtOeZ/y/0HWZfqRSmapV16OhdtyDlVO9yUrQR07UKcj0wBmuMd1r1dh+f55rnfJeXLi7Q0VmokgsV2dCUwEnrr7oNsNtGmbPm2h9EB8yMcOE5qLcjsrj3YRIQQdrqfFFSfgpuA+ZsC80T7StJTfQUo4nUFOk9ICR8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0Uw4feO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Uw4feO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301e05b90caso4249730a91.2
        for <iwd@lists.linux.dev>; Mon, 07 Apr 2025 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744040151; x=1744644951; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFKTlyYm8N9E+/bPxLWN2QAHS7QEq16UAnFxu5+oxZw=;
        b=R0Uw4feO+2IGFUZPn86VGo8ZrJViLRrUhYo7rEug6OZfsRXHPSgtaYmYdAbRscSAv6
         Mx6sDlkkkcyQ3iAvPPjmamtvFPydWM0Q1AhXAhLNmRXJkn98GvQbeuGoCEhCM2mRw2BK
         W3eTj/+XZ0CoPR8fcDtFOCsIqjTiHVFtBHt9iGayjBFtC2Rc6J0VIM1eKblh3lPe1Mt1
         s8S0PqKe6ZXhZxILyuAGa2M81n4BTqmkFgRwvodq8yowe5eH6Uwi9lNnGtYmBS1Vv2hc
         Xo2bBxxPcAPieMdb1aAkmIgIiZI05XeBmmr91HehXKbwe2yRipHt6yfK92ErIEQu+Eb8
         npbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744040151; x=1744644951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFKTlyYm8N9E+/bPxLWN2QAHS7QEq16UAnFxu5+oxZw=;
        b=aU2ESnnq3udBSqBlRbGhgio+tK/HsLteHiw83YhuGNOSzaN50t78svAD0cLS2I1qfQ
         Ym3CZFAipidvl3GFnolzh4f3sMQ+gc80RgCEow7+pFdU5hlfb4j8bPg8osiwgR2c0FRD
         pyIrIV9nbgyHRc6vxzGwCS92mcOMjEc+oNtdPxLAoaZT3pqBYZrhTkvZDkQKQnLgwi6E
         Wgm+Kny6bzmkX4c29JTyXMjyAOwD0doLERP051VmhMJjgWbZJM5eFU4qJVC/+LC0KeA4
         VprbpwbcWMoH9zv2G0TCAN57CM2xDtH7wV8oqEuH9l+0WyI0gnXnnlyUjtElZvpBT8KS
         J+Uw==
X-Gm-Message-State: AOJu0YyVhie9RAw80h03ydMRyK86HbXBbaKrYcHVOKg+zzvu8CBwzmmS
	DIHMPd4wI0GaFQqOE4nB4u01AQVDwIOum1CChpukVBVKWguKZ+JriC8BxkZBr96W+BDL9x9bPEv
	dUTHfN9OZ2Oar6NAAXT0zh/6xOKk=
X-Gm-Gg: ASbGnctKLjBNdHB/H5gq/6u443ZbkpgtQ61L9uQutlVYizMhRH0l4gMDo4opUIgfJIF
	ysCU+SK+uZ5Y3Z7Xkh3ja4RHY8wbWyFPQEPqlhbs6SGU2wQy9uqvpHUE3bh8J+shuDmYi7Z7P2j
	NAtvq2ygjNycgERp/7ZGsYMYbm/GaWuEgj5y1ORLQ=
X-Google-Smtp-Source: AGHT+IFErF13CtccSX2mTD7aTTAHNmQsuCGNula8Y6Dc4lijdW1K37ihs26puMzwxd0yaYdYX4SR8CImkO7WbrBP5tg=
X-Received: by 2002:a17:90b:2710:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-306a47f3003mr18090643a91.21.1744040151310; Mon, 07 Apr 2025
 08:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
 <f436a083-5e70-46f3-841d-c59c10c6adf0@gmail.com>
In-Reply-To: <f436a083-5e70-46f3-841d-c59c10c6adf0@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 7 Apr 2025 10:35:40 -0500
X-Gm-Features: ATxdqUHzKv0iiS02CmiGfqTLJxy7KPdX3bDj7zbFj85siPC1wQla3M31HEe6VTc
Message-ID: <CAG17S_N=DnnnLY+hGiqQCfopr1ZngCW0T4_H0+yyP9Z8DiqzhQ@mail.gmail.com>
Subject: Re: strange behavior with synthetic ap0
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:57=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi Keith,
>
> On 4/6/25 10:48 PM, KeithG wrote:
> > I have been messing around with a synthetic ap0 to set up AP mode up
> > on my brcmfmac equipped Pis. This attempt is on a Pi4 with the 43455
> > chip, but I've recently seen this with other Pis.
> > What I do to set up the ap0 is this:
> >
> > iw dev wlan0 interface add ap0 type __ap
> > ip link set dev ap0 address d8:3a:dd:60:a3:cg
> > systemctl reload-or-restart iwd
> > iwctl device ap0 set-property Mode ap
> > iwctl ap ap0 start-profile test
> >
> > Then from connmanctl, I attempt to connect to a known SSID. If ap0 is
> > up, I cannot connect to the SSID with the correct password. If I take
> > ap0 down 'iw ap0 del' and try again, it connects. This is with either
> > iwd controlling the AP or hostapd. It doesn't matter which is
> > controlling the ap0, if it is up, I always get a failed password if
> > ap0 is up. This used to work and seems to have regressed.
> >
> > When I enable debug for iwd, this is what it looks like when I attempt
> > to connect to a known SSID when the ap0 is up.
> > Apr 06 16:36:09 pi4 connmand[138138]: Interface wlan0 [ wifi ] state
> > is association
> > Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_connect()
> > Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_connect_psk()
> > ask_passphrase: true
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/agent.c:agent_request_passphrase() agent 0x5582c692f0 owner
> > :1.5673 path /net/connman/iwd_agent
> > Apr 06 16:36:09 pi4 iwd[158609]: src/agent.c:agent_send_next_request()
> > send request to :1.5673 /net/connman/iwd_agent
> > Apr 06 16:36:09 pi4 iwd[158609]: src/agent.c:agent_receive_reply()
> > agent 0x5582c692f0 request id 117
> > Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:passphrase_callback() re=
sult 0
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/network.c:network_generate_sae_pt() Generating PT for Group 19
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/network.c:network_generate_sae_pt() Generating PT for Group 20
> > Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_insert()
> > Inserting work item 6
> > Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_next()
> > Starting work item 6
> > Apr 06 16:36:09 pi4 iwd[158609]: event: connect-info, ssid: keithS23,
> > bss: 56:ba:50:be:c8:62, signal: -69, load: 0/255
> > Apr 06 16:36:09 pi4 iwd[158609]: event: state, old: autoconnect_full,
> > new: connecting
> > Apr 06 16:36:09 pi4 iwd[158609]: src/scan.c:scan_periodic_stop()
> > Stopping periodic scan for wdev 1
> > Apr 06 16:36:09 pi4 connmand[138138]: Interface wlan0 [ wifi ] state
> > is configuration
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Connect(46)
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> > aborting and ignore_connect_event not set, proceed
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> > expect_connect_failure not set, proceed
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:parse_request_ies()
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> > Request / Response IEs parsed
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_get_oci()
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {RX} 335 packets 72684 byte=
s
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {TX} 1615 packets 216925 by=
tes
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {update} flags 102403 <UP,L=
OWER_UP>
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 address
> > DC:A6:32:B4:50:CF mtu 1500
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3
> > operstate 5 <DORMANT>
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_get_oci_cb()
> > Obtained OCI: freq: 5785, width: 3, center1: 5775, center2: 0
> > Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_start()
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/station.c:station_handshake_event() Handshaking
> > Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_handle_ptk_1_of_4() =
ifindex=3D3
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_handle_ptk_3_of_4() =
ifindex=3D3
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_gtk()
> > ifindex=3D3 key_idx=3D1
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/station.c:station_handshake_event() Setting keys
> > Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_sync_settings()
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_tk()
> > ifindex=3D3 key_idx=3D0
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_rekey_offload(=
) 3
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/netdev.c:netdev_new_group_key_cb() ifindex: 3, err: 0
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> > ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
> > Apr 06 16:36:09 pi4 iwd[158609]: hardware_rekey not supported
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_station_cb()
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> > ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> > nhs->complete: 0
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> > Invoking handshake_event()
> > Apr 06 16:36:09 pi4 iwd[158609]:
> > src/handshake.c:handshake_state_cache_pmksa() No PMKSA for
> > 56:ba:50:be:c8:62
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_ok()
> > Apr 06 16:36:09 pi4 iwd[158609]: src/station.c:station_connect_cb() 3, =
result: 0
> > Apr 06 16:36:09 pi4 iwd[158609]: src/station.c:station_connect_ok()
> > Apr 06 16:36:09 pi4 iwd[158609]: event: state, old: connecting, new:
> > connecting (netconfig)
>
> So the connection succeeds...
>
> > Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_done()
> > Work item 6 done
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {RX} 336 packets 72839 byte=
s
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {TX} 1619 packets 217577 by=
tes
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {update} flags 102467
> > <UP,RUNNING,LOWER_UP>
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 address
> > DC:A6:32:B4:50:CF mtu 1500
> > Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 operstate=
 6 <UP>
> > Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Disconnect(48)
> > Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_disconnect_event()
> > Apr 06 16:36:19 pi4 iwd[158609]: Received Deauthentication event,
> > reason: 0, from_ap: false
> > Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_disconnect_event=
() 3
>
> But the kernel / firmware disconnects us.  There may be a limitation with=
 this
> hardware where the AP/STA must operate on the same channel.  Have you tri=
ed
> setting the AP interface to operate on the same frequency as the AP you'r=
e
> trying to connect to?
>
> > Apr 06 16:36:19 pi4 iwd[158609]: event: disconnect-info, reason: 0
>
> Reason given is 'unspecified'...
>
> > Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_disassociated() =
3
> > Apr 06 16:36:19 pi4 iwd[158609]:
> > src/station.c:station_reset_connection_state() 3
> > Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_roam_state_clear=
() 3
> > Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {RX} 336 packets 72839 byte=
s
> > Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {TX} 1635 packets 220020 by=
tes
> > Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {update} flags 36867 <UP>
> > Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {newlink} index 3 address
> > DC:A6:32:B4:50:CF mtu 1500
> > Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {newlink} index 3 operstate=
 2 <DOWN>
> > Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: connecting
> > (netconfig), new: disconnected
> > Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: disconnected, new:
> > autoconnect_quick
> > Apr 06 16:36:19 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_insert()
> > Inserting work item 7
> > Apr 06 16:36:19 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_next()
> > Starting work item 7
> > Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:19 pi4 iwd[158609]: src/scan.c:scan_notify() Scan
> > notification Trigger Scan(33)
> > Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Apr 06 16:36:19 pi4 iwd[158609]: src/scan.c:scan_request_triggered()
> > Passive scan triggered for wdev 1
> > Apr 06 16:36:19 pi4 iwd[158609]:
> > src/station.c:station_quick_scan_triggered() Quick scan triggered for
> > wlan0
> > Apr 06 16:36:19 pi4 connmand[138138]: Interface wlan0 [ wifi ] error
> > "connect-failed"
> > Apr 06 16:36:19 pi4 connmand[138138]: Interface wlan0 [ wifi ] state is=
 failure
> > Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_dbus_disconnect(=
)
> > Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: autoconnect_quick,
> > new: disconnected
> >
> > It is strange that it reports a bad password. Is this a brcmfmac
> > driver issue or a firmware issue?
>
> That is an assumption iwd makes since there's no sensible error informati=
on
> about the disconnect.
>
> >
> > Keith
> >
>
> Regards,
> -Denis

Denis,

It succeeds, but never gets an IP before it disconnects, I noticed.

How do I ensure it is on the same frequency? I would think that I
would have to change the freq to whatever the freq of the SSID I am
connecting to. The process would then have to be: query the SSID for a
freq then stop and restart the AP... Wouldn't this disconnect the AP0
from whatever is connected to it?

A bit oif background, I am trying to write a python script to do a bit
of magic. We use connman as the front end and iwd as the wifi
controller and there is no real good way to have this headless,
embedded device always allow a connection, so I am trying to get a
python script to monitor dbus and when it looses its wlan0 connection
to start ap0 and allow a connection that way unless it 'sees' an SSID
it already recognizes. In that case, I am having is down the ap0 then
connect to the SSID on wlan0. That works, but it must be serial: shut
down ap0 before connecting to SSID on wlan0 or it complains that the
password is bad.

I may be mistaken, but I think that a year or so ago (kernel 5.x or
6.1) it used to actually allow both simultaneously.

I built a kernel last night so that I nave nlmon available to query
what is being passed if that is needed.

Keith
