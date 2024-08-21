Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1B1AD5F4
	for <iwd@lists.linux.dev>; Wed, 21 Aug 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250467; cv=none; b=GZiyJxl31GTWLRRR1mbTQcxYH5ZGnbcvslyi5j87ZQHEa9Hw8Y8JVigBGgeztQyPOPSmhnBpuhgFsu+TqWbk73Anc+MfQ9Pzwx1fEjkkQ2/vQ3HT/ToEurP/ClDzDJOgQeZEv4OyqNq4cfId2NikcGn1HGHLYO0th8vQG/XUmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250467; c=relaxed/simple;
	bh=Ca0cA6o92W6WsxeiTBy6XrRt1cJQbDPIhd3bYqcM8Hw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Kf2wsUUIqVmxQzvj5TBtf8wDp46c/+QRI5NN6E4/gkgKUKiLapZyiWRGI54VT3ZkJhUyDns06mcEYH7AzoJdrG8kbgFLgWd48FaNxPmFkjXjZTvPIZcy9qibRsNR0GZ04wt5V0HJPUYoEZ7o0Pf0eib7iv0WA84QBRA4I4G82Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeQ0FMEp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeQ0FMEp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4765368a12.2
        for <iwd@lists.linux.dev>; Wed, 21 Aug 2024 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724250465; x=1724855265; darn=lists.linux.dev;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnJdvRJ1OSVLhz6RRYzBInVrGtUTZ5bAX5IwfWA3zmo=;
        b=eeQ0FMEpKA/VgAXTQTbjREP4q5Mfeo5X2s0e2oSY3Cd37+4Ave6+OPEtvZiQF8o2og
         jocBiuzSHh8Bwfr3RLTdcoP2zLJCyR9sIrtEW36NVc3QECcPUFrzBzbhGI+M8KPFHo4G
         MZoSYGtZUNc8N/iBIol4eljBslEsSAUGzbiCWF00l3RX0eJuloBqy52X0KUkDgMMnsqd
         yiWU1JG0sFZblyFhV/tg2OdE7UmrUHKnqtO7MTikA4utA81BN77LWZM1pvW1kwHYa9Yb
         mfZ1bH8rp/DNcYAZnjcPFBQ4fqyQKr5zcGAkUmP4UhE38EBpYW5NHm+Ny26uICDURKnk
         P82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250465; x=1724855265;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnJdvRJ1OSVLhz6RRYzBInVrGtUTZ5bAX5IwfWA3zmo=;
        b=b/C0AIPuKPEbslVFCiH0NQb2dsNN4zd4jN/6g2opg+phvarz8JR2ccq+P4oofOivRq
         3l98J4CzIgfi1LQ6FDuJ9g8ItOFJIKBjAHw3J4UJ6hfzZSSBApyHDj2iRTpXaS+2O4pD
         GTVpSqo7rvrsoTuiZNy3jARjClR9PYbOjwkmlby5uvQcICTPi5xMyT5Y2id/NRdsaFYG
         suE8WwcIs25uBCIJB+bnPFj62lADUZnqgWWW+bHhAOAc0lUBHZLSPOJbZGs47srcJPZl
         5cussTsjxi8tc0rPPa8txVHHcT2u3zlEsoUIblsRlCYdKYfJYtQOZ84pKxrKOnjLaF9I
         sgOQ==
X-Gm-Message-State: AOJu0YzLekR8rU2OLIXkJ7AGdMRrCegThhr2r9ySzE7nYQYeXtdKN0eQ
	C6eNbZ+lkQXwA4ekjIaE4cgpuD7kHAxtfHFpbB9rm0cCrfAq4RE8
X-Google-Smtp-Source: AGHT+IE54W2wplMMmoFISUexuIZZxX6tDbahXhH2P5x3ryPAxgCVkJdbZrODMtc0q9wEu3iFoX6+Bw==
X-Received: by 2002:a17:90b:17c1:b0:2d3:d4ca:62f6 with SMTP id 98e67ed59e1d1-2d5e9fce0eamr2516681a91.42.1724250465152;
        Wed, 21 Aug 2024 07:27:45 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb91bb09sm1876641a91.9.2024.08.21.07.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 07:27:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------JXEgrxD6hlcKDH14LcQVwKFz"
