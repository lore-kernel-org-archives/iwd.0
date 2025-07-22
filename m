Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D028C039
	for <iwd@lists.linux.dev>; Tue, 22 Jul 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189892; cv=none; b=c+1ZQu4FIj6C1daG8wa52tewDSK+H6tBOFXoBs6eI74L696dh4zrnP9UYgQAzx9KJEGtJQ38LKK1z1qSDySIgFzIsPAmVhhGFp9FRApXIhUfZJ7/tWFPE4L6ISIq3CXYaD5zB/rboFIwn5wX4u0xWCd7GjcRz7+GeIaY769pHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189892; c=relaxed/simple;
	bh=KnMBUuCb/zj6DCkU4a78s4X2ezFaMVhchPqEcNY+wnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=etUUSHPC3DDQkcIyFUir+IkKGiS269xVDojxkp0CxgTL0rnjiwhtsKhr6wGcYJdgXSDY4cTXR+/13AptmASSelD4Crvr2Jcy0/2gpyUZ09QTz+0ngwPARlBedKSjcTkGQnkI23EQBxeT+Q1h/qbT9/6RuIldvM1AMz0+yQV+q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqpnV86T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqpnV86T"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234f17910d8so48295665ad.3
        for <iwd@lists.linux.dev>; Tue, 22 Jul 2025 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753189890; x=1753794690; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eq6VpZRof139K4BpT6oK31oo7NMyD2Q0QpoiccIQfQM=;
        b=ZqpnV86TUc4WQkrKC9GezOfM0jnOIOC3ajksE3Z0jP0m2nrCQ8Pc3sSVApkhJOvlIs
         hY6C+ERcaUs1KxZf/W/z0vpeaTCHbPaW07Yh/YkovQeonZqpp99nx8m2rIen3J7Rr9kL
         SMmaAiuJygAx865oRFsekL3sQbxdZaWyAZFFnxgcz3g41xOv6ajOSaOo2vWHuGT3vy/7
         nwtPNySza1drbde0ttfqUtZwmsY3NW6hp7g3waDs3E0vxQL4Crraf26Pt2yEl3usWzcm
         cH7bFAqXzCtpcP7r2GrIvtEYVC0qQVnggPO98X4qQ+ae9IMPTWDm21oNLmGyN/jRqCKB
         dKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753189890; x=1753794690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq6VpZRof139K4BpT6oK31oo7NMyD2Q0QpoiccIQfQM=;
        b=KiHkIDZZt4VEVpXUA2EvsYJXWhEsMJjTr9iKi9Xn9lqdKxk7a6njH5awRKGDZQyyWa
         WpwQwSjBNqrLZXp+4mMxQ6/RwexM3MSEtdznaaKUcCZa9AfRfkWHf/oL+lySSrd6WiSY
         g6xqTShN9qupBNBl5vpAZ3QjcYxPc2BmJJenPH+OH2W6rHAHlAdMXfZagajCLynPD+PD
         0DburVTS/T+5/gsTsSHU2lMJ8xJMyscfxz5Y1d8P0k6aZH+oCj3fS0NpJQJmCqHXrFjd
         bzoBH+J0frX9OpLP2odb8yIn0RLLOSU6UxtKPkTwp6IAK5M2yj0CKAB8y80wpwhM6L6o
         sd6g==
X-Forwarded-Encrypted: i=1; AJvYcCWvLjYPe2zDzlDufA4nwwM+PVD0kvDn0xqu1spW/laKx7jfuHx8T7YIVg6kR/D+T5q1Iag=@lists.linux.dev
X-Gm-Message-State: AOJu0YzCXo4LhLEzjFkV9JYDTZZU1WHRr8mQzZKHZPywJCeDKB2kE+qR
	QjPC5f7yWppxEIB56WeB2kSPruz4aJrSuzHUrwTGWIppzAt1yiMH7elEOVlSmQ==
X-Gm-Gg: ASbGncubdmM0bmk/3jtKZ0rIa8MpBMhGhfodtZXhYthx5HhNgbcnmodyIvHuLyqY0Xa
	UVn5cN+AaFRLT2RuXbk2vio+K04mTKfmPTLUJNd8xDjeI8MArtup9h6l5+sGemS4JB1yP60Cvjg
	pamBY7QUAKzld8cOoMURPJw2v2WYQ0FBmCFkk1erUx6eDGAnTHooQyK/7qHRDZ6xKvBRy8e3THH
	99zuKFhDPz4TMSxH3k+bnZL+tRTP5TgKtRflM5BbIipt13shIA8h9wTqtoGnK+8lR31gjAacQOc
	o2uP7R024OKzYk67QUE9ourMTOG7k1WP/r4DOBuLzi7ujlhP9SUBejNm/eJfHYZapQ2cIjWOPZt
	hWfmsfINgL7VDVHSg2780SBq5kg==
