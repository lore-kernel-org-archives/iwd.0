Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98C19750B
	for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691284; cv=none; b=LQe4ko95cozwgnVbmwBxY0Ot2WEn1CYxAK0xHXjZ05ffpdDeelMJQLsipWJjASxNT1xYCq1C6KS5lpvUZVJLM+H16xDsNFocilTQENScSnf940ZjLQnmZ8LNIO+Ii8DTbOkEmUOzDrFQKUgyEs59oeIID3N3EXTiRnEDnc7HD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691284; c=relaxed/simple;
	bh=aH2qttuGMrScajbyCcZLL212ugwm5JmecTVYdCq/v6I=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j9afw8k8sbi+wDvV5c+n/zfxF0fwyWf6f2iksR/QSrVfoiyNXCrGRYNApKEJtbcVpwHobdAxWp5O1+Njv1CHQV1rJyEjQXnDBvqvBS9XwIFgB4nrX5l6t0M2lu2e3bGvmsPc4ZByjsuZcPLEcDIsp8SBJBJ80P0dQdjn6a482nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hN1YkpW9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hN1YkpW9"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f50ca18a13so17597481fa.1
        for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724691281; x=1725296081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8nKuFEZPw2THCfHRIyPfnP2hhoiw0AHChWyrzvAYRE=;
        b=hN1YkpW9Fk0ct1VMIr9btx2Bd7M8OspQGbjG0V0qo+9aR8fb3fFxczdXNnaKzT2SqR
         Qj5l9GleYW3g9A0J/IbjmBlq/XgI4H3UIFF2fmzFA5aU3CrKUXu254Jh4gnrRLuGwF2x
         OuNicTgeNxECjplDctxBtqSlV0XHDTviS3FSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691281; x=1725296081;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8nKuFEZPw2THCfHRIyPfnP2hhoiw0AHChWyrzvAYRE=;
        b=QXnyB91yger2n9NncAx2ygdt/p/JBMZ+jWFiBwAqRfTlhS8WgeZPCmD8+kH+N0zDxr
         SpRjuiBCWJs56svpmBLmVwOwvYXikwEZLm63kgpwgC/GybSe2kmHGKmm0BOdHICPuogc
         sq4BgfHG1oCg6fUN+HSfx4Rs0ZedvQ/93uc5eiEo5UKk5Vj8XrPQeVVi7CJKGb5/etI7
         YPbhr9CC5tg0rWlqtBM15ZqwQqyvQZDL+np6zC9FM92mAUUkAvHneQTpurqL1RUis9A2
         1nYrGSsH3GVzE50Dkj9ImUOO1j+rzdpGYnCWNvL3AplVo7OkuRHO5Z0/zk3pJ1PNUvQZ
         e86g==
X-Gm-Message-State: AOJu0YwEdJ7zcRCIDVBuJcaOSmJoS1iI/9Um4caylpENuqkG6ebwzAjy
	60o27ohsVL05OCjNIi963kuO44Anj/M85vGmJpC/EnE0gHTKSr17fVv9QMEESg==
X-Google-Smtp-Source: AGHT+IHa/yj47aRfADrtULkcTjyuWOcDZnRvVtpDun6d/0Vp8PMOLaYCCj6LueVIG74GWuCQr7E9Vw==
X-Received: by 2002:a2e:3207:0:b0:2f1:929b:af03 with SMTP id 38308e7fff4ca-2f4f5797917mr55178801fa.30.1724691280022;
        Mon, 26 Aug 2024 09:54:40 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c6ce9sm5823939a12.72.2024.08.26.09.54.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:54:39 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Denis Kenzior <denkenz@gmail.com>, KeithG <ys3al35l@gmail.com>