Message-ID: <290cafd7-b8ab-4a51-8f54-ba0b61a5afd4@gmail.com>
Date: Wed, 21 Aug 2024 07:27:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segmentation fault when taking device for a walk
To: Richard Acayan <mailingradian@gmail.com>
Cc: iwd@lists.linux.dev
References: <Zr6cKJePuQd4Dm_n@radian>
 <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com> <ZsPATiu0_31D8Qcq@radian>
 <e6ff554e-ad17-46e3-b614-ac6da796b337@gmail.com> <ZsS9oqna82kDmgJy@radian>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ZsS9oqna82kDmgJy@radian>

This is a multi-part message in MIME format.
--------------JXEgrxD6hlcKDH14LcQVwKFz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Richard,

On 8/20/24 9:00 AM, Richard Acayan wrote:
> On Tue, Aug 20, 2024 at 08:04:20AM -0700, James Prestwood wrote:
>> Hi Richard,
>>
>> On 8/19/24 2:59 PM, Richard Acayan wrote:
>>> On Fri, Aug 16, 2024 at 04:53:41AM -0700, James Prestwood wrote:
>>>> Hi Richard,
>>>>
>>>> On 8/15/24 5:24 PM, Richard Acayan wrote:
>>>>> Hi,
>>>>>
>>>>> A segmentation fault occurs in station_start_roam() when the station is
>>>>> disconnected from an access point, or in other words, when the station's
>>>>> connected_bss is NULL. Usually, this is triggered by a timeout, possibly
>>>>> scheduled in response to a weak signal event.
>>>>>
>>>>> This is occurring on my Pixel 3a running postmarketOS/Alpine Linux, when
>>>>> receding from an access point, on iwd 2.19. I have collected 6 coredumps
>>>>> of the crash in the span of around 2 weeks and would be willing to use
>>>>> GDB if more information is necessary for a patch.
>>>>>
>>>>> Sample:
>>>>>
>>>>> 	Program terminated with signal SIGSEGV, Segmentation fault.
>>>>> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
>>>>> 	
>>>>> 	warning: 2880	src/station.c: No such file or directory
>>>>> 	(gdb) bt
>>>>> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
>>>>> 	#1  0x0000aaaadf28c544 in timeout_callback (fd=<optimized out>, events=<optimized out>,
>>>>> 	    user_data=0xffff876b2e20) at ell/timeout.c:68
>>>>> 	#2  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0xffff876b2e20)
>>>>> 	    at ell/timeout.c:57
>>>>> 	#3  0x0000aaaadf28b9d0 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
>>>>> 	#4  0x0000aaaadf28bac0 in l_main_run () at ell/main.c:508
>>>>> 	#5  l_main_run () at ell/main.c:490
>>>>> 	#6  0x0000aaaadf28bce4 in l_main_run_with_signal (
>>>>> 	    callback=callback@entry=0xaaaadf1f1110 <signal_handler>, user_data=user_data@entry=0x0)
>>>>> 	    at ell/main.c:630
>>>>> 	#7  0x0000aaaadf1f0b0c in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:611
>>>>> 	(gdb) p station->connected_bss
>>>>> 	$1 = (struct scan_bss *) 0x0
>>>>>
>>>> Its hard to say without any debug logs as well but it appears the disconnect
>>>> never cleared out the timer used for the next roam attempt. I did fix a hang
>>>> due to a disconnect coming in during a roam attempt after 2.19, but I can't
>>>> really make heads or tails without debug logs to see what happened
>>>> before/after the disconnect.
>>> It happened again with debug logs enabled. Relevant snippet (from
>>> logread):
>>>
>>> 	[Aug 17 21:22:12] daemon iwd: src/station.c:station_roam_state_clear() 5
>>> 	[Aug 17 21:22:12] daemon iwd: event: state, old: connected, new: disconnecting
>>> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
>>> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
>>> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
>>> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_deauthenticate_event()
>>> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
>>> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_disconnect_event()
>>> 	[Aug 17 21:22:15] daemon iwd: src/station.c:station_disconnect_cb() 5, success: 1
>>> 	[Aug 17 21:22:15] daemon iwd: event: state, old: disconnecting, new: disconnected
>>> 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
>>> 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
>>> 	[Aug 17 21:22:36] daemon iwd: src/station.c:station_roam_trigger_cb() 5
>>>
>>> Afterwards is the segmentation fault.
>> Do you happen to have the logs a few minutes prior. The roam timeout is
>> defaulted to 60 seconds, so at some point it was re-armed but the logs don't
>> go back that far. Its trivial to handle the segfault but I suspect the roam
>> timeout being rearmed is also leaking memory so we should address that as
>> the root cause.
> Unfortunately not, only for the last half-minute (with personal
> information). Here's a bit more that I don't need to redact:
>
> 	[Aug 17 21:22:07] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 17 21:22:07] daemon iwd: src/wiphy.c:wiphy_radio_work_done() Work item 279 done
> 	[Aug 17 21:22:12] daemon iwd: src/station.c:station_dbus_disconnect()
> 	[Aug 17 21:22:12] daemon iwd: src/station.c:station_reset_connection_state() 5
> 	[Aug 17 21:22:12] daemon iwd: src/station.c:station_roam_state_clear() 5
> 	[Aug 17 21:22:12] daemon iwd: event: state, old: connected, new: disconnecting
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_deauthenticate_event()
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_disconnect_event()
> 	[Aug 17 21:22:15] daemon iwd: src/station.c:station_disconnect_cb() 5, success: 1
> 	[Aug 17 21:22:15] daemon iwd: event: state, old: disconnecting, new: disconnected
> 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
> 	[Aug 17 21:22:36] daemon iwd: src/station.c:station_roam_trigger_cb() 5
>
> I can confirm, though, that there are more timeouts than expected, even
> after (presumably) clearing the last timeout:
>
> 	Core was generated by `/usr/libexec/iwd -d'.
> 	Program terminated with signal SIGSEGV, Segmentation fault.
> 	#0  0x0000aaaadf1686a0 in station_start_roam (station=0xffffb0527b30) at src/station.c:2880
> 	
> 	warning: 2880	src/station.c: No such file or directory
> 	(gdb) p *watch_list[12]
> 	$1 = {fd = 12, events = 1073741825, flags = 1, callback = 0xaaaadf1ec4f0 <timeout_callback>,
> 	  destroy = 0xaaaadf1ec350 <timeout_destroy>, user_data = 0xffffb0530dd0}
> 	(gdb) p *(struct l_timeout *) watch_list[12]->user_data
> 	$2 = {fd = 12, callback = 0xaaaadf1687a0 <station_roam_trigger_cb>, destroy = 0x0,
> 	  user_data = 0xffffb0527b30}
> 	(gdb) p *watch_list[13]
> 	$3 = {fd = 13, events = 1073741825, flags = 0, callback = 0xaaaadf1ec4f0 <timeout_callback>,
> 	  destroy = 0xaaaadf1ec350 <timeout_destroy>, user_data = 0xffffb0530ef0}
> 	(gdb) p *(struct l_timeout *) watch_list[13]->user_data
> 	$4 = {fd = 13, callback = 0xaaaadf1687a0 <station_roam_trigger_cb>, destroy = 0x0,
> 	  user_data = 0xffffb0527b30}
> 	(gdb) p *watch_list[14]
> 	$5 = {fd = 14, events = 1073741825, flags = 0, callback = 0xaaaadf1ec4f0 <timeout_callback>,
> 	  destroy = 0xaaaadf1ec350 <timeout_destroy>, user_data = 0xffffb0530c50}
> 	(gdb) p *(struct l_timeout *) watch_list[14]->user_data
> 	$6 = {fd = 14, callback = 0xaaaadf1687a0 <station_roam_trigger_cb>, destroy = 0x0,
> 	  user_data = 0xffffb0527b30}

Could you try the attached patch. Assuming this fixes it you should also 
see some WARNING debug logs, which would be nice to provide to us as 
this will tell us where this timer is being overwritten.

Also do you happen to know the wifi chipset in the Pixel 3a? I cant seem 
to find that anywhere online.

Thanks,

James

--------------JXEgrxD6hlcKDH14LcQVwKFz
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-station-check-for-roam-timeout-before-rearming.patch"
Content-Disposition: attachment;
 filename*0="0001-station-check-for-roam-timeout-before-rearming.patch"
Content-Transfer-Encoding: base64

RnJvbSAxMzY2ZTQ3ZGUwNzAwYzkyMzVkYTAzYzU4ZjIyYTJhNDIzNDUxYTZlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBQcmVzdHdvb2QgPHByZXN0d29qQGdtYWls
LmNvbT4KRGF0ZTogVHVlLCAyMCBBdWcgMjAyNCAwNzo1OTozNiAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIHN0YXRpb246IGNoZWNrIGZvciByb2FtIHRpbWVvdXQgYmVmb3JlIHJlYXJtaW5n
CgotLS0KIHNyYy9zdGF0aW9uLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3N0YXRpb24uYyBi
L3NyYy9zdGF0aW9uLmMKaW5kZXggNTA5ZDkxOWMuLmU5MGE2NGY3IDEwMDY0NAotLS0gYS9z
cmMvc3RhdGlvbi5jCisrKyBiL3NyYy9zdGF0aW9uLmMKQEAgLTIxMTQsNyArMjExNCw3IEBA
IHN0YXRpYyB2b2lkIHN0YXRpb25fcm9hbWVkKHN0cnVjdCBzdGF0aW9uICpzdGF0aW9uKQog
CSAqIFNjaGVkdWxlIGFub3RoZXIgcm9hbWluZyBhdHRlbXB0IGluIGNhc2UgdGhlIHNpZ25h
bCBjb250aW51ZXMgdG8KIAkgKiByZW1haW4gbG93LiBBIHN1YnNlcXVlbnQgaGlnaCBzaWdu
YWwgbm90aWZpY2F0aW9uIHdpbGwgY2FuY2VsIGl0LgogCSAqLwotCWlmIChzdGF0aW9uLT5z
aWduYWxfbG93KQorCWlmIChzdGF0aW9uLT5zaWduYWxfbG93ICYmIExfV0FSTl9PTighc3Rh
dGlvbi0+cm9hbV90cmlnZ2VyX3RpbWVvdXQpKQogCQlzdGF0aW9uX3JvYW1fdGltZW91dF9y
ZWFybShzdGF0aW9uLCByb2FtX3JldHJ5X2ludGVydmFsKTsKIAogCWlmIChzdGF0aW9uLT5u
ZXRjb25maWcpCkBAIC0yMTUzLDcgKzIxNTMsNyBAQCBzdGF0aWMgdm9pZCBzdGF0aW9uX3Jv
YW1fcmV0cnkoc3RydWN0IHN0YXRpb24gKnN0YXRpb24pCiAJc3RhdGlvbi0+cm9hbV9zY2Fu
X2Z1bGwgPSBmYWxzZTsKIAlzdGF0aW9uLT5hcF9kaXJlY3RlZF9yb2FtaW5nID0gZmFsc2U7
CiAKLQlpZiAoc3RhdGlvbi0+c2lnbmFsX2xvdykKKwlpZiAoc3RhdGlvbi0+c2lnbmFsX2xv
dyAmJiBMX1dBUk5fT04oIXN0YXRpb24tPnJvYW1fdHJpZ2dlcl90aW1lb3V0KSkKIAkJc3Rh
dGlvbl9yb2FtX3RpbWVvdXRfcmVhcm0oc3RhdGlvbiwgcm9hbV9yZXRyeV9pbnRlcnZhbCk7
CiB9CiAKLS0gCjIuMzQuMQoK

--------------JXEgrxD6hlcKDH14LcQVwKFz--
