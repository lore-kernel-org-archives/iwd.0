Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFA73451
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171568; cv=none; b=npovldwulfgqeIm9dlmFSbjDkvQbtFEhUha6zUhdfV+JMWVxbaNzGDCTzBFwjN6ZklJOkIRs94l/u3JPkN7hmro4AW7gMrV8/OfFv6YA42vgOirJnBknuIdyuadHZo3sQJ5mjWVljaPbe8g6JBJ0TXFPhVzhVrKbM4QLRY9uS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171568; c=relaxed/simple;
	bh=jhzZnAGh8GkJlJBEs71MGPHerlcD+poDdBipQHz1MHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5LXNRf05A8KXMuLQAPMH8PsnjmtxiN3vxics/fJT1fjkXI57NndajAdC6MUGbgMfBc49upo/xO7FkUOIQLqIqWcvi9zuq6bzCn8yFvuhzAh1nKy8wTSJBzXN2UmnJsCDKeltJxPhVsQuWUAHDsQhskG89lfJcoUgt7XNbqVXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Dh1Q2m; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Dh1Q2m"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d89a727a19so135642366d6.0
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736171566; x=1736776366; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0DLl1oFM7yfsLYo9DU0kFUxr+1dpDmYC4MJ3YugUTE=;
        b=Q4Dh1Q2mx5wKOkYhOpQz3gNJLeFX77yq4FX8VfPGLHBB9VFOO2vAUVtNt/iopTH10r
         DgHi1HQejlM94aRlN+kESJBvgyQDrZPMtla0tH4ieRXTL12sEdX0xMDnjGOCyAsx5LMV
         IuXmPxsArKOc6lRn9P5aDTdK45qjVniYpcxijG+cgFWoK37Eajq0K6arWsHYOnEVkUXW
         u3Uj280etj5PraOKw4Gs+4dk23COwwByrwBSVOAkN5QwebI/Vgz1/wDrzwpGgrDkbrnK
         xNBcZja2k3QrfrExg/W9I5yg89cqFAlNjgkuJoMphdJLkb76Xl1u8H4YjM9LIpeeY/zg
         SLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736171566; x=1736776366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0DLl1oFM7yfsLYo9DU0kFUxr+1dpDmYC4MJ3YugUTE=;
        b=BkbQVU3qLgbwMpoOzDI3Pxnv+FoYErW06E6gBpK5Ntorq3X69DOCLGQwffzxJxWmkc
         3A0dGHUIPQycCP/iCiTRgo+oqnl8TvVDMkaGDymUho5giShNlmZC23ZEerQRKAK94/Nn
         bwoiBwOrBEul3JevVkJ6gmOQzgLGSjNbbdZSmQk/9sABLGzi1v1Qf4OmXh6q7eLddJPh
         F3OYcmX5/T2z21S8r49K3C7m/Kzom6GZdJNXN33wAREZvsRzOuWwjjbkqJTvxq/Rgihd
         GHS7HvkGtik7Ly61+hXYel+B1qpaCrfE5KsRy9qv9enXRszKbPzOPZ4RFM89AhMXwM0O
         f3DQ==
X-Gm-Message-State: AOJu0YxM6mOuZoijdJnjZD94syCR61Gdbmn3hKXTgMwC7fY9ZZnN32a2
	zBZWspmEEjPvuKHwINTlZAnFz4gg0bD89VNGDna17cu+G++BNOOWskLfKA==
X-Gm-Gg: ASbGncuu0jPYbaIkWD78Q8vKKBxa+UlS8dtSI1oQ4FRR0AtoNnqPkeisxZ0vxksTe0F
	fXanxry4iL4ccxlr9xejsssZJAazbMV/LyJCD8ee/H0pV1nRCNF9wHSEhUeUdjHPLaRJFiVd9Vb
	tWQx2Oi7HLtrZLsJ3rITvzNUhtidqonamHzLvHJsd9Opz3llW6nscmAiWvZKZImYpy/sD1aWIyR
	4P6gCEWT26yuHRsdZbYRa8P18oNeUo8lC/e57DF0mR/lv7wA9NbVfHDuHW3
X-Google-Smtp-Source: AGHT+IHNr+/0TtDqztKjnqHLT4yNTXPI3/QU6mPgg5ZmxorjHo1jdqiVkzw4S6zFVt88XnO7VfuBIA==
X-Received: by 2002:a05:6214:3c9f:b0:6d8:a9a6:83ef with SMTP id 6a1803df08f44-6dd23618bb2mr1061905176d6.20.1736171565520;
        Mon, 06 Jan 2025 05:52:45 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ddd3d6fbf1sm25187936d6.132.2025.01.06.05.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:52:45 -0800 (PST)
