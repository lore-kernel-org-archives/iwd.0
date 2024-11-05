Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393754D8D0
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830457; cv=none; b=X3PkMFE0b02kvxFKTJinFs4SefllWPqURt+WLWHi/n6hyeB2hAVjALckpRFChB6bijrYAIlDfdq74SQoIZROXSjunRSvtKU6/dWJIzdRhjw+G+k1FXekfZwD6Tc/yn2sl1rYNQzvKFJaA3HahsbAravA+99p+K8OqX17df25v2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830457; c=relaxed/simple;
	bh=ipfavIGN9TIChx1ZdPKIrGyRj0eb3M8LUfSZS0RXFFE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hPZRdCKrL0kEWL2wtQS7HXHD1V6tTJZFBRHMnZVGKyeBDnC/6HScP3Ng46U6nsEKazZTcKcPfjd93TobL1xVnKiDOjsL1C//ISkopzdooJxGwImGUb7Kq2VIXn0ikeRiCi0ypoKQrYexf6MSsPfcxOdByvTQ1jn8j3PCLulR+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=Y/aLPaid; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="Y/aLPaid"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4Xjc0q6YdLz9tmL
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 19:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730830443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=On1YcW/bdyJUAvJJgeIUIiZatlqj/OtML2QQY2tLKrY=;
	b=Y/aLPaiduNcAqCy2xIabtnxkcKLLUYIc2Ch9ZpG698msCcKhZtEoDihDeTu0elIzhkzFHM
	6xM2AGZnoGXm3Y0FGPgcIPphmXToyf+QGa/0FVF48dJxkQEjurU9g97fVAr8YENY31O3sB
	jBYw2m4uZY2QpU79MbB/p6SQVReaKJrhYSxST/AkbuSnxeMi8/iXynt/vMYhhKYpTvULOm
	MlGj3xC4Wcr/14cIsos2EVg7ZVBBB31Xi9AdyHJt+7nZxgg8kXdPimC34VCKlyVcFf+L6J
	Ku1rNI2yIhaxsJ6ZgeLg/BaBzB3pvMiE5+sYiA9PB4TNjEhs9Boifkx8rUXI/Q==
Message-ID: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
Date: Tue, 5 Nov 2024 19:14:02 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: iwd@lists.linux.dev
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: timesync when using IWD stand-alone
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Xjc0q6YdLz9tmL

Hi all,

if I configured my Ethernet interface via systemd-networkd and there is 
NO carrier (no cable connected). But my wifi is configured, managed and 
connected by IWD (EnableNetworkConfiguration=true). In a typical case 
there is no other NTP server configured in timesyncd.conf. How will 
systemd-timesyncd sync the system time?

According to the documentation "during runtime [the] list is combined 
with any per-interface NTP servers acquired from 
systemd-networkd.service(8)". However, systemd-networkd ONLY acquired 
the default NTP server from the router (gateway) via Ethernet and 
according to DHCP response (because networkd does not manage wifi), right?

Could it then happen that no NTP server is available?

I ask, because on some networks port 123 is blocked (e.g. on a FritzBox 
wifi guest network). In this case - as far as I understand - only the 
router (FritzBox) itself is available as a valid NTP server. But what if 
this one is not known, because networkd does not know about the IWD DHCP 
NTP propagation?

Thanks,

Martin

