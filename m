Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6D55E43
	for <iwd@lists.linux.dev>; Thu, 21 Dec 2023 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pl6/CyTQ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88568C0004;
	Thu, 21 Dec 2023 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703173603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vslzwAWqo1YYJpugQFn4ZQUgOped6tEgYWFfH0OfLYM=;
	b=Pl6/CyTQ3kBkA7C+l1S6+FiHx95MUUg/6xC+VM9MnF7UxxfaC1o3fuJhqzoQhiybNLP0Vx
	VHWinhvjH4kkHkTO3iH3vdNJBWGlVUgUfbFZXIc2PqD/Q8OCG1En8FQvQ1nKX2OdhsE2qR
	fjTmFGSCsO6DzyWCpnaMP4XNlw9PuzfPczVo6dmj6wERy6ju7WJLYuxOHRDG2Mxn4GJ8TI
	qhnrliRbyQF+Xr+iFVgHbw5c5rWVfkBbKqC9hNyCtHNf4tduJDpR4GhaUMd6UhvolFLGF+
	NjZNVcNZhVg7qTOkQ2jveZ5MoNHm9FKH3KMoN/WeY1tcu+ETjcuXB1NlZZ9ALA==
Message-ID: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
Date: Thu, 21 Dec 2023 16:46:43 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com, prestwoj@gmail.com,
 Salahaldeen.Altous@leica-camera.com
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Iwd: unable to start AP with NXP 88W9098 chipset
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: joaomarcos.costa@bootlin.com

Hello,

I hope this email finds you well.

I'm currently facing what seems to be the very same bug reported at 
https://lore.kernel.org/iwd/AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com/

As for my own context, I'm using:

- Ublox wifi module Jody-W377-00A

- IWD v1.26 (from meta-openembedded)

- Linux v6.1.68 (x86_64)

- NXP Wi-Fi driver for NXP 88W9098 chipset, from 
github.com/nxp-imx/mwifiex (branch=lf-6.1.55_2.2.0)

I followed the steps in https://iwd.wiki.kernel.org/ap_mode, and this is 
the error I get in my iwctl console:

# iwctl
NetworkConfigurationEnabled: enabled
StateDirectory: /var/lib/iwd
Version: 1.26
[iwd]# device muap0 set-property Mode ap
[iwd]# device list
Devices                                   *
--------------------------------------------------------------------------------
   Name                Address             Powered   Adapter Mode
--------------------------------------------------------------------------------
   uap0                62:09:c3:80:9b:1d   on        mwiphy0 ap
   mlan0              60:09:c3:80:9a:1d   on        mwiphy0 station
   muap0             62:09:c3:80:9b:1e   on        mwiphy1 ap
   mmlan0           60:09:c3:80:9a:1e   on        mwiphy1 station
[iwd]# ap list
                           Devices in Access Point 
Mode                        *
--------------------------------------------------------------------------------
   Name                Started
--------------------------------------------------------------------------------
   uap0                no
   muap0             no

[iwd]# ap muap0 start-profile testap
[iwd]# [22444.663032] wlan: Starting AP
[22444.668197] fw doesn't support 11ax
[22444.674130] CMD_RESP: cmd 0xb1 error, result=0x1
[22444.679286] IOCTL failed: 00000000ae152881 id=0x20000, sub_id=0x20001 
action=1, status_code=0x1
[22444.689145] woal_cfg80211_add_beacon: start uap failed
Operation failed

My /var/lib/iwd/ap/testap.ap file is identical to the one provided in 
the Wiki, and as for my main.conf:

---

[General]
EnableNetworkConfiguration=true
UseDefaultInterface=true

[Network]

[Scan]
DisablePeriodicScan=true

---

I tried adding Country=FR and ControlPortOverNL80211=false, but without 
any success.

I also added DisableHT=true in the testap.ap file later on, but the 
result was the same.

However, I was able to start the Access Point using hostapd, and it 
worked fine.

I can provide you with my hostapd.conf, if you find it pertinent.


Since referencing the original thread, are there any updates?

Has anyone else encountered a similar issue? Even if the chipset is not 
precisely the same.

Please feel free to ask for logs or other unmentioned details, and thank 
you for your assistance.

-- 
Best regards,
João Marcos Costa

