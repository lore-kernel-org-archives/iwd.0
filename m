Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8813064
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 16:58:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4Qr9s74Kqcz9vN3;
	Tue, 27 Jun 2023 18:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1687885115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw+VIp5zgjOS8q4RWwzCV46RhjBWwbYaB0zZ89qG6FE=;
	b=K3OpDXTzbDEXwF2dtJMEyX10lnV0wTOLk5brwFmMuEH0xi3aT0tr8H9ZMTzGXHVu3h+xiv
	NtbyBfxVYAQn/oLONn2UBBkrUQjSmtmQQuposAtfMFkAhiSj1uenscTl67DaYh50NzUXML
	Okve+or5Qc0ebrrV5skFiLjyEGKMV4m+1mGLEJDGo4ZAuryK9thgLazvCEXbux1C7wOOnh
	iIpGz5TilC2YSAkn6paSlXaMPcne2+tshQiE2VyEbb1PzDTKuv1G/ZDcEn6bvhIv3aar/A
	FDXwbxgSLDy4C+AiYXNQmdauCBb9//NkQhKlvXUznWQYfh4IdgKtvnC5C0Y8nw==
Message-ID: <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
Date: Tue, 27 Jun 2023 18:58:34 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: iwd forgets network
Content-Language: en-GB
To: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 James Prestwood <prestwoj@gmail.com>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Qr9s74Kqcz9vN3

Hi James,

Am 27.06.23 um 17:29 schrieb James Tavares:
> Martin,
>   
> You mentioned a possible power loss in your testing. If iwd is not performing an fsync() after joining the network and writing the SSID configuration file, then there is a small window of time (between when the file is written and when the filesystem is next synced) when the file can easily go missing if power is lost.
>   
> If the file is newly created, then it could disappear entirely on power loss. If the files contents were overwritten, then it might revert to the old contents on power loss.
>   
> Perhaps this explains your issue.  I can’t tell you how many times I have been bitten by this in embedded Linux designs.

Thanks, we have also experience with this. ext4 is quite a good choice 
here. In general we feel safe. Also I was talking about re-powering the 
router.

Our device has seen a lot of power losses without any issue. But of 
course it could be also something in this direction.

However, this configuration file was existing since two or three weeks 
at this place. And then gone.

Does IWD change or write to the configuration files? Timestamps?

When does IWD decide to maybe (delete and) create the state directory?

Could it be a race-condition with the bind-mounts?

At the moment it is not easy for me to add debug code to the source, as 
we use Debian packages and don't build these components from source...

Thanks,

Martin

