Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AF56451
	for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182875; cv=none; b=f4TkCcxU3eLBDOIZ5/rvqDFiMhEbvIWFB3NDi1AG3KRF/Fh523uFuBquMaM/0gHNTZBt+s/tStCCa76bZC6bW5n7A59YTmIxyh85p/LMAtg6yAA6xU1OT2ggNR0E464oSqntxIKrf91bqurmlYWhO4cQR+r65FVzgnG/i7k8eVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182875; c=relaxed/simple;
	bh=uZDc/uv9VenbrYa/CfQ0KKTc3foXJ2g1zI0uhPoZJ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N82o2bz1g7wwxiHl9ydT33dFxN3YOSR0btkBJZOEX9ir2iAxNQqOfIvVOfbIqWE2VJ/Mu6EEH4VAqy6OVFFMUWv5ybQsyhvgh+ok7Wgu1johIsakCm0rS9ucJ9MFge6hW67uc4EVqHDMGC7pyHsGOsJtNaCACag0wkaqRP/Mq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=SQfoC7tS; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="SQfoC7tS"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4Ttlv565rxz9tZj;
	Mon, 11 Mar 2024 19:40:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1710182401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXYbv5xzuu636rpJCAvzCPHryQgMyrOIoY0o5kOw1cc=;
	b=SQfoC7tS6JmLIFIiEdqHL/BbvCv/fata0gxeiSiwr64oWw/Sc5Zm+0T/yDpyVd95pSevWf
	pY+9lkGsL4A/F5Gjv+pQiWAmd/gpdrwSxVpG0ybYt6Y74gfiHyhbwbeS6Bhbau3HzgsS4X
	9EeRekdDE5ltiwC9MCmNol1Idwmf0R/rvbbc0bfzfsphsfs214SrpydA39OjM64vSvBBeh
	3bax04uNx6mPkJ1B4W7Ss05/JZFSckS38/HYJN6gHvzXkCap8aS6tz/iV9zjurHncK3UXp
	vAvjpWvyb5HI8XnXuVPOUjioi5VfvPUxrCCggeMCdDdcJQyoc4XLsAcZXMli1A==
Message-ID: <8405c408-5f80-4f3a-a27c-cc4687632367@tavla.de>
Date: Mon, 11 Mar 2024 19:40:00 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Using bind mount for /var/lib/iwd results in zero directory (and
 no links) and no connections stored
Content-Language: en-GB
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: iwd@lists.linux.dev
References: <07009e2a-3ad7-4a8c-bcbf-a665a19bd03f@tavla.de>
 <26f4ecf5-2f67-43f4-b197-9caea5ce9319@tavla.de>
 <CADXxVSKSA66S+PJLrdZV5mvHn+dYjFJ7K8E=YMNfiUfTHv46+g@mail.gmail.com>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <CADXxVSKSA66S+PJLrdZV5mvHn+dYjFJ7K8E=YMNfiUfTHv46+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

My solution in a systemd service is now:

ExecStart=-/usr/bin/bash -c '/usr/bin/rm --recursive --force 
/var/lib/iwd/{*,.*}'
ExecStart=-/usr/bin/systemctl restart iwd

# bash is required for '{*,.*}'

Am 11.03.24 um 19:19 schrieb Bryce Johnson:
> Hi Martin,
>
>> Is there an iwctl command to drop / forget ALL existing connections?
>>
>> #####
> I would be interested if there was a way to do it with iwctl, but I
> have a python script I use to forget all wifi networks, Here is the
> important part:
>
> #!/usr/bin/python3
>
> import dbus
>
> bus = dbus.SystemBus()
>
> try:
>      # IWD forgot section: based on
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test/list-known-networks
>      manager = dbus.Interface(bus.get_object('net.connman.iwd', '/'),
>                              'org.freedesktop.DBus.ObjectManager')
>
>      for path, interfaces in manager.GetManagedObjects().items():
>          if 'net.connman.iwd.KnownNetwork' not in interfaces:
>              continue
>
>          network = interfaces['net.connman.iwd.KnownNetwork']
>
>          obj = dbus.Interface(bus.get_object('net.connman.iwd', path),
>                              'net.connman.iwd.KnownNetwork')
>          obj.Forget()
>
>          print("%s network forgotten in IWD" % network['Name'])
>
>
> except:
>      print("Skipping IWD forget network")
>      pass
>
