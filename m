Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B817BA9
	for <iwd@lists.linux.dev>; Tue,  5 Aug 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397482; cv=none; b=QsnaYoIuU5XCBlsKmJlI9KrLLMKFPRzqhjRKNWWcS4nFQHBks3XEmmq6Dj7cjZjsoX1HYyoyLQRcCKgmWfvuqzzzjiz/5Qir3B1A6fUEJAzq118dduC6CBzj/tyMkkcAA20a8bjlYiKKECuNa7FtLGqdZOWV+v2SJUMEygax1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397482; c=relaxed/simple;
	bh=IeUL45ltESSPRZHqbl47sBrkK1w+ehCnulgLBQYFeqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RKLUIkHrUDXB0Jrs1TysaDAq92PdD3cVFzfdTyHcKZlAlBT9Vi9qQCVfIqQzlvlviAf5MNtIlgIVYvzyxEaMunjjwOEBiZlt+lq5Eo0klTAe5Je6GA8JftSLXQQwgvR210/RMgotHHb9WANUxSdOmpar3CK2LCmtoGsQezQ02kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xuf7unSd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuf7unSd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bc61152d8so4487521b3a.2
        for <iwd@lists.linux.dev>; Tue, 05 Aug 2025 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397480; x=1755002280; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aM1fXaQLU8TTo0I+AdG/lETSmgcthYKZtAjGcZ328Q=;
        b=Xuf7unSdr/eSChiT57KvxR/4WoLzGqDCQ9htTTXEvynhQ0qGK11NTsRWVwO1EV5Mrt
         akMo4YlTnzVAEHYauhDYKzS3qmAPXOZZQAwUWgacXHm4xDmrr1NEIyhzGXWt20LAit15
         KZSgu6Ak3ZD6/OZKzlJD/QtCwE+RubPT5FLhoYGNkZwHssV1Rg4yZd68EgUM6gaJPcHX
         LqYt2YaXILkA3JdknFQq3MTxKzLVUEn9wyodd5rCGlQlkLe4yEBlKUl3oMC6UT/9H/ku
         vNmB6UMqCCg0XlYlgRR9RZukFiLBCFYCyzGHutIOAO1vbui3qEpBd3rPPWxcE6lrotH2
         sNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397480; x=1755002280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aM1fXaQLU8TTo0I+AdG/lETSmgcthYKZtAjGcZ328Q=;
        b=NoIxn6X7bcx/y9Bs2Bn4zVJX3mEVwWitg/AXxZht/25g+8baTWITPFkiE0SbtxyrcS
         +fgosE5qn1xCt8NQZQ/sHIncA7BlWOKiD/Hq4vKInCFZNNiX8IBKHpC/+ZjcNmE1orOM
         bC6dDrVQhpjGxjiHgkZg933k0GdnVvf64Yqsazl5SH/RlY/9LPEX+b19IrtWLNMPIA3O
         f/Z4EI3rN8PbivYWgzt+EOzuyDolwxk7zkzWWU1FnaBjisJ51h0xUxlPTvaC43PlPTjM
         8GFLdPbbP+7fXMsGyYzMCi+mDCdkLHEjO2sFEtIiG7NMeAbdtGImupM9acGKURm6Pnuf
         uG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkPt7PJFMubQ9gUFZ41eZMZH3bgSE/ifNKN8fGFvsHv3SpBIeaZpdtoUigXfRqn/sTVF4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyT0g7Seh/eWUlKk8k0obZWiiC5I1ioIBqagpdRlOcw9swXFeH5
	yQc+gsrjgqae+cDXGO8hj/Dxqm0mhN+ADEmhVCaCVppd+nFvywkpqNNGoxgb/Q==
X-Gm-Gg: ASbGncsu32Jd1Ldyb7a+2ZTFH8vOWe0qM1V2cFQznhys5YA7cs2Kxw1zwHNEJBYT8Sd
	+phDb+UYZlECZBmSkoZUhj2zdUqcUZl0YQxhdAAktIMYQ1M9s40yUAA85s3zWtpdhHfFX2YLv2k
	SNsfSg5IlIGdVvD9/A4YboEt7dnIvNtk3QJIooXRcJP1j7uDwDHm/ViAxVxLWdZA1xwp86JfjWT
	MnRgXZz9UexSBBud5+JzWIGZY6DSee4hTc0cKIh02tYITG/iI+GjUwieDQkNBI++9w8gC/cnNJb
	wgA6CVMsJwoC2P+0C9MlLPS32bac/MSzQr+ee1T7iBzXW6uS5uNPqJ2HgBz3PD2297x6n+OU2tP
	i6tp3qxiHNLnwBfjjKfY8D+CkpcnI7ViRHe1795vfDMjql/C8Pp81bqKcdXzqIXOswIYIcyOavs
	FA