X-Google-Smtp-Source: AGHT+IHFcyZYf4EaM77IAirC4XnYVkuLV1d98Y4cqpzKFy2LsY+vsl/Ww7F2r4oWyyDzPYMZJvuKRA==
X-Received: by 2002:a17:902:ea0d:b0:23d:ed91:6142 with SMTP id d9443c01a7336-23e3b84e93cmr210894085ad.42.1753189889510;
        Tue, 22 Jul 2025 06:11:29 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b36sm76185655ad.92.2025.07.22.06.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:11:28 -0700 (PDT)
Message-ID: <ed371e7d-e89c-4e3a-aa84-46535c613b35@gmail.com>
Date: Tue, 22 Jul 2025 06:11:25 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dealing with wifi driver crash that doesn't remove wlan interface
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVSK3vr5=wsB8q6yz1KvB5VqSnQNW+8Nf_Wn7OrAQN470Kw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSK3vr5=wsB8q6yz1KvB5VqSnQNW+8Nf_Wn7OrAQN470Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 7/15/25 10:28 AM, Bryce Johnson wrote:
> Hi All,
> Long shot if there is something I can do with iwd, but I figured I'd
> ask... We are dealing with an occasional wifi-driver crash on silabs
> wf200 that silabs hasn't been able to fix... so we had implemented a
> workaround that seems to be working fairly well up until now.
>
>  From our wifi provisioning application, we query a few params over
> dbus periodically and log them:
> mac_address: "70:c5:9c:xx:xx:xx"
> ssid: "xxxxxxxx"
> freq: 2412
> rssi: -32
> security: "WPA2-Personal"
>
> If our dbus path fails in our application it will trigger the
> wifi-driver to be restarted.  That fixes many of the issues, but we
> ran into an issue at a friendly customer site, where the driver
> failed, but apparently left enough up where the wlan0 was up and iwd
> was just getting stale data from it.
>
> The correct answer is for silabs to fix the driver, but I was
> wondering if there were any other additional workarounds I could try
> in the meantime...

I'm not sure there is much within IWD that can be done. I've run into 
similar problems and about all you can do is implement some kind of 
watchdog which monitors for these conditions (which sounds like you've 
done). The difficult part is detecting these conditions. I've even 
monitored journalctl and scraped IWD logs to gain more state info about 
IWD than what is advertised on DBus. This is actually why I added the 
l_notice "events" to IWD, the idea being that they are a consistently 
formatted, tool parse-able lines containing additional information, e.g.

event: roam-info, bss: aa:bb:cc:dd:ee:ff, signal: -41, load: 9/255

Hope this helps,

- James

