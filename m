Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F941373
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 08:07:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4QqxsT1Nzyz9vM8
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 09:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1687852685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AxmG3S3y0Iia6Sqn6IDqJvVCg8xP0vLCsHj7xKRIH9Y=;
	b=ixIOBKUMyrshohQDMFn3ohIh8VgYPcQ3hYDflW1/PHRlaRJ1n3089FitgnG9tCiBvlN3Lq
	Z/CNP0XLg3C0FKSNdImFH4zbYCiyUIzuJpcGkUGUMBRzTYOLO+2F3ChIFP0kwYW3CRGx+N
	bY7vi8uccfc/f0Vyr6fBXtlWn8s1mj25YIGTqTrLGJ8yNeHvF3ia47bvmshwCZXYFrK65L
	Ch5pwSCZN8nv3ETf9qeepg7XO63Yi1Vu/B4vQUXWcU6icEGn4ISlpZWOKLpU5iDYkrSQBx
	YI0XmkeAPfDjTPcHMiITpj5qPRcOKW3iHn37qhmIZJABtkX8I9tICkv1R71YKQ==
Message-ID: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
Date: Tue, 27 Jun 2023 09:58:04 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: iwd@lists.linux.dev
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: iwd forgets network
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a critical issue with iwd and kindly ask for feedback.

We have an embedded device (no desktop) running Debian bullseye with 
custom 5.10.52 kernel (NXP patches; own configuration).

We are using iwd 1.27-1~bpo11+1 from bullseye backports together with 
systemd from bullseye main.

We use a bind mount to move the iwd state to a separate partition, 
because we do rootfs upgrades and want to keep the state.

Yesterday and also once before our platform forgot a network (the *.psk 
file was gone). We did not call any command for this. As far as we can 
re-call we did not reboot the platform. Some time before this issue, we 
pulled the power of our router and the network was of course gone - back 
a few minutes later. I have no idea if this could be related or just 
co-incidence.

Here are our configuration files:

########## /etc/systemd/network/20-wlan0.network

[Match]
Name=wlan0

[Network]
DHCP=yes

IgnoreCarrierLoss=3s

[DHCPv4]
RouteMetric=20

########## /etc/iwd/main.conf

[General]
UseDefaultInterface=true

[Network]
NameResolvingService=systemd

########## /usr/lib/systemd/system/var-lib-iwd.mount

[Unit]
Description=Mount IWD state

[Mount]
What=/system/var/lib/iwd
Where=/var/lib/iwd
Type=none
Options=bind

[Install]
WantedBy=local-fs.target

##########

Thanks,

Martin

