Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9211E835F
	for <iwd@lists.linux.dev>; Mon,  7 Apr 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037839; cv=none; b=Z6/MzYLxxq1vQ6G/wiTkPiC03ABOufFZzXjaQIQ1hqXZykUnURiqFMx2l96RVU+h3cexoFQj+2hBg2JW5LgRnl27gJFMIUYGqHao5IHMNQwQVkafToOyGO2q4yD8W+M6XgEf+S2AByyTkhHg/Ac5/e6RD91hhiTjDJa3pyp3KOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037839; c=relaxed/simple;
	bh=yI0xAQLTzmxz53jdsWXYipg7tqek0YhOncC0BAJv6gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hBEqtftqOc0h5w1plgt3VA5pZLkEZ/jznH7ccvEz7ALe97SESm5lbH2oKMkdKZOyYts5IT5ynCUm97OQLR0oXUGv5aTMup3kWK21GpF0TT+rjYeXkVHGSpFUyIp++4O1o1NUR8yKjEuf6PbsPknfTO7uvsLeRU2Qsb3bfHtdToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmzcLI3k; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmzcLI3k"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72b82c8230aso990364a34.2
        for <iwd@lists.linux.dev>; Mon, 07 Apr 2025 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744037836; x=1744642636; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLquTwPMO4FocGn8Ik2dgqZO5I9LR/uGvHEqQvvrIRw=;
        b=KmzcLI3kqVLl8a7Kbd1/TV9t5+TKFN5hlSOxErrcTayhmLuLAVWOnOB++TDn/s8WRX
         GllGTnHDk1Rgx0w8jy95pTqeXV6EKSpT0S9WguMiCQSvedvL63rTALRWv2cIeWWzpC83
         P+u/v2b0gI1xszX4X0o9UUpIA/vJl9BU2nROjaiCc14mhG3ctODKlxBxR/OB0MEut6ly
         3GfBLl35zrGquoWh+8QbKkf0V3gIqv1HtFFcom8oqwiQf2vzHNeWoNsEsmrpuqOzMpSJ
         KeFyK/qX7ESZtUe7Q6fEnTYDcff2JEHDewhl5rMHiPaJ9Xx5EbAXrVgWbnDRZ+k9rQtj
         KpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037836; x=1744642636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLquTwPMO4FocGn8Ik2dgqZO5I9LR/uGvHEqQvvrIRw=;
        b=Vo+Sw0+OfBWkhJvmvSY2x6m2cPNLqGA03LTsslF64IMOz/3osBjHr7B8Qq374y9SfF
         VhA9Qj8B0dKPNhupoTgQjpa+AaXgz4JNsiVGZeUMmioMnDYwCxqTzmVS/nBMNvJTso9j
         wtP+TPnmvKXoN6SN35JnQPsEIBkgmDgqIq4ZbKciPYBcnZeQnd6HqJmdO8v/mTj6WW9h
         eq9DeSYdOx/cSdm3FiA9/OxHMx63l6/zoEQgZ6fAMgzK6RFV6hGMr3ge7Xc/dLqvWPef
         royfFoSRSuSHhemKH9h8EO3aAFjC39PxHx7mjyHAeUgu0y8k8TU2+JWT9O5n4tvR2iCw
         o7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX0H0OAwGVYY3Cu6rzJhbKPPfG2PBz9UpsDTtjeS2zx2RoymaB1dDI4LlB3czcxa4ypul4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yymf7rj50wEndAvMSAtJO4DOyBLxSQtkwNJ0tWsHnDu5z2+Ji8m
	CbHOuehbGq+oNxwGNDdAGnz76lCktsQry5N70acUoXjMoKq6gIc5KL3c3g==