>
> This in on iwd 3.4, Here is a snip of the iwd log with debug enabled:
>
> at ~2025-07-14 18:45: the driver crashed:
> dmesg: [ 3253.325450] wfx-spi spi0.0: firmware exception
>
> at ~2025-07-15 16:20 we manually restarted the driver
> dmesg: [80768.916153] wlan0: deauthenticating from 90:09:d0:42:07:56
> by local choice (Reason: 3=DEAUTH_LEAVING)
>
>
> 2025-07-14 17:58:11.565200658  src/station.c:station_print_scan_bss()
> Processing BSS '38:70:0c:41:d2:b8' with SSID: ROBBY, freq: 2462, rank:
> 37, strength: -8500, data_rate: 5.5
> 2025-07-14 17:58:11.566580887  src/station.c:station_print_scan_bss()
> Processing BSS '18:90:88:2e:88:05' with SSID: , freq: 2412, rank: 13,
> strength: -8800, data_rate: 2.0
> 2025-07-14 17:58:11.566801362  src/station.c:station_add_seen_bss()
> BSS has hidden SSID
> 2025-07-14 17:58:11.566967170  src/station.c:station_print_scan_bss()
> Processing BSS '64:51:06:db:a5:ae' with SSID: HP-Print-AE-Photosmart
> 6520, freq: 2412, rank: 13, strength: -8800, data_rate: 2.0
> 2025-07-14 17:58:11.569713212  src/station.c:station_print_scan_bss()
> Processing BSS '76:54:25:16:80:39' with SSID: , freq: 2462, rank: 13,
> strength: -9100, data_rate: 2.0
> 2025-07-14 17:58:11.569950527  src/station.c:station_add_seen_bss()
> BSS has hidden SSID
> 2025-07-14 17:58:11.570111448  src/station.c:station_print_scan_bss()
> Processing BSS '1c:39:29:02:b4:c5' with SSID:
> AT_401_WIN_056905_WW_b4c5, freq: 2462, rank: 13, strength: -9200,
> data_rate: 2.0
> 2025-07-14 17:58:11.573726453  src/wiphy.c:wiphy_radio_work_done()
> Work item 4 done
> 2025-07-14 17:58:11.575809796  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 2
> 2025-07-14 17:58:17.677447209  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 6
> 2025-07-14 17:58:17.677731675  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 5
> 2025-07-14 17:59:23.451727924  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 5
> 2025-07-14 17:59:23.463000704  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 5
> 2025-07-14 17:59:23.482318002  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 5
> 2025-07-14 17:59:23.483857888  src/netdev.c:netdev_link_notify() event
> 17 on ifindex 5
> 2025-07-14 17:59:23.485664308  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 4
> 2025-07-14 17:59:23.487021309  src/netdev.c:netdev_link_notify() event
> 17 on ifindex 5
> 2025-07-14 17:59:31.211091899  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.213708170  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.276263723  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.283333624  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.285134352  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.286224134  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 4
> 2025-07-14 17:59:31.288634631  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.289996567  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.339801875  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.340068480  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:31.341316514  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 17:59:46.764125543  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 8
> 2025-07-14 18:45:50.472050964  src/netdev.c:netdev_unicast_notify()
> Unicast notification Control Port Frame(129)
> 2025-07-14 18:45:50.472323982  src/netdev.c:netdev_control_port_frame_event()
> 2025-07-14 18:45:50.489657876  src/eapol.c:eapol_handle_gtk_1_of_2() ifindex=2
> 2025-07-14 18:45:50.503031733  src/netdev.c:netdev_set_gtk() ifindex=2 key_idx=2
> 2025-07-14 18:45:50.526112177  src/netdev.c:netdev_new_group_key_cb()
> ifindex: 2, err: 0
> 2025-07-14 18:45:50.527560761  src/netdev.c:try_handshake_complete()
> ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
> 2025-07-14 18:45:50.528956809  src/netdev.c:try_handshake_complete()
> nhs->complete: 1
> 2025-07-14 18:45:50.559356169  src/netdev.c:netdev_mlme_notify() MLME
> notification Control Port TX Status(139)
> 2025-07-15 16:20:46.865790966  src/netdev.c:netdev_mlme_notify() MLME
> notification Notify CQM(64)
> 2025-07-15 16:20:46.866248149  src/station.c:station_packets_lost()
> Packets lost event: 50
> 2025-07-15 16:20:46.866559823  src/station.c:station_start_roam()
> Requesting neighbor report for roam
> 2025-07-15 16:20:49.674634613  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 2
> 2025-07-15 16:20:49.689872602  src/netdev.c:netdev_link_notify() event
> 16 on ifindex 2
> 2025-07-15 16:20:49.690157914
> src/station.c:station_neighbor_report_cb() ifindex: 2, error:
> -107(Transport endpoint is not connected)
> 2025-07-15 16:20:49.690321414
> src/station.c:station_neighbor_report_cb() no neighbor report results
> or known freqs
> 2025-07-15 16:20:49.690755567  src/station.c:station_roam_failed() 2
> 2025-07-15 16:20:49.690928478  src/station.c:station_free()
> 2025-07-15 16:20:49.691063826  src/netconfig.c:netconfig_destroy()
> 2025-07-15 16:20:49.694320325
> src/netconfig.c:netconfig_event_handler() l_netconfig event 2
> 2025-07-15 16:20:49.696345663
> src/netconfig-commit.c:netconfig_commit_print_addrs() removing
> address: 192.168.1.100
> 2025-07-15 16:20:52.482746720  resolve: /sbin/resolvconf exited with
> status (36096).
> 2025-07-15 16:20:52.483011183  src/station.c:station_roam_state_clear() 2
> 2025-07-15 16:20:52.520806556  src/netdev.c:netdev_link_notify() event
> 17 on ifindex 2
> 2025-07-15 16:20:52.522040814  src/netdev.c:netdev_free() Freeing
> netdev wlan0[2]
> 2025-07-15 16:20:52.524139481  src/device.c:device_free()
> 2025-07-15 16:20:52.526958891  Removing scan context for wdev 1
>