CC: <iwd@lists.linux.dev>, James Prestwood <prestwoj@gmail.com>
Date: Mon, 26 Aug 2024 18:54:37 +0200
Message-ID: <1918f9c64c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <93c94dfc-2121-4b7d-b069-8b6ce22290fb@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
 <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com>
 <CAG17S_P615tCPt0Jy+-BLzFx0N9JiksVXdUj4-iRAA9JTWdotg@mail.gmail.com>
 <CAG17S_Oe0_DnVZW32GrArC9XCQUHh3QEYXxvXatWQiuwV5_QkA@mail.gmail.com>
 <93c94dfc-2121-4b7d-b069-8b6ce22290fb@gmail.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [RFC PATCH v1 0/2] External Auth support
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 26, 2024 5:43:23 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Keith,
>
>>>
>>> iwctl looks like it is trying something:
>>> [iwd]# station wlan0 connect deskSAE
>>> Type the network passphrase for deskSAE psk.
>>> Passphrase: *********
>>> [iwd]#
>>>
>>> but it never connects. I do notice that connman thinks it is up and
>>> assigns a 169.254.x.x address
>>>
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
>>> is WPA3-Personal...
>>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
>>> brcmfmac using SAE.  Expect EXTERNAL_AUTH
>>> Aug 24 11:18:06 pi5 iwd[28085]:
>>> src/network.c:network_generate_sae_pt() Generating PT for Group 19
>>> Aug 24 11:18:06 pi5 iwd[28085]:
>>> src/network.c:network_generate_sae_pt() Generating PT for Group 20
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
>>> is WPA3-Personal...
>>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
>>> brcmfmac using SAE.  Expect EXTERNAL_AUTH
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_cqm_rssi_update()
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_insert()
>>> Inserting work item 4
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_next()
>>> Starting work item 4
>>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, ssid: deskSAE,
>>> bss: d8:3a:dd:60:a3:0c, signal: -63, load: 0/255
>>> Aug 24 11:18:06 pi5 iwd[28085]: event: state, old: autoconnect_full,
>>> new: connecting
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/scan.c:scan_periodic_stop()
>>> Stopping periodic scan for wdev 1
>>> Aug 24 11:18:06 pi5 iwd[28085]: CMD_SET_CQM failed: Operation not supported
>>> Aug 24 11:18:06 pi5 connmand[635]: Interface wlan0 [ wifi ] state is
>>> configuration
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
>>> Unicast notification External Auth(127)
>>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, External Auth to
>>> SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
>>> Aug 24 11:18:06 pi5 iwd[28085]:
>>> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
>>> notification Frame TX Status(60)
>>> Aug 24 11:18:06 pi5 iwd[28085]:
>>> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
>>> Unicast notification Frame(59)
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
>>> notification Frame TX Status(60)
>>> Aug 24 11:18:06 pi5 iwd[28085]:
>>> src/netdev.c:netdev_external_auth_sae_tx_associate()
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
>>> Unicast notification Frame(59)
>>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_external_auth_cb()
>>> Failed to send External Auth: Invalid exchange(52)
>
> You're seeing the exact broken behavior I'm seeing.  To summarize:
>
> - IWD issues CMD_CONNECT
> - Firmware/Kernel sends CMD_EXTERNAL_AUTH to iwd
> - IWD performs SAE handshake using CMD_FRAME successfully
> - IWD sends CMD_EXTERNAL_AUTH with a success status_code to kernel/firmware
> - Kernel/Firmware rplies with error 52, Invalid Exchange.
>
>>> Aug 24 11:18:06 pi5 kernel: ieee80211 phy0:
>>> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=-52
>>> Aug 24 11:18:46 pi5 connmand[635]: Interface wlan0 [ wifi ] state is ready
>>> Aug 24 11:18:46 pi5 connmand[635]: wlan0 {add} address
>>> 169.254.242.107/16 label wlan0 family 2
>>>
>>>
>>> Need a log of some sort or is this adequate?
>
> No.  We need someone who can tell us how this firmware is supposed to operate.
> Perhaps Arend can help?

Hi Denis,

Perhaps I can. I am working on porting/implementing this for upstream 
linux. I guess this is running an Infineon downstream kernel, right? If 
brcmfmac is compiled with CONFIG_BRCMDBG you can load the driver with debug 
module param, ie.:

# modprobe brcmfmac debug=0x5416

That will log some more details. Error -52 is generic code that something 
went wrong in communication with firmware. The debug level above will among 
other things show the actual firmware error code. Another interesting thing 
shown are the firmware capabilities which can also be examined through debugfs.

Regards,
Arend