X-Google-Smtp-Source: AGHT+IGHF/7ZYBSwJ33+ikPdSfB/eesSB58t809c3ZUrnhDwR1X8n+18wDgAHHko7DhvbPHPKH9NJQ==
X-Received: by 2002:a05:6a20:94cb:b0:239:c7c:8e05 with SMTP id adf61e73a8af0-23df90d3325mr18127832637.34.1754397479191;
        Tue, 05 Aug 2025 05:37:59 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd1a7sm12988211b3a.73.2025.08.05.05.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:37:58 -0700 (PDT)
Message-ID: <6ba5a330-717a-4a2d-956e-690c92309fad@gmail.com>
Date: Tue, 5 Aug 2025 05:37:57 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Received error during CMD_TRIGGER_SCAN: Operation not supported
 (95)
To: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzA3ZSfvbF51EC8H1JqHm+w1oW8WeRBvkeFVfSi4NhkGYA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzA3ZSfvbF51EC8H1JqHm+w1oW8WeRBvkeFVfSi4NhkGYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 8/3/25 3:59 AM, daniel antoine wrote:
> Hi
> I have a random problem when my laptop connects with my livebox by
> wifi. The connection works but takes some time 5 to 10 s to reach the
> online state. And from time to time this error is present Received
> error during CMD_TRIGGER_SCAN: Operation not supported (95). The wifi
> device is 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608)
> Wi-Fi 6E 80MHz . The linux-firmware package is the last version of
> linux-firmware 20250708. I have added the -d option to get the logs.
>
> août 03 11:52:29 grat-os1 iwd[476]: Received error during
> CMD_TRIGGER_SCAN: Operation not supported (95)
So after this you restart IWD and everything works after that? Or do you 
need to cycle the driver?
> août 03 12:34:22 grat-os1 iwd[476]: Terminate
> août 03 12:34:22 grat-os1 iwd[476]: Removing scan context for wdev 2
> août 03 12:34:22 grat-os1 iwd[476]: D-Bus disconnected, quitting...
> août 03 12:34:23 grat-os1 iwd[476]: Removing scan context for wdev 3
> août 03 12:34:23 grat-os1 systemd[1]: iwd.service: Deactivated successfully.
> août 03 12:34:37 grat-os1 iwd[476]: Wireless daemon version 3.9
> août 03 12:34:37 grat-os1 iwd[476]: src/main.c:main() Using
> configuration directory /etc/iwd
> août 03 12:34:37 grat-os1 iwd[476]:
> src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
> août 03 12:34:37 grat-os1 iwd[476]: src/main.c:nl80211_appeared()
> Found nl80211 interface
> août 03 12:34:37 grat-os1 iwd[476]: src/module.c:iwd_modules_init()
> août 03 12:34:37 grat-os1 iwd[476]: station: Network configuration is disabled.
> août 03 12:34:37 grat-os1 iwd[476]: src/wsc.c:wsc_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/udev.c:udev_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap.c:__eap_method_enable()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-wsc.c:eap_wsc_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-md5.c:eap_md5_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-tls.c:eap_tls_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-ttls.c:eap_ttls_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-mschapv2.c:eap_mschapv2_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-sim.c:eap_sim_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-aka.c:eap_aka_prime_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-aka.c:eap_aka_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-peap.c:eap_peap_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-gtc.c:eap_gtc_init()
> août 03 12:34:37 grat-os1 iwd[476]: src/eap-pwd.c:eap_pwd_init()
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 added (0)
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 2
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 2
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 4
> août 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_wiphy_dump_done()
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_filtered_wiphy_dump_done()
> août 03 12:34:37 grat-os1 iwd[476]: Wiphy: 0, Name: phy0
> août 03 12:34:37 grat-os1 iwd[476]:         Permanent Address: 50:c2:e8:0b
> août 03 12:34:37 grat-os1 iwd[476]:         2.4GHz Band:
> août 03 12:34:37 grat-os1 iwd[476]:                 Bitrates (non-HT):
> août 03 12:34:37 grat-os1 iwd[476]:                          1.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                          2.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                          5.5 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         11.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                          6.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                          9.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         12.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         18.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         24.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         36.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         48.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         54.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                 HT Capabilities:
> août 03 12:34:37 grat-os1 iwd[476]:                         HT40
> août 03 12:34:37 grat-os1 iwd[476]:                         Short GI for 20Mhz
> août 03 12:34:37 grat-os1 iwd[476]:                         Short GI for 40Mhz
> août 03 12:34:37 grat-os1 iwd[476]:                 HT RX MCS indexes:
> août 03 12:34:37 grat-os1 iwd[476]:                         0-15
> août 03 12:34:37 grat-os1 iwd[476]:                 HE Capabilities
> août 03 12:34:37 grat-os1 iwd[476]:                         Interface Types: ap
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Interface
> Types: station
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:         5GHz Band:
> août 03 12:34:37 grat-os1 iwd[476]:                 Bitrates (non-HT):
> août 03 12:34:37 grat-os1 iwd[476]:                          6.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                          9.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         12.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         18.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         24.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         36.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         48.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         54.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                 HT Capabilities:
> août 03 12:34:37 grat-os1 iwd[476]:                         HT40
> août 03 12:34:37 grat-os1 iwd[476]:                         Short GI for 20Mhz
> août 03 12:34:37 grat-os1 iwd[476]:                         Short GI for 40Mhz
> août 03 12:34:37 grat-os1 iwd[476]:                 HT RX MCS indexes:
> août 03 12:34:37 grat-os1 iwd[476]:                         0-15
> août 03 12:34:37 grat-os1 iwd[476]:                 VHT Capabilities:
> août 03 12:34:37 grat-os1 iwd[476]:                         Short GI for 80Mhz
> août 03 12:34:37 grat-os1 iwd[476]:                         Max RX
> MCS: 0-9 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max TX
> MCS: 0-9 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                 HE Capabilities
> août 03 12:34:37 grat-os1 iwd[476]:                         Interface Types: ap
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Interface
> Types: station
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:         6GHz Band:
> août 03 12:34:37 grat-os1 iwd[476]:                 Bitrates (non-HT):
> août 03 12:34:37 grat-os1 iwd[476]:                          6.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                          9.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         12.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         18.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         24.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         36.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         48.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                         54.0 Mbps
> août 03 12:34:37 grat-os1 iwd[476]:                 HE Capabilities
> août 03 12:34:37 grat-os1 iwd[476]:                         Interface Types: ap
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Interface
> Types: station
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> août 03 12:34:37 grat-os1 iwd[476]:         Ciphers: BIP-CMAC-256
> BIP-GMAC-256 BIP-GMAC-128 CCMP-256
> août 03 12:34:37 grat-os1 iwd[476]:                  GCMP-256 GCMP-128
> BIP-CMAC-128 CCMP-128
> août 03 12:34:37 grat-os1 iwd[476]:                  TKIP
> août 03 12:34:37 grat-os1 iwd[476]:         Supported iftypes: station
> ap p2p-client p2p-go p2p-device
> août 03 12:34:37 grat-os1 iwd[476]: udev interface=virbr0 ifindex=4
> août 03 12:34:37 grat-os1 iwd[476]: src/agent.c:agent_register() agent
> register called
> août 03 12:34:37 grat-os1 iwd[476]: src/agent.c:agent_register() agent
> :1.6 path /net/connman/iwd_agent
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_interface_dump_callback()
> août 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_get_interface_cb()
> août 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_get_interface_cb()
> août 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_interface_dump_done()
> août 03 12:34:37 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> (global) is FR
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_config_notify() Notification of command Del
> Interface(8)
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 17 on ifindex 3
> août 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_del_interface_cb()
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_create_interfaces() creating wlan0
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_create_interfaces() creating wlan0-p2p
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_config_notify() Notification of command New
> Interface(7)
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_new_station_interface_cb()
> août 03 12:34:37 grat-os1 iwd[476]:
> src/netdev.c:netdev_create_from_genl() Created interface wlan0[5 2]
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_config_notify() Notification of command New
> Interface(7)
> août 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_new_p2p_interface_cb()
> août 03 12:34:37 grat-os1 iwd[476]:
> src/p2p.c:p2p_device_update_from_genl() Created P2P device 3
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_set_4addr()
> netdev: 5 use_4addr: 0
> août 03 12:34:37 grat-os1 iwd[476]:
> src/netdev.c:netdev_initial_up_cb() Interface 5 initialized
> août 03 12:34:37 grat-os1 iwd[476]: event: state, old: disconnected,
> new: autoconnect_quick
> août 03 12:34:37 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
> août 03 12:34:37 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 1
> août 03 12:34:37 grat-os1 iwd[476]: src/rrm.c:rrm_add_frame_watches()
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:37 grat-os1 iwd[476]:
> src/manager.c:manager_config_notify() Notification of command Set
> Interface(6)
> août 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> août 03 12:34:37 grat-os1 iwd[476]:
> src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
> août 03 12:34:37 grat-os1 iwd[476]:
> src/station.c:station_quick_scan_triggered() Quick scan triggered for
> wlan0
> août 03 12:34:37 grat-os1 iwd[476]: udev interface=wlan0 ifindex=5
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 4
> août 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> août 03 12:34:37 grat-os1 iwd[476]:
> src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
> août 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> août 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:37 grat-os1 iwd[476]: src/station.c:station_autoconnect_start()
> août 03 12:34:37 grat-os1 iwd[476]: event: state, old:
> autoconnect_quick, new: autoconnect_full
> août 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_periodic_start()
> Starting periodic scan for wdev 2
> août 03 12:34:37 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
> août 03 12:34:37 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
> août 03 12:34:37 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
> août 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> août 03 12:34:37 grat-os1 iwd[476]:
> src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
> août 03 12:34:37 grat-os1 iwd[476]:
> src/scan.c:scan_periodic_triggered() Periodic scan triggered for wdev
> 2
> août 03 12:34:38 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> août 03 12:34:38 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:38 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> août 03 12:34:38 grat-os1 iwd[476]:
> src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
> août 03 12:34:40 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> août 03 12:34:40 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:40 grat-os1 iwd[476]: src/scan.c:scan_periodic_rearm()
> Arming periodic scan timer: 10
> août 03 12:34:40 grat-os1 iwd[476]:
> src/station.c:station_print_scan_bss() Processing BSS '10:e9:92:c with
> SSID: Livebox-5C, freq: 2462, rank: 591, strength: -4600, data_rate:
> 72.2, load: 17/255, clients: 0
> août 03 12:34:40 grat-os1 iwd[476]:
> src/station.c:station_add_seen_bss() Added new Network "Livebox-5C"
> security psk
> août 03 12:34:40 grat-os1 iwd[476]: src/station.c:station_autoconnect_start()
> août 03 12:34:40 grat-os1 iwd[476]:
> src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
> Livebox-5C
> août 03 12:34:40 grat-os1 iwd[476]:
> src/station.c:station_autoconnect_next() autoconnect: '10:e9:92' freq:
> 2462, rank: 591, strength: -4600
> août 03 12:34:40 grat-os1 iwd[476]:
> src/station.c:station_autoconnect_next() autoconnect:
> network_autoconnect: Operation not permitted (-1)
> août 03 12:34:40 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> août 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_periodic_timeout() 2
> août 03 12:34:50 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
> août 03 12:34:50 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> août 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> août 03 12:34:50 grat-os1 iwd[476]:
> src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
> août 03 12:34:50 grat-os1 iwd[476]:
> src/scan.c:scan_periodic_triggered() Periodic scan triggered for wdev
> 2
> août 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> août 03 12:34:50 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> août 03 12:34:50 grat-os1 iwd[476]:
> src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
> août 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
> notification New Scan Results(34)
> août 03 12:34:52 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_periodic_rearm()
> Arming periodic scan timer: 20
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_print_scan_bss() Processing BSS '10:e9:92:' with
> SSID: Livebox-5C freq: 5520, rank: 7093, strength: -4000, data_rate:
> 866.7, load: 11/255, clients: 4
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_print_scan_bss() Processing BSS '10:e9:92:' with
> SSID: Livebox-5C, freq: 2462, rank: 591, strength: -4600, data_rate:
> 72.2, load: 15/255, clients: 0
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_print_scan_bss() Processing BSS
> '6c:61:f4:68:f9:5d' with SSID: SFR_F958_5GHZ, freq: 5180, rank: 16,
> strength: -9200, data_rate: 2.0, load: 3/255, clients: 1
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_add_seen_bss() Added new Network "SFR_F958_5GHZ"
> security psk
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_print_scan_bss() Processing BSS
> '62:61:f4:68:f9:5f' with SSID: SFR_F958, freq: 5180, rank: 16,
> strength: -9300, data_rate: 2.0, load: 3/255, clients: 1
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_add_seen_bss() Added new Network "SFR_F958"
> security psk
> août 03 12:34:52 grat-os1 iwd[476]: src/station.c:station_autoconnect_start()
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
> Livebox-5C
> août 03 12:34:52 grat-os1 iwd[476]:
> src/station.c:station_autoconnect_next() autoconnect: '10:e9:92 freq:
> 5520, rank: 7093, strength: -4000
> août 03 12:34:52 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_rssi_update()
> août 03 12:34:52 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
> août 03 12:34:52 grat-os1 iwd[476]: event: connect-info, ssid:
> Livebox-5C, bss: 10:e9:92:, signal: -40, load: 11/255
> août 03 12:34:52 grat-os1 iwd[476]: event: state, old:
> autoconnect_full, new: connecting (auto)
> août 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_periodic_stop()
> Stopping periodic scan for wdev 2
> août 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_cancel() Trying to
> cancel scan id 3 for wdev 2
> août 03 12:34:52 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_done() Work item 3 done
> août 03 12:34:52 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 4
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification New Station(19)
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Authenticate(37)
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_authenticate_event()
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Associate(38)
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_associate_event()
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Connect(46)
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_connect_event()
> août 03 12:34:53 grat-os1 iwd[476]:
> src/netdev.c:netdev_connect_event() aborting and ignore_connect_event
> not set, proceed
> août 03 12:34:53 grat-os1 iwd[476]:
> src/netdev.c:netdev_connect_event() expect_connect_failure not set,
> proceed
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:parse_request_ies()
> août 03 12:34:53 grat-os1 iwd[476]:
> src/netdev.c:netdev_connect_event() Request / Response IEs parsed
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_get_oci()
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_get_oci_cb()
> Obtained OCI: freq: 5520, width: 3, center1: 5530, center2: 0
> août 03 12:34:53 grat-os1 iwd[476]: src/eapol.c:eapol_start()
> août 03 12:34:53 grat-os1 iwd[476]:
> src/station.c:station_handshake_event() Handshaking
> août 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_unicast_notify() Unicast notification Control Port
> Frame(129)
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_control_port_frame_event()
> août 03 12:34:54 grat-os1 iwd[476]:
> src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=5
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Control Port TX Status(139)
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_unicast_notify() Unicast notification Control Port
> Frame(129)
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_control_port_frame_event()
> août 03 12:34:54 grat-os1 iwd[476]:
> src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=5
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_gtk()
> ifindex=5 key_idx=1
> août 03 12:34:54 grat-os1 iwd[476]:
> src/station.c:station_handshake_event() Setting keys
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_tk()
> ifindex=5 key_idx=0
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_rekey_offload() 5
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_new_group_key_cb() ifindex: 5, err: 0
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
> 1, igtk_installed: 1
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Control Port TX Status(139)
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_station_cb()
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
> 1, igtk_installed: 1
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:try_handshake_complete() nhs->complete: 0
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:try_handshake_complete() Invoking handshake_event()
> août 03 12:34:54 grat-os1 iwd[476]:
> src/handshake.c:handshake_state_cache_pmksa() No PMKSA for
> 10:e9:92:c0:73:75
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_connect_ok()
> août 03 12:34:54 grat-os1 iwd[476]: src/station.c:station_connect_cb()
> 5, result: 0
> août 03 12:34:54 grat-os1 iwd[476]: src/station.c:station_connect_ok()
> août 03 12:34:54 grat-os1 iwd[476]: event: state, old: connecting
> (auto), new: connected
> août 03 12:34:54 grat-os1 iwd[476]:
> src/wiphy.c:wiphy_radio_work_done() Work item 4 done
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 5
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Frame TX Status(60)
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> août 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Frame TX Status(60)
> août 03 12:34:54 grat-os1 iwd[476]:
> src/station.c:station_early_neighbor_report_cb() ifindex: 5, error:
> 0()
> août 03 12:34:54 grat-os1 iwd[476]:
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> août 03 12:34:56 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:34:56 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-45)
> août 03 12:34:59 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:34:59 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-46)
> août 03 12:35:02 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:35:02 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-46)
> août 03 12:35:05 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:35:05 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-48)
> août 03 12:35:08 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:35:08 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-46)
> août 03 12:35:11 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:35:11 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-49)
> août 03 12:35:14 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:35:14 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-49)
> août 03 12:35:17 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> août 03 12:35:17 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-47)
> root@grat-os1:~#
>
> I have had some problem in the past with the command CMD_SET_CQM and
> patches has been installed to resolve it
>
> I will tried to get more information as the problem is really random
>
> Best regards
>
> Daniel
>