Message-ID: <b606fe1b-5265-4a96-ac90-a80c1725abb3@gmail.com>
Date: Mon, 6 Jan 2025 05:52:43 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repeated Deauthentication event, reason: 4
To: Owen Garland <garland.owen@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAPDaQ_wdXGvy7Sa=10bSC7eAbLut4Jw_CP16Xob7aVtqgCYxSg@mail.gmail.com>
 <a24382ff-0756-45f2-8e5d-69da8993e3df@gmail.com>
 <CAPDaQ_z3GyLsQM86wDXa0UwN9n5p0T4sNmPvSUcgEfpAkqsKQw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAPDaQ_z3GyLsQM86wDXa0UwN9n5p0T4sNmPvSUcgEfpAkqsKQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Owen,

On 1/4/25 1:17 AM, Owen Garland wrote:
> Hey, thanks for the quick response!
>
> I'm unsure that the signal strength is the issue, though I can't rule
> it out, as this issue has manifested itself since I've changed OS from
> Manjaro with NetworkManager to Arch with iwd, which has lead me to
> think it's a software issue.
That would make sense. My guess is some difference in the kernel version 
or iwlwifi firmware version between Manjaro and Arch. To at least remove 
IWD from the equation you could try wpa_supplicant with your current 
Arch distro. If you see the same behavior this is likely some regression 
with the kernel/iwlwifi.
>
> Here is the logs of the event with debug enabled:
>
> ~ λ journalctl -u iwd | grep -C 15 08:57:34
> Jan 04 08:57:33 titanium iwd[415831]: src/netdev.c:netdev_set_rekey_offload() 7
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:netdev_new_group_key_cb() ifindex: 7, err: 0
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
> 1, igtk_installed: 1
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX
> Status(139)
> Jan 04 08:57:33 titanium iwd[415831]: src/netdev.c:netdev_set_station_cb()
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
> 1, igtk_installed: 1
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:try_handshake_complete() nhs->complete: 0
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:try_handshake_complete() Invoking handshake_event()
> Jan 04 08:57:33 titanium iwd[415831]:
> src/handshake.c:handshake_state_cache_pmksa() (nil)
> Jan 04 08:57:33 titanium iwd[415831]: src/netdev.c:netdev_connect_ok()
> Jan 04 08:57:33 titanium iwd[415831]:
> src/station.c:station_connect_cb() 7, result: 0
> Jan 04 08:57:33 titanium iwd[415831]: src/station.c:station_connect_ok()
> Jan 04 08:57:33 titanium iwd[415831]: event: state, old: connecting
> (auto), new: connecting (netconfig)
> Jan 04 08:57:33 titanium iwd[415831]:
> src/wiphy.c:wiphy_radio_work_done() Work item 713 done
> Jan 04 08:57:33 titanium iwd[415831]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> Jan 04 08:57:34 titanium iwd[415831]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> Jan 04 08:57:34 titanium iwd[415831]:
> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Jan 04 08:57:34 titanium iwd[415831]:
> src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> Jan 04 08:57:34 titanium iwd[415831]: src/netdev.c:netdev_deauthenticate_event()
> Jan 04 08:57:34 titanium iwd[415831]:
> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> Jan 04 08:57:34 titanium iwd[415831]: src/netdev.c:netdev_disconnect_event()
> Jan 04 08:57:34 titanium iwd[415831]: Received Deauthentication event,
> reason: 4, from_ap: false
> Jan 04 08:57:34 titanium iwd[415831]: src/station.c:station_disconnect_event() 7
> Jan 04 08:57:34 titanium iwd[415831]: event: disconnect-info, reason: 4
So we get this disconnect immediately after connecting. Was there any 
kernel logs here? I'm expecting to see something from iwlwifi like 
"connection lost". Unfortunately userspace has no control over this type 
of disconnect. The kernel disconnected for some reason and is notifying 
userspace. If you do see an improvement with wpa_supplicant using the 
same kernel/firmware that would be odd, and would warrant a closer look 
at IWD itself.
> Jan 04 08:57:34 titanium iwd[415831]: src/station.c:station_disassociated() 7
> Jan 04 08:57:34 titanium iwd[415831]:
> src/station.c:station_reset_connection_state() 7
> Jan 04 08:57:34 titanium iwd[415831]: src/station.c:station_roam_state_clear() 7
> Jan 04 08:57:34 titanium iwd[415831]: event: state, old: connecting
> (netconfig), new: disconnected
> Jan 04 08:57:34 titanium iwd[415831]: event: state, old: disconnected,
> new: autoconnect_quick
> Jan 04 08:57:34 titanium iwd[415831]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 714
> Jan 04 08:57:34 titanium iwd[415831]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 714
> Jan 04 08:57:34 titanium iwd[415831]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> Jan 04 08:57:34 titanium iwd[415831]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> Jan 04 08:57:34 titanium iwd[415831]:
> src/scan.c:scan_request_triggered() Active scan triggered for wdev 6
> Jan 04 08:57:34 titanium iwd[415831]:
> src/station.c:station_quick_scan_triggered() Quick scan triggered for
> wlan0
> Jan 04 08:57:35 titanium iwd[415831]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> Jan 04 08:57:35 titanium iwd[415831]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> Jan 04 08:57:35 titanium iwd[415831]:
> src/station.c:station_print_scan_bss() Processing BSS
> '60:38:e0:3d:f0:b2' with SSID: Tronx_Lower, freq: 2447, rank: 177,
> strength: -7700, data_rate: 21.7, load: 24/255, clients: 1
> Jan 04 08:57:35 titanium iwd[415831]:
> src/station.c:station_print_scan_bss() Processing BSS
> 'c8:78:7d:e6:d3:53' with SSID: Tronx_Middle, freq: 2447, rank: 118,
> strength: -7800, data_rate: 14.4, load: 25/255, clients: 5
> Jan 04 08:57:35 titanium iwd[415831]:
> src/station.c:station_print_scan_bss() Processing BSS
> 'b0:38:29:18:14:0f' with SSID: Omni10_Setup_40F, freq: 2462, rank: 75,
> strength: -8300, data_rate: 11.0
> Jan 04 08:57:35 titanium iwd[415831]:
> src/station.c:station_print_scan_bss() Processing BSS
> '22:d2:cc:07:9c:b5' with SSID: Tronx_Upper, freq: 2422, rank: 75,
> strength: -8300, data_rate: 11.0
> Jan 04 08:57:35 titanium iwd[415831]: src/station.c:station_autoconnect_start()
> Jan 04 08:57:35 titanium iwd[415831]:
> src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
> Tronx_Upper
> Jan 04 08:57:35 titanium iwd[415831]:
> src/station.c:station_autoconnect_next() autoconnect:
> '22:d2:cc:07:9c:b5' freq: 2422, rank: 75, strength: -8300
> Jan 04 08:57:35 titanium iwd[415831]: src/netdev.c:netdev_cqm_rssi_update()
> Jan 04 08:57:35 titanium iwd[415831]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 715
> Jan 04 08:57:35 titanium iwd[415831]: event: connect-info, ssid:
> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -83, load: 0/255
> Jan 04 08:57:35 titanium iwd[415831]: event: state, old:
> autoconnect_quick, new: connecting (auto)
> Jan 04 08:57:35 titanium iwd[415831]: src/scan.c:scan_cancel() Trying
> to cancel scan id 714 for wdev 6
> Jan 04 08:57:35 titanium iwd[415831]:
> src/wiphy.c:wiphy_radio_work_done() Work item 714 done
>
> Let me know if you need to see anything else :)
>
> Thanks again!
>
> On Sat, Jan 4, 2025 at 12:25 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi,
>>
>> On 1/3/25 2:16 PM, Owen Garland wrote:
>>> Hej all,
>>>
>>> I couldn't find an issue tracker so I am trying here. Essentially my
>>> problem is I get deauthenticated from AP's at seemingly random
>>> intervals, with `reason: 4`.
>>>
>>> iwd --version: 3.3
>>> OS: Arch-Linux 6.11.9-arch1-1
>>> Device: Dell XPS 9370
>>> Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
>>>           Subsystem: Intel Corporation Device 8050
>>>           Kernel driver in use: iwlwifi
>>>           Kernel modules: iwlwifi
>>> iwconfig:
>>>     wlan0     IEEE 802.11  ESSID:"Tronx_Upper"
>>>              Mode:Managed  Frequency:2.422 GHz  Access Point: 22:D2:CC:07:9C:B5
>>>              Bit Rate=65 Mb/s   Tx-Power=22 dBm
>>>              Retry short limit:7   RTS thr:off   Fragment thr:off
>>>              Power Management:off
>>>              Link Quality=31/70  Signal level=-79 dBm
>>>              Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>>>              Tx excessive retries:209  Invalid misc:664   Missed beacon:0
>>>
>>> The logs from `journactl -u iwd` show this:
>>>
>>> Jan 03 21:52:09 titanium systemd[1]: Starting Wireless service...
>>> Jan 03 21:52:09 titanium iwd[318201]: Wireless daemon version 3.3
>>> Jan 03 21:52:09 titanium iwd[318201]: Loaded configuration from
>>> /etc/iwd/main.conf
>>> Jan 03 21:52:09 titanium systemd[1]: Started Wireless service.
>>> Jan 03 21:52:09 titanium iwd[318201]: Wiphy: 0, Name: phy0
>>> Jan 03 21:52:09 titanium iwd[318201]:         Permanent Address:
>>> 64:5d:86:ed:80:5a
>>> Jan 03 21:52:09 titanium iwd[318201]:         2.4GHz Band:
>>> Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-HT):
>>> Jan 03 21:52:09 titanium iwd[318201]:                          1.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                          2.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                          5.5 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         11.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities:
>>> Jan 03 21:52:09 titanium iwd[318201]:                         HT40
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 20Mhz
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 40Mhz
>>> Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS indexes:
>>> Jan 03 21:52:09 titanium iwd[318201]:                         0-15
>>> Jan 03 21:52:09 titanium iwd[318201]:         5GHz Band:
>>> Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-HT):
>>> Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mbps
>>> Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities:
>>> Jan 03 21:52:09 titanium iwd[318201]:                         HT40
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 20Mhz
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 40Mhz
>>> Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS indexes:
>>> Jan 03 21:52:09 titanium iwd[318201]:                         0-15
>>> Jan 03 21:52:09 titanium iwd[318201]:                 VHT Capabilities:
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 80Mhz
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Max RX
>>> MCS: 0-9 for NSS: 2
>>> Jan 03 21:52:09 titanium iwd[318201]:                         Max TX
>>> MCS: 0-9 for NSS: 2
>>> Jan 03 21:52:09 titanium iwd[318201]:         Ciphers: BIP-CMAC-128
>>> CCMP-128 TKIP
>>> Jan 03 21:52:09 titanium iwd[318201]:         Supported iftypes:
>>> ad-hoc station ap p2p-client p2p-go p2p-device
>>> Jan 03 21:52:09 titanium iwd[318201]: event: state, old: disconnected,
>>> new: autoconnect_quick
>>> Jan 03 21:52:09 titanium iwd[318201]: udev interface=wlan0 ifindex=6
>>> Jan 03 21:52:10 titanium iwd[318201]: event: connect-info, ssid:
>>> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
>>> Jan 03 21:52:10 titanium iwd[318201]: event: state, old:
>>> autoconnect_quick, new: connecting (auto)
>>> Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
>>> (auto), new: connecting (netconfig)
>>> Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
>>> (netconfig), new: connected
>>> Jan 03 21:52:15 titanium iwd[318201]: event: roam-scan,
>>> <truncated>
>>> Jan 03 22:41:53 titanium iwd[318201]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>> Jan 03 22:41:53 titanium iwd[318201]: event: disconnect-info, reason: 4
>>> Jan 03 22:41:53 titanium iwd[318201]: event: state, old: connected,
>>> new: disconnected
>>> Jan 03 22:41:53 titanium iwd[318201]: event: state, old: disconnected,
>>> new: autoconnect_quick
>>> Jan 03 22:41:54 titanium iwd[318201]: event: state, old:
>>> autoconnect_quick, new: autoconnect_full
>>> Jan 03 22:42:13 titanium iwd[318201]: event: connect-info, ssid:
>>> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
>>> Jan 03 22:42:13 titanium iwd[318201]: event: state, old:
>>> autoconnect_full, new: connecting (auto)
>>> Jan 03 22:42:17 titanium iwd[318201]: event: state, old: connecting
>>> (auto), new: connecting (netconfig)
>>> Jan 03 22:42:18 titanium iwd[318201]: event: state, old: connecting
>>> (netconfig), new: connected
>>>
>>> This then appears to happen several times, and at seemingly random
>>> intervals. It can be fine for several hours, then there is one
>>> disconnect, or there may be a few disconnects in a short time. As an
>>> example the 28th had this:
>>>
>>>    Dec 28 15:40:49 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 15:41:12 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 16:02:27 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 16:13:12 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 16:13:27 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 16:34:55 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 17:02:41 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 17:11:34 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 17:16:38 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 17:20:27 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 17:25:01 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 18:52:40 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 20:21:20 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 20:21:28 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 20:21:46 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>>>    Dec 28 21:07:33 titanium iwd[869]: Received Deauthentication event,
>>> reason: 4, from_ap: false
>> Were there any additional kernel/IWD logs at those time? Its probably
>> best to enable IWD debugging with the "-d" flag.
>>
>> This reason code is "Disassociated due to inactivity" and a local
>> disconnect, which we see in our deployments as well. Is your device
>> operating in low RSSI conditions? I see when you connected the RSSI was
>> -79 which is at or at least very quickly approaching unusable connection
>> quality. I suspect this i
>>
>>> My investigations haven't led to much, not having a publicly viewable
>>> issue tracker is certainly not helping. I have found a few other
>>> threads where people have had this issue, however none of the proposed
>>> remedies have made an impact. The one thing I did try was disabling
>>> powersaving by adding this to my config:
>>>
>>> ~ λ cat /etc/modprobe.d/iwlwifi.conf
>>> options iwlmvm power_scheme=1
>>> options iwlwifi power_save=0
>>>
>>>    Any suggestions on where to take this, and let me know if I can
>>> provide you with any further information.
>>>
>>> Thanks for making open source software <3
>>>