X-Gm-Gg: ASbGncsbrCxM9ee++0jO/bI9mFjo9/z5QuGZ4WYrvWg3aLMH95MZoIAVICohnq2Xj3g
	fP7qtBYD4Im/HCLhVY9Ovh6aE6wxqKkAdWi/+NmtK2YPiTsi8mD4FFPmGH9+pnSi+A4E13hFTct
	vpSgG+G52zGXBv6UuOVRD21HKnhwnPJISeqXuKJhujVlrTpzVucqCeOCBTZ+8oEZRtYL0IipyfQ
	JnXGU2kERq0MS1AonCp5XHMxiXe1ecSjfJMPaWbNa5ONtX6myb/f6cxlygLBYZ4NVG4bbu4YZHT
	Dx9L2T7sThyYGxTDfgRkS9IOKvU2bP8NCAAQMOcOcIa7tU9Dgkw5dVb7PKmf4SoF1FXh9aBzKUI
	Ex0DIT+jhPA==
X-Google-Smtp-Source: AGHT+IEBqsX1qSB7T0KV37ykT5xDZ96zyfNf/FkDMh5y7mV0tjPee7FG4KZyOUJa57DVV9OWp5azGw==
X-Received: by 2002:a05:6830:4982:b0:72b:9a2e:7828 with SMTP id 46e09a7af769-72e40ec214cmr6327993a34.28.1744037835961;
        Mon, 07 Apr 2025 07:57:15 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72e3043cc8esm1725548a34.0.2025.04.07.07.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:57:15 -0700 (PDT)
Message-ID: <f436a083-5e70-46f3-841d-c59c10c6adf0@gmail.com>
Date: Mon, 7 Apr 2025 09:57:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strange behavior with synthetic ap0
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 4/6/25 10:48 PM, KeithG wrote:
> I have been messing around with a synthetic ap0 to set up AP mode up
> on my brcmfmac equipped Pis. This attempt is on a Pi4 with the 43455
> chip, but I've recently seen this with other Pis.
> What I do to set up the ap0 is this:
> 
> iw dev wlan0 interface add ap0 type __ap
> ip link set dev ap0 address d8:3a:dd:60:a3:cg
> systemctl reload-or-restart iwd
> iwctl device ap0 set-property Mode ap
> iwctl ap ap0 start-profile test
> 
> Then from connmanctl, I attempt to connect to a known SSID. If ap0 is
> up, I cannot connect to the SSID with the correct password. If I take
> ap0 down 'iw ap0 del' and try again, it connects. This is with either
> iwd controlling the AP or hostapd. It doesn't matter which is
> controlling the ap0, if it is up, I always get a failed password if
> ap0 is up. This used to work and seems to have regressed.
> 
> When I enable debug for iwd, this is what it looks like when I attempt
> to connect to a known SSID when the ap0 is up.
> Apr 06 16:36:09 pi4 connmand[138138]: Interface wlan0 [ wifi ] state
> is association
> Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_connect()
> Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_connect_psk()
> ask_passphrase: true
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/agent.c:agent_request_passphrase() agent 0x5582c692f0 owner
> :1.5673 path /net/connman/iwd_agent
> Apr 06 16:36:09 pi4 iwd[158609]: src/agent.c:agent_send_next_request()
> send request to :1.5673 /net/connman/iwd_agent
> Apr 06 16:36:09 pi4 iwd[158609]: src/agent.c:agent_receive_reply()
> agent 0x5582c692f0 request id 117
> Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:passphrase_callback() result 0
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 19
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 20
> Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_insert()
> Inserting work item 6
> Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 6
> Apr 06 16:36:09 pi4 iwd[158609]: event: connect-info, ssid: keithS23,
> bss: 56:ba:50:be:c8:62, signal: -69, load: 0/255
> Apr 06 16:36:09 pi4 iwd[158609]: event: state, old: autoconnect_full,
> new: connecting
> Apr 06 16:36:09 pi4 iwd[158609]: src/scan.c:scan_periodic_stop()
> Stopping periodic scan for wdev 1
> Apr 06 16:36:09 pi4 connmand[138138]: Interface wlan0 [ wifi ] state
> is configuration
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_mlme_notify()
> MLME notification Connect(46)
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> aborting and ignore_connect_event not set, proceed
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> expect_connect_failure not set, proceed
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:parse_request_ies()
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
> Request / Response IEs parsed
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_get_oci()
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {RX} 335 packets 72684 bytes
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {TX} 1615 packets 216925 bytes
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {update} flags 102403 <UP,LOWER_UP>
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 address
> DC:A6:32:B4:50:CF mtu 1500
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3
> operstate 5 <DORMANT>
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_get_oci_cb()
> Obtained OCI: freq: 5785, width: 3, center1: 5775, center2: 0
> Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_start()
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/station.c:station_handshake_event() Handshaking
> Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_gtk()
> ifindex=3 key_idx=1
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/station.c:station_handshake_event() Setting keys
> Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_sync_settings()
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_tk()
> ifindex=3 key_idx=0
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_rekey_offload() 3
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/netdev.c:netdev_new_group_key_cb() ifindex: 3, err: 0
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
> Apr 06 16:36:09 pi4 iwd[158609]: hardware_rekey not supported
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_station_cb()
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> nhs->complete: 0
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
> Invoking handshake_event()
> Apr 06 16:36:09 pi4 iwd[158609]:
> src/handshake.c:handshake_state_cache_pmksa() No PMKSA for
> 56:ba:50:be:c8:62
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_ok()
> Apr 06 16:36:09 pi4 iwd[158609]: src/station.c:station_connect_cb() 3, result: 0
> Apr 06 16:36:09 pi4 iwd[158609]: src/station.c:station_connect_ok()
> Apr 06 16:36:09 pi4 iwd[158609]: event: state, old: connecting, new:
> connecting (netconfig)

So the connection succeeds...

> Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_done()
> Work item 6 done
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {RX} 336 packets 72839 bytes
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {TX} 1619 packets 217577 bytes
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {update} flags 102467
> <UP,RUNNING,LOWER_UP>
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 address
> DC:A6:32:B4:50:CF mtu 1500
> Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 operstate 6 <UP>
> Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_mlme_notify()
> MLME notification Disconnect(48)
> Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_disconnect_event()
> Apr 06 16:36:19 pi4 iwd[158609]: Received Deauthentication event,
> reason: 0, from_ap: false
> Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_disconnect_event() 3

But the kernel / firmware disconnects us.  There may be a limitation with this 
hardware where the AP/STA must operate on the same channel.  Have you tried 
setting the AP interface to operate on the same frequency as the AP you're 
trying to connect to?

> Apr 06 16:36:19 pi4 iwd[158609]: event: disconnect-info, reason: 0

Reason given is 'unspecified'...

> Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_disassociated() 3
> Apr 06 16:36:19 pi4 iwd[158609]:
> src/station.c:station_reset_connection_state() 3
> Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_roam_state_clear() 3
> Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {RX} 336 packets 72839 bytes
> Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {TX} 1635 packets 220020 bytes
> Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {update} flags 36867 <UP>
> Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {newlink} index 3 address
> DC:A6:32:B4:50:CF mtu 1500
> Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {newlink} index 3 operstate 2 <DOWN>
> Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: connecting
> (netconfig), new: disconnected
> Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: disconnected, new:
> autoconnect_quick
> Apr 06 16:36:19 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_insert()
> Inserting work item 7
> Apr 06 16:36:19 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 7
> Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:19 pi4 iwd[158609]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Apr 06 16:36:19 pi4 iwd[158609]: src/scan.c:scan_request_triggered()
> Passive scan triggered for wdev 1
> Apr 06 16:36:19 pi4 iwd[158609]:
> src/station.c:station_quick_scan_triggered() Quick scan triggered for
> wlan0
> Apr 06 16:36:19 pi4 connmand[138138]: Interface wlan0 [ wifi ] error
> "connect-failed"
> Apr 06 16:36:19 pi4 connmand[138138]: Interface wlan0 [ wifi ] state is failure
> Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_dbus_disconnect()
> Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: autoconnect_quick,
> new: disconnected
> 
> It is strange that it reports a bad password. Is this a brcmfmac
> driver issue or a firmware issue?

That is an assumption iwd makes since there's no sensible error information 
about the disconnect.

> 
> Keith
> 

Regards,
-Denis
